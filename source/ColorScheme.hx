package;

import flixel.plus.util.FlxColorScheme;

/**
 * ...
 * @author Malody Hoe
 */
class ColorScheme
{

	private static var instance:FlxColorScheme;
	
	public static var background:Int = 0;
	public static var lights:Int = 0;
	public static var darks:Int = 0;
	
	private static function initialize():Void
	{
		instance = new FlxColorScheme();
		instance.addColor("background",
			{ min: 0, max: 360.0 },
			{ min: 0.7, max: 0.8 },
			{ min: 0.5, max: 0.5 },
			{ min: 1.0, max: 1.0 } );
		instance.addColor("lights",
			{ min: 0, max: 0, base: "background" },
			{ min: 0.6, max: 0.7 },
			{ min: 0.9, max: 0.9 },
			{ min: 1.0, max: 1.0 } );
		instance.addColor("darks",
			{ min: 0, max: 0, base: "background" },
			{ min: 0.7, max: 0.8 },
			{ min: 0.85, max: 0.85 },
			{ min: 1.0, max: 1.0 } );
	}
	
	public static function randomize():Void
	{
		if (instance == null)
			initialize();
			
		instance.generate();
		
		background = instance.getColor("background");
		lights = instance.getColor("lights");
		darks = instance.getColor("darks");
	}
	
}