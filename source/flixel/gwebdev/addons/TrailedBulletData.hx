package flixel.gwebdev.addons;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.gwebdev.ParticleEmitterData;

typedef TrailedBulletData =
{
	particles:Bool,
	x:Float,
	y:Float,
	velocity:FlxPoint,
	width:Int,
	height:Int,
	scaleX:Float,
	scaleY:Float,
	color:FlxColor,
	image:Null<FlxGraphicAsset>,
	len:Int,
	del:Int,
	alp:Float,
	diff:Float,
	emitterData:ParticleEmitterData,
	particleCount:Int,
};