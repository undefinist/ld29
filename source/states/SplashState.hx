package;

import flixel.FlxG;
import flixel.plus.system.FlxSplashPlus;

/**
 * ...
 * @author Malody Hoe
 */
class SplashState extends FlxSplashPlus
{

	public function new() 
	{
		super(MenuState);
	}
	
	override public function initDefaults():Void 
	{
		if (FlxG.save.data.highscore == null)
			FlxG.save.data.highscore = 0;
	}
	
}