package flixel.gwebdev.addons;
/*
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PlayerOverlapGroup extends FlxTypedSpriteGroup<FlxTypedSpriteGroup<FlxSprite>>
{
	public var group:FlxTypedSpriteGroup<FlxSprite>;

	public function new()
	{
		super();
		group = new FlxTypedSpriteGroup<FlxSprite>();
		add(group);
	}
	
	public function createOverlap(player:FlxSprite, color:FlxColor = FlxColor.WHITE, ?image:Null<FlxGraphicAsset>, ?specificWidth:Int, ?specificHeight:Int):Void
	{
		var newSprite:FlxSprite = new FlxSprite();
		var pWidth:Int = Std.int(player.width);
		var pHeight:Int = Std.int(player.height);
		var toUseWidth:Int = specificWidth != null ? specificWidth : pWidth;
		var toUseHeight:Int = specificHeight != null ? specificHeight : pHeight;
		if (image != null)
		{
			newSprite.loadGraphic(image);
			var imgWidth:Int = specificWidth != null ? specificWidth : 0;
			var imgHeight:Int = specificHeight != null ? specificHeight : 0;
			newSprite.setGraphicSize(imgWidth, imgHeight);
			newSprite.updateHitbox();
		}
		else
			newSprite.makeGraphic(toUseWidth, toUseHeight, color);
		newSprite.color = color;
		var sprWidth:Int = Std.int(newSprite.width);
		var sprHeight:Int = Std.int(newSprite.height);
		newSprite.x += (pWidth - sprWidth) / 2;
		newSprite.y += (pHeight - sprHeight) / 2;
		group.add(newSprite);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}*/