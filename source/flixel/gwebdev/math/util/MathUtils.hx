package flixel.gwebdev.math.util;

import flixel.math.FlxPoint;
import flixel.math.FlxAngle;

class MathUtils
{
	public static function velocityFromDeg(x:Float, y:Float, deg:Float):FlxPoint
	{
		var rad:Float = FlxAngle.asRadians(deg);
		x *= Math.cos(rad);
		y *= Math.sin(rad);
		return FlxPoint.get(x, y);
	}

	public static function round2(number:Float, precision:Int):Float
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round(num) / Math.pow(10, precision);
		return num;
	}
}