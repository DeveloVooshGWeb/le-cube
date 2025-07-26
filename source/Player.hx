package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.gwebdev.math.util.MathUtils;

class Player extends FlxSprite
{
	public var prevX:Float = Math.NaN;
	public var prevY:Float = Math.NaN;

	public var X:Float = 0;
	public var Y:Float = 0;
	
	public var canJump:Bool = true;

	public function new(x:Float = 0, y:Float = 0, w:Int = 1, h:Int = 1, color:FlxColor = FlxColor.WHITE)
	{
		super(x, y);
		this.X = x;
		this.Y = y;
		makeGraphic(w, h, color);
		this.color = color;
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		prevX = Reflect.getProperty(this, 'X');
		prevY = Reflect.getProperty(this, 'Y');
		x = X;
		y = Y;
	}
	
	public function collide(obj:Object, playerVelocityX:Float, playerVelocityY:Float):Void
	{
		if (!Math.isNaN(prevX) || !Math.isNaN(prevY))
		{
			var detected:Array<Bool> = [
			CollisionDetection.detectUp(prevX, prevY, X, Y, width, height, obj.x, obj.y, obj.width, obj.height, playerVelocityY),
			CollisionDetection.detectDown(prevX, prevY, X, Y, width, height, obj.x, obj.y, obj.width, obj.height, playerVelocityY),
			CollisionDetection.detectLeft(prevX, prevY, X, Y, width, height, obj.x, obj.y, obj.width, obj.height, playerVelocityX),
			CollisionDetection.detectRight(prevX, prevY, X, Y, width, height, obj.x, obj.y, obj.width, obj.height, playerVelocityX)
			];
			if (detected[0])
			{
				Y = obj.y + obj.height;
				prevY = Y;
				onCollision(0);
			}
			if (detected[1])
			{
				Y = obj.y - height;
				prevY = y;
				onCollision(1);
			}
			if (detected[2])
			{
				X = obj.x + obj.width;
				prevX = X;
				onCollision(2);
			}
			if (detected[3])
			{
				X = obj.x - width;
				prevX = X;
				onCollision(3);
			}
		}
	}
	
	public function onCollision(hit:Int):Void
	{
		switch(hit)
		{
			case 0:
			case 1:
				canJump = true;
			case 2:
			case 3:
		}
	}
	
	public var midpointX(get, null):Float;
	public var midpointY(get, null):Float;
	
	public function get_midpointX():Float
	{
		return getMidpoint().x;
	}
	
	public function get_midpointY():Float
	{
		return getMidpoint().y;
	}
	
	public function getYOfCanvasFromPlayer():Float
	{
		return ( ( FlxG.mouse.y - midpointY ) / ( FlxG.mouse.x - midpointX ) ) * ( FlxG.width - FlxG.mouse.x ) + ( FlxG.mouse.y );
	}
	
	public function angleBetweenMouse():Float
	{
		var toRet:Float = Math.atan2( ( getYOfCanvasFromPlayer() - FlxG.height ) - ( midpointY - FlxG.height ), FlxG.width - midpointX ) * ( 180 / Math.PI );
		var mouseIsDiff_X:Bool = FlxG.mouse.x < midpointX;
		var mouseIsDiff_ADD_Y:Bool = midpointY > FlxG.mouse.y;
		var mouseIsDiff_SUB_Y:Bool = FlxG.mouse.y > midpointY;
		var mouse_sub:Bool = mouseIsDiff_X && mouseIsDiff_SUB_Y && toRet > -90;
		var mouse_add:Bool = mouseIsDiff_X && mouseIsDiff_ADD_Y && toRet < 90;
		if (mouse_sub)
			toRet += 180;
		if (mouse_add)
			toRet -= 180;
		var angleSign:Int = (toRet < 0) ? -1 : 1;
		if (angleSign == -1)
			toRet += 360;
		if (toRet >= 360)
			toRet -= 360;
		if (toRet <= -360)
			toRet += 360;
		return toRet;
	}
	
	public function getVelocityFromAngleBetweenMouse(velX:Float, velY:Float):FlxPoint
	{
		return MathUtils.velocityFromDeg(velX, velY, angleBetweenMouse());
	}
}