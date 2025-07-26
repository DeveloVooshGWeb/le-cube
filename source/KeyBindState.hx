package;

import flixel.FlxG;
import flixel.FlxState;

class KeyBindState extends FlxState
{
	override function create()
	{
		super.create();
		
		#if FLX_KEYBOARD
		FlxG.sound.volumeUpKeys = [F3, NUMPADPLUS, PLUS];
		FlxG.sound.volumeDownKeys = [F2, NUMPADMINUS, MINUS];
		FlxG.sound.muteKeys = [F1];
		#end
		
		FlxG.switchState(new PlayState());
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}