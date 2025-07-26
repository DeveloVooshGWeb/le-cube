package;

import flixel.FlxG;
import flixel.input.FlxKeyManager;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;

class Controller
{
	public static var UP(get, null):Bool;
	public static var DOWN(get, null):Bool;
	public static var LEFT(get, null):Bool;
	public static var RIGHT(get, null):Bool;
	
	public static var UP_JP(get, null):Bool;
	public static var DOWN_JP(get, null):Bool;
	public static var LEFT_JP(get, null):Bool;
	public static var RIGHT_JP(get, null):Bool;
	
	public static var UP_JR(get, null):Bool;
	public static var DOWN_JR(get, null):Bool;
	public static var LEFT_JR(get, null):Bool;
	public static var RIGHT_JR(get, null):Bool;

	public static var M1(get, null):Bool;
	public static var M1_JP(get, null):Bool;
	public static var M1_JR(get, null):Bool;
	
	public static var MM(get, null):Bool;
	public static var MM_JP(get, null):Bool;
	public static var MM_JR(get, null):Bool;
	
	public static var M2(get, null):Bool;
	public static var M2_JP(get, null):Bool;
	public static var M2_JR(get, null):Bool;
	
	public static var keyBinds:Array<Array<FlxKey>> = [[], [], [], []];
	
	public static function setKeys(keyArr:Array<String>, index:Int = 0):Void
	{
		var newArr:Array<FlxKey> = [];
		for (shit in keyArr)
			newArr.push(FlxKey.fromString(shit));
		if (index >= 0 && index <= 3)
			keyBinds[index] = newArr;
	}
	
	public static function get_UP():Bool
		return FlxG.keys.anyPressed(keyBinds[0]);
		
	public static function get_DOWN():Bool
		return FlxG.keys.anyPressed(keyBinds[1]);
		
	public static function get_LEFT():Bool
		return FlxG.keys.anyPressed(keyBinds[2]);
		
	public static function get_RIGHT():Bool
		return FlxG.keys.anyPressed(keyBinds[3]);
		
	public static function get_UP_JP():Bool
		return FlxG.keys.anyJustPressed(keyBinds[0]);
		
	public static function get_DOWN_JP():Bool
		return FlxG.keys.anyJustPressed(keyBinds[1]);
		
	public static function get_LEFT_JP():Bool
		return FlxG.keys.anyJustPressed(keyBinds[2]);
		
	public static function get_RIGHT_JP():Bool
		return FlxG.keys.anyJustPressed(keyBinds[3]);
		
	public static function get_UP_JR():Bool
		return FlxG.keys.anyJustReleased(keyBinds[0]);
		
	public static function get_DOWN_JR():Bool
		return FlxG.keys.anyJustReleased(keyBinds[1]);
		
	public static function get_LEFT_JR():Bool
		return FlxG.keys.anyJustReleased(keyBinds[2]);
		
	public static function get_RIGHT_JR():Bool
		return FlxG.keys.anyJustReleased(keyBinds[3]);
		
	public static function get_M1():Bool
		return FlxG.mouse.pressed;
		
	public static function get_M1_JP():Bool
		return FlxG.mouse.justPressed;
		
	public static function get_M1_JR():Bool
		return FlxG.mouse.justReleased;
		
	public static function get_MM():Bool
		return FlxG.mouse.pressedMiddle;
		
	public static function get_MM_JP():Bool
		return FlxG.mouse.justPressedMiddle;
		
	public static function get_MM_JR():Bool
		return FlxG.mouse.justReleasedMiddle;
		
	public static function get_M2():Bool
		return FlxG.mouse.pressedRight;
		
	public static function get_M2_JP():Bool
		return FlxG.mouse.justPressedRight;
		
	public static function get_M2_JR():Bool
		return FlxG.mouse.justReleasedRight;
}