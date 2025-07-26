package;

import flixel.FlxG;
import flixel.FlxGameState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.line.FlxSideLine;
import flixel.gwebdev.ParticleEmitter;
import flixel.gwebdev.ParticleEmitterData;
import flixel.util.helpers.FlxRangeBounds;
import flixel.gwebdev.ParticleSystem;
import flixel.gwebdev.addons.TrailedBulletSystem;
import flixel.gwebdev.addons.ParticleSystemEmitterArgs;
import flixel.gwebdev.math.util.MathUtils;
import flixel.gwebdev.addons.PlayerOverlapGroup;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.Assets;

using StringTools;

class PlayState extends FlxGameState
{
	public var cam:FlxCamera;
	public var playerCam:FlxCamera;
	public var particleCam:FlxCamera;
	
	public var player:Player;
	
	public var playerVel:Float = 700;

	public var objects:FlxTypedGroup<Object>;
	
	public var gravity:Float = 1;
	public var friction:Float = 0.06;
	public var force:Float = 1.7;
	
	public var line:FlxSideLine;

	public var particleSystem:ParticleSystem;
	
	public var Timer:Float = 0;
	
	public var bulletSystem:TrailedBulletSystem;
	
	public var upBound:Object;
	public var downBound:Object;
	public var leftBound:Object;
	public var rightBound:Object;

	public var overlapGroup:FlxSpriteGroup;

	override public function create()
	{
		cam = new FlxCamera();
		playerCam = new FlxCamera();
		playerCam.bgColor.alpha = 0;
		particleCam = new FlxCamera();
		particleCam.bgColor.alpha = 0;

		FlxG.cameras.reset(cam);
		FlxG.cameras.add(playerCam);
		FlxG.cameras.add(particleCam);
		
		FlxCamera.defaultCameras = [cam];
		
		objects = new FlxTypedGroup<Object>();
		add(objects);
		
		var pSize:Int = 100;
		
		player = new Player(FlxG.width / 2, FlxG.height / 2, pSize, pSize, 0xFF0081B4);
		player.cameras = [playerCam];
		add(player);
		
		var newObj:Object = new Object(FlxG.width / 2, FlxG.height / 3, 200, 100);
		objects.add(newObj);
		
		//var newObj2:Object = new Object(800, FlxG.height / 2, 40, Math.round(FlxG.height * 0.3));
		//newObj2.y -= newObj2.height / 2;
		//objects.add(newObj2);
		
		var newObj3:Object = new Object(0, FlxG.height, FlxG.width, Math.round(FlxG.height / 4));
		newObj3.y -= newObj3.height;
		objects.add(newObj3);
		
		line = new FlxSideLine(5, Math.round(pSize * 2.5), FlxColor.GREEN);
		add(line);

		particleSystem = new ParticleSystem();
		particleSystem.cameras = [particleCam];
		add(particleSystem);
		
		bulletSystem = new TrailedBulletSystem();
		add(bulletSystem);
		
		/*trailedBullet = new TrailedBullet(FlxG.width / 2, FlxG.height / 2, 10, 10, 1, 1, FlxColor.WHITE, null, 20, 1, 0.3, 0.01);
		add(trailedBullet);*/
		
		var widthInt:Int = Math.round(FlxG.width);
		var heightInt:Int = Math.round(FlxG.height);
		upBound = new Object(0, -FlxG.height, widthInt, heightInt);
		downBound = new Object(0, FlxG.height, widthInt, heightInt);
		leftBound = new Object(-FlxG.width, 0, widthInt, heightInt);
		rightBound = new Object(FlxG.width, 0, widthInt, heightInt);
		objects.add(upBound);
		objects.add(downBound);
		objects.add(leftBound);
		objects.add(rightBound);
		
		overlapGroup = new FlxSpriteGroup();
		overlapGroup.cameras = [playerCam];
		trace(Assets.idPath('stupidenemy'));
		createOverlap(player, FlxColor.WHITE, Assets.idPath('stupidenemy'));
		add(overlapGroup);

		super.create();
	}
	
	public function createOverlap(player:FlxSprite, color:FlxColor = FlxColor.WHITE, ?image:FlxGraphicAsset, ?specificWidth:Int, ?specificHeight:Int):Void
	{
		var newSprite:FlxSprite = new FlxSprite();
		var pWidth:Int = Std.int(player.width);
		var pHeight:Int = Std.int(player.height);
		var toUseWidth:Int = specificWidth != null ? specificWidth : pWidth;
		var toUseHeight:Int = specificHeight != null ? specificHeight : pHeight;
		if (image != null)
		{
			newSprite.loadGraphic(image);
			var imgWidth:Int = specificWidth != null ? specificWidth : pWidth;
			var imgHeight:Int = specificHeight != null ? specificHeight : pHeight;
			newSprite.setGraphicSize(imgWidth, imgHeight);
			newSprite.updateHitbox();
		}
		else
			newSprite.makeGraphic(toUseWidth, toUseHeight, color);
		newSprite.color = color;
		var sprWidth:Int = Std.int(newSprite.width);
		var sprHeight:Int = Std.int(newSprite.height);
		if (sprWidth > pWidth)
		{
			newSprite.setGraphicSize(pWidth, sprHeight);
			newSprite.updateHitbox();
			sprWidth = pWidth;
			sprHeight = Std.int(newSprite.width);
		}
		if (sprHeight > pHeight)
		{
			newSprite.setGraphicSize(sprWidth, pHeight);
			newSprite.updateHitbox();
			sprHeight = pHeight;
			sprWidth = Std.int(newSprite.height);
		}
		newSprite.x += (pWidth - sprWidth) / 2;
		newSprite.y += (pHeight - sprHeight) / 2;
		newSprite.antialiasing = true;
		overlapGroup.add(newSprite);
	}

	override public function update(elapsed:Float)
	{
		var updateFramerate:Float = FlxG.updateFramerate;
		
		Timer += 1 / updateFramerate;
		
		var vel:Float = playerVel / updateFramerate;
		var velX:Float = 0;
		var velY:Float = 0;

		var xKeys:Array<Bool> = [Controller.LEFT, Controller.RIGHT];
		var yKeys:Array<Bool> = [Controller.UP, Controller.DOWN];
		var lMouseKeys:Array<Bool> = [Controller.M1, Controller.M1_JP, Controller.M1_JR];
	
		/*if (yKeys[0] && velY == 0)
			velY += -vel;
		if (yKeys[1] && velY == 0)
			velY += vel;*/

		if (xKeys[0] && velX == 0)
			velX += -vel;
		if (xKeys[1] && velX == 0)
			velX += vel;
			
		velY += gravity * vel;
		
		var daMidX:Float = player.midpointX;
		var daMidY:Float = player.midpointY;
		
		var jumped:Bool = Controller.UP_JP;
		
		if (jumped && player.canJump)
		{
			gravity = -force;
			playSound('jump');
			var sp:Float = 2;
			var pSize:Int = 5;
			var id:String = 'jumpemitter' + Timer;
			// trace(id);
			particleSystem.createEmitter(id, daMidX, player.Y + player.height / 1.75, 0, 0.4, pSize, pSize, 1, 1, FlxColor.CYAN, null, FlxPoint.get(0.5, 0.5), new FlxRangeBounds(-sp, 0.5, sp, 1), ALPHA, 10, true, 0, 0);
		}

		player.Y += velY;
		player.X += velX;
		
		gravity += friction;
		
		if (gravity > 1)
			gravity = 1;
			
		objects.forEachAlive(
			function(obj:Object)
			{
				player.collide(obj, velX, velY);
				bulletSystem.collideAll(obj);
				/*bulletSystem.collideAll(upBound, velX, velY);
				bulletSystem.collideAll(downBound, velX, velY);
				bulletSystem.collideAll(leftBound, velX, velY);
				bulletSystem.collideAll(rightBound, velX, velY);*/
			}
		);
		
		if (jumped)
			player.canJump = false;
		
		if (player.X + velX + 1 > FlxG.width)
			player.X = -player.width + 1;
		if (player.X + player.width + velX - 1 < 0)
			player.X = FlxG.width - 1;
		/*if (player.Y + velY + 1 > FlxG.height)
			player.Y = FlxG.height - player.height - 1;
		if (player.Y + player.height + velY - 1 < 0)
			player.Y = 1;*/

		line.x = daMidX - line.width / 2;
		line.y = daMidY;
		line.angle = player.angleBetweenMouse();

		if (lMouseKeys[1])
		{
			playSound('shoot');
			var spShit:Float = 10;
			var bSize:Int = 10;
			var pSizeShit:Int = 5;
			var pSpeed:Float = 4;
			var daEmitterData:ParticleEmitterData = { lifeSpan: 0.3, width: pSizeShit, height: pSizeShit, scaleX: 1, scaleY: 1, color: FlxColor.RED, image: null, alphaRange: FlxPoint.get(1, 1), speedRange: new FlxRangeBounds<Float>(-pSpeed, -pSpeed, pSpeed, pSpeed), destroyType: ALPHA, explode: true, freq: 0, delay: 0 };
			
			
			bulletSystem.setBulletData(
			true,
			daMidX,
			daMidY,
			player.getVelocityFromAngleBetweenMouse(spShit, spShit),
			bSize,
			bSize,
			1,
			1,
			FlxColor.RED,
			null,
			20,
			1,
			0.3,
			0.01,
			daEmitterData,
			10
			);
			bulletSystem.spawnBullet('bulletShit' + elapsed);
			
			/*
			for (i in 0...8)
			{
				var deg:Float = (i + 1) * 45;
				bulletSystem.setBulletData(
				true,
				daMidX,
				daMidY,
				MathUtils.velocityFromDeg(spShit, spShit, deg),
				bSize,
				bSize,
				1,
				1,
				FlxColor.RED,
				null,
				20,
				1,
				0.3,
				0.01,
				daEmitterData,
				10
				);
				bulletSystem.spawnBullet('bulletShit' + elapsed + '' + i);
			}
			*/
		}
		
		// var daVel:FlxPoint = player.getVelocityFromAngleBetweenMouse(5, 5);
		
		// trace('x: ' + daVel.x + ' | y: ' + daVel.y + ' angle: ' + player.angleBetweenMouse());
		
		for (psArgs in bulletSystem.queuedParticles)
		{
			playSound('shoot');
			bulletSystem.queuedParticles.remove(psArgs);
			particleSystem.createEmitter(
			psArgs.id,
			psArgs.x,
			psArgs.y,
			psArgs.m,
			psArgs.lifeSpan,
			psArgs.width,
			psArgs.height,
			psArgs.scaleX,
			psArgs.scaleY,
			psArgs.color,
			psArgs.image,
			psArgs.alphaRange,
			psArgs.speedRange,
			psArgs.destroyType,
			psArgs.count,
			psArgs.explode,
			psArgs.freq,
			psArgs.delay
			);
		}
		
		overlapGroup.x = player.X;
		overlapGroup.y = player.Y;
		
		super.update(elapsed);
	}
}
