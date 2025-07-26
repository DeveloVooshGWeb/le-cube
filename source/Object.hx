package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

import flixel.FlxObject;
import flixel.FlxBasic;

class Object extends FlxSprite
{
	public function new(x:Float, y:Float, w:Int, h:Int, color:FlxColor = FlxColor.WHITE)
	{
		super(x, y);
		makeGraphic(w, h, color);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}