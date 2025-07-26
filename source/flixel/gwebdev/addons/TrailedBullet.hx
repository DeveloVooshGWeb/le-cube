package flixel.gwebdev.addons;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.gwebdev.ParticleEmitterData;
import flixel.math.FlxPoint;
import flixel.util.helpers.FlxRangeBounds;

import flixel.gwebdev.values.DefaultValues;

typedef TrailedBulletGroup = FlxTypedSpriteGroup<TrailedBullet>;

class TrailedBullet extends FlxTypedSpriteGroup<FlxTypedSpriteGroup<FlxSprite>>
{
	public var prevX:Float = Math.NaN;
	public var prevY:Float = Math.NaN;

	public var X:Float = 0;
	public var Y:Float = 0;

	public var trail:FlxTrail;
	public var sprite:FlxSprite;
	public var spriteGroup:FlxTypedSpriteGroup<FlxSprite>;
	
	public var id:String = "bullet1";
	public var shouldKill:Bool = false;
	
	public var emitterData:ParticleEmitterData = DefaultValues.defaultEmitterData;
	public var particleCount:Int = 1;
	
	public var useParticles:Bool = false;
	
	public var vel:FlxPoint;
	
	public function new(particles:Bool = false, x:Float = 0, y:Float = 0, vel:FlxPoint, width:Int = 0, height:Int = 0, scaleX:Float = 1, scaleY:Float = 1, color:FlxColor = FlxColor.WHITE, ?image:FlxGraphicAsset, particles:Bool = false, len:Int = 10, del:Int = 3, alp:Float = 0.4, diff:Float = 0.05)
	{
		super();
		
		useParticles = particles;
		
		X = x;
		Y = y;
		
		this.vel = vel;

		sprite = new FlxSprite();
		if (image != null)
		{
			sprite.loadGraphic(image);
			var shouldScaleX:Bool = scaleX != 1;
			var shouldScaleY:Bool = scaleY != 1;
			if (shouldScaleX)
				sprite.scale.x = scaleX;
			if (shouldScaleY)
				sprite.scale.y = scaleY;
			sprite.setGraphicSize(
				(!shouldScaleX && width != 0) ? width : Math.round(sprite.width),
				(!shouldScaleY && height != 0) ? height : Math.round(sprite.height)
			);
		}
		else
			sprite.makeGraphic(width, height, color);
		sprite.updateHitbox();
		sprite.x = X;
		sprite.y = Y;
		trail = new FlxTrail(sprite, null, len, del, alp, diff);
		add(trail);
		spriteGroup = new FlxTypedSpriteGroup<FlxSprite>();
		add(spriteGroup);
		spriteGroup.add(sprite);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		prevX = Reflect.getProperty(this, 'X');
		prevY = Reflect.getProperty(this, 'Y');
		sprite.x = Reflect.getProperty(this, 'prevX');
		sprite.y = Reflect.getProperty(this, 'prevY');
		
		X += vel.x;
		Y += vel.y;
	}
	
	public function collide(obj:Object):Void
	{
		if (!Math.isNaN(prevX) || !Math.isNaN(prevY))
		{
			var detected:Array<Bool> = [
			CollisionDetection.detectUp(prevX, prevY, sprite.x, sprite.y, sprite.width, sprite.height, obj.x, obj.y, obj.width, obj.height, vel.y),
			CollisionDetection.detectDown(prevX, prevY, sprite.x, sprite.y, sprite.width, sprite.height, obj.x, obj.y, obj.width, obj.height, vel.y),
			CollisionDetection.detectLeft(prevX, prevY, sprite.x, sprite.y, sprite.width, sprite.height, obj.x, obj.y, obj.width, obj.height, vel.x),
			CollisionDetection.detectRight(prevX, prevY, sprite.x, sprite.y, sprite.width, sprite.height, obj.x, obj.y, obj.width, obj.height, vel.x)
			];
			if (detected.contains(true))
				shouldKill = true;
		}
	}
	
	public function killBullet():Void
	{
		trail.kill();
		sprite.kill();
		kill();
	}
	
	public function destroyBullet():Void
	{
		trail.destroy();
		sprite.destroy();
		destroy();
	}
}