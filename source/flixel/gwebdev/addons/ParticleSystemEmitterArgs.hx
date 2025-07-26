package flixel.gwebdev.addons;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.helpers.FlxRangeBounds;
import flixel.math.FlxPoint;
import flixel.gwebdev.ParticleDestroyType;

typedef ParticleSystemEmitterArgs =
{
	id:String,
	x:Float,
	y:Float,
	m:Int,
	lifeSpan:Float,
	width:Int,
	height:Int,
	scaleX:Float,
	scaleY:Float,
	color:FlxColor,
	image:Null<FlxGraphicAsset>,
	alphaRange:FlxPoint,
	speedRange:FlxRangeBounds<Float>,
	destroyType:ParticleDestroyType,
	count:Int,
	explode:Bool,
	freq:Int,
	delay:Float
};