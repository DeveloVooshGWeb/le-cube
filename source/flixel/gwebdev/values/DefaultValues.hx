package flixel.gwebdev.values;

import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.util.helpers.FlxRangeBounds;
import flixel.gwebdev.ParticleEmitterData;
import flixel.gwebdev.addons.TrailedBulletData;

class DefaultValues
{
	public static var defaultEmitterData:ParticleEmitterData = { lifeSpan: 1, width: 0, height: 0, scaleX: 1, scaleY: 1, color: FlxColor.WHITE, image: null, alphaRange: FlxPoint.get(1, 1), speedRange: new FlxRangeBounds<Float>(-1, -1, 1, 1), destroyType: INSTANT, explode: false, freq: 1, delay: 0.1 };
	public static var defaultBulletData:TrailedBulletData = {
	particles: false,
	x: 0,
	y: 0,
	velocity: FlxPoint.get(0, 0),
	width: 0,
	height: 0,
	scaleX: 0,
	scaleY: 0,
	color: FlxColor.WHITE,
	image: null,
	len: 10,
	del: 3,
	alp: 0.4,
	diff: 0.05,
	emitterData: DefaultValues.defaultEmitterData,
	particleCount: 1
	};
}