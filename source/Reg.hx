package;

import flixel.util.FlxPoint;
import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	
	public static inline var CENTER_SIZE:Int = 128;
	public static inline var SLOT_SIZE:Int = 64;
	public static inline var NUM_OF_SLOTS:Int = 8;
	public static inline var ENTER_DURATION:Float = 2.0;
	public static inline var ENTER_DELAY:Float = 0.5;
	
	public static var SLOTS:Array<FlxPoint> = [
		new FlxPoint(320 - 64, 		320 - 64 * 2),
		new FlxPoint(320, 			320 - 64 * 2),
		new FlxPoint(320 + 64,		320 - 64),
		new FlxPoint(320 + 64,		320),
		new FlxPoint(320,			320 + 64),
		new FlxPoint(320 - 64,		320 + 64),
		new FlxPoint(320 - 64 * 2,	320),
		new FlxPoint(320 - 64 * 2,	320 - 64)
	];
	
	
}