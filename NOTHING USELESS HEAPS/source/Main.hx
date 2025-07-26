package;

import hxd.App;

import h2d.Font;
import h2d.Text;

class Main extends App
{
	override function init()
	{
		var tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World !";
	}
	
	static function main()
	{
		new Main();
	}
}