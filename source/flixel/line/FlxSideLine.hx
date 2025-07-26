package flixel.line;

import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class FlxSideLine extends FlxBar
{
	public var fifty(get, null):Float;
	
	public function get_fifty():Float
	{
		return 50;
	}

	public function new(thickness:Int = 1, width:Int = 1, color:FlxColor = FlxColor.WHITE, x:Float = 0, y:Float = 0)
	{
		super(x, y, RIGHT_TO_LEFT, width * 2, thickness, this, 'fifty', 0, 100);
		createFilledBar(0x00000000, color);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}