package flixel.gwebdev.addons;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.gwebdev.addons.TrailedBullet;
import flixel.gwebdev.addons.TrailedBullet.TrailedBulletGroup;
import flixel.math.FlxPoint;
import flixel.util.helpers.FlxRangeBounds;
import flixel.gwebdev.ParticleSystem;
import flixel.gwebdev.ParticleEmitterData;
import flixel.gwebdev.addons.TrailedBulletData;
import flixel.gwebdev.addons.ParticleSystemEmitterArgs;

import flixel.gwebdev.values.DefaultValues;

class TrailedBulletSystem extends FlxGroup
{
	public var bulletData:TrailedBulletData = DefaultValues.defaultBulletData;
	public var bullets:TrailedBulletGroup;
	public var queuedParticles:Array<ParticleSystemEmitterArgs> = [];

	public function new()
	{
		super();
		
		bullets = new TrailedBulletGroup();
		add(bullets);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				if (bullet.shouldKill)
				{
					if (bullet.useParticles)
					{
						queuedParticles.push(
						{
						id: bullet.id + "-particle",
						x: bullet.sprite.getMidpoint().x,
						y: bullet.sprite.getMidpoint().y,
						m: 0,
						lifeSpan: bullet.emitterData.lifeSpan,
						width: bullet.emitterData.width,
						height: bullet.emitterData.height,
						scaleX: bullet.emitterData.scaleX,
						scaleY: bullet.emitterData.scaleY,
						color: bullet.emitterData.color,
						image: bullet.emitterData.image,
						alphaRange: bullet.emitterData.alphaRange,
						speedRange: bullet.emitterData.speedRange,
						destroyType: bullet.emitterData.destroyType,
						count: bullet.particleCount,
						explode: bullet.emitterData.explode,
						freq: bullet.emitterData.freq,
						delay: bullet.emitterData.delay
						}
						);
					}
					bullet.killBullet();
					bullets.remove(bullet, true);
					bullet.destroyBullet();
				}
			}
		);
	}
	
	public function collide(id:String, obj:Object):Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				if (bullet.id == id)
					bullet.collide(obj);
			}
		);
	}
	
	public function collideAll(obj:Object):Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				bullet.collide(obj);
			}
		);
	}
	
	public function killBullet(id:String):Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				if (bullet.id == id)
				{
					bullet.killBullet();
					bullets.remove(bullet, true);
					bullet.destroyBullet();
				}
			}
		);
	}
	
	public function killAll():Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				bullet.killBullet();
			}
		);
		bullets.forEachDead(
			function(bullet:TrailedBullet)
			{
				bullets.remove(bullet, true);
				bullet.destroyBullet();
			}
		);
	}
	
	public function explode(id:String):Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				if (bullet.id == id)
					bullet.shouldKill = true;
			}
		);
	}
	
	public function explodeAll():Void
	{
		bullets.forEachAlive(
			function(bullet:TrailedBullet)
			{
				bullet.shouldKill = true;
			}
		);
	}

	public function setBulletData(particles:Bool = false, xPos:Float = 0, yPos:Float = 0, ?vel:FlxPoint, w:Int = 0, h:Int = 0, scaleX:Float = 1, scaleY:Float = 1, col:FlxColor = FlxColor.WHITE, ?image:Null<FlxGraphicAsset>, len:Int = 10, del:Int = 3, alp:Float = 0.4, diff:Float = 0.05, ?emitterData:ParticleEmitterData, particleCount:Int = 1)
	{
		if (vel == null)
			vel = FlxPoint.get(0, 0);
		if (emitterData == null)
			emitterData = DefaultValues.defaultEmitterData;
		bulletData.particles = particles;
		bulletData.x = xPos;
		bulletData.y = yPos;
		bulletData.velocity = vel;
		bulletData.width = w;
		bulletData.height = h;
		bulletData.scaleX = scaleX;
		bulletData.scaleY = scaleY;
		bulletData.color = col;
		bulletData.image = image;
		bulletData.len = len;
		bulletData.del = del;
		bulletData.alp = alp;
		bulletData.diff = diff;
		bulletData.emitterData = emitterData;
		bulletData.particleCount = particleCount;
	}
	
	public function spawnBullets(bulletId:String = "bullet", count:Int = 1):Void
	{
		if (count < 1)
			count = 1;
		for (i in 0...count)
			spawnBullet(bulletId + "-" + count);
	}
	
	public function spawnBullet(bulletId:String = "bullet1"):Void
	{
		createBullet(
		bulletId,
		bulletData.particles,
		bulletData.x,
		bulletData.y,
		bulletData.velocity,
		bulletData.width,
		bulletData.height,
		bulletData.scaleX,
		bulletData.scaleY,
		bulletData.color,
		bulletData.image,
		bulletData.len,
		bulletData.del,
		bulletData.alp,
		bulletData.diff,
		bulletData.emitterData,
		bulletData.particleCount
		);
	}
	
	public function createBullet(bulletId:String = "bullet1", particles:Bool = false, xPos:Float = 0, yPos:Float = 0, ?vel:FlxPoint, w:Int = 0, h:Int = 0, scaleX:Float = 1, scaleY:Float = 1, col:FlxColor = FlxColor.WHITE, ?image:Null<FlxGraphicAsset>, len:Int = 10, del:Int = 3, alp:Float = 0.4, diff:Float = 0.05, ?emitterData:ParticleEmitterData, particleCount:Int = 1):Void
	{
		if (vel == null)
			vel = FlxPoint.get(0, 0);
		if (emitterData == null)
			emitterData = DefaultValues.defaultEmitterData;
		var bullet:TrailedBullet = new TrailedBullet(particles, xPos, yPos, vel, w, h, scaleX, scaleY, col, image, particles, len, del, alp, diff);
		bullet.emitterData = bulletData.emitterData;
		bullet.particleCount = particleCount;
		bullet.id = bulletId;
		bullets.add(bullet);
	}
}