package flixel;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSoundGroup;
import flixel.system.FlxSound;
import flixel.Assets;

class FlxGameState extends FlxState
{
	override function create()
	{
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ZERO)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		
		super.update(elapsed);
	}
	
	public function playSound(soundId:String, volume:Float = 1, looped:Bool = false, ?group:FlxSoundGroup, autoDestroy:Bool = true, ?onComplete:Void->Void):Void
	{
		if (Assets.exists(soundId, SOUND))
			FlxG.sound.play(Assets.idPath(soundId, SOUND), volume, looped, group, autoDestroy, onComplete);
	}
	
	public function playMusic(musicId:String, volume:Float = 1, looped:Bool = false, ?group:FlxSoundGroup):Void
	{
		if (Assets.exists(musicId))
			FlxG.sound.playMusic(Assets.idPath(musicId), volume, looped, group);
	}
	
	public function loadAudio(audioId:String, volume:Float = 1, looped:Bool = false, ?group:FlxSoundGroup, autoDestroy:Bool = false, autoPlay:Bool = false, ?url:String, ?onComplete:Void->Void):FlxSound
	{
		if (Assets.exists(audioId))
			return FlxG.sound.load(Assets.idPath(audioId), volume, looped, group, autoDestroy, autoPlay, url, onComplete);
		else
			return new FlxSound();
	}
}