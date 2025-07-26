package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.display.FPS;

class Main extends Sprite
{
	public var gWidth:Int = 1920;
	public var gHeight:Int = 1080;
	public var fps:Int = 60;
	public var removeSplash:Bool = false;
	public var fullscreen:Bool = false;

	public function new()
	{
		super();
		
		Controller.setKeys(["UP", "W", "SPACE"], 0);
		Controller.setKeys(["DOWN", "S"], 1);
		Controller.setKeys(["LEFT", "A"], 2);
		Controller.setKeys(["RIGHT", "D"], 3);
		
		addChild(new FlxGame(gWidth, gHeight, KeyBindState, 1280 / gWidth, fps, fps, removeSplash, fullscreen));

		addChild(new FPS(10, 3, 0xFFFFFF));
	}
}
