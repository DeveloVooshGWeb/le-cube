package;

class CollisionDetection
{
	public static function detectUp(oldx:Float, oldy:Float, x1:Float, y1:Float, w1:Float, h1:Float, x2:Float, y2:Float, w2:Float, h2:Float, vel:Float):Bool
	{
		if (vel > 0)
			vel = 0;
		if (x1 + w1 > x2 && x1 < x2 + w2 && oldy >= y2 + h2 && y1 + vel <= y2 + h2)
			return true;
		else
			return false;
	}
	
	public static function detectDown(oldx:Float, oldy:Float, x1:Float, y1:Float, w1:Float, h1:Float, x2:Float, y2:Float, w2:Float, h2:Float, vel:Float):Bool
	{
		if (vel < 0)
			vel = 0;
		if (x1 + w1 > x2 && x1 < x2 + w2 && oldy + h1 <= y2 && y1 + h1 + vel >= y2)
			return true;
		else
			return false;
	}
	
	public static function detectLeft(oldx:Float, oldy:Float, x1:Float, y1:Float, w1:Float, h1:Float, x2:Float, y2:Float, w2:Float, h2:Float, vel:Float):Bool
	{
		if (vel > 0)
			vel = 0;
		if (y1 + h1 > y2 && y1 < y2 + h2 && oldx >= x2 + w2 && x1 + vel <= x2 + w2)
			return true;
		else
			return false;
	}
	
	public static function detectRight(oldx:Float, oldy:Float, x1:Float, y1:Float, w1:Float, h1:Float, x2:Float, y2:Float, w2:Float, h2:Float, vel:Float):Bool
	{
		if (vel < 0)
			vel = 0;
		if (y1 + h1 > y2 && y1 < y2 + h2 && oldx + w1 <= x2 && x1 + w1 + vel >= x2)
			return true;
		else
			return false;
	}
}