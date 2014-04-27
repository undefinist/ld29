package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColorUtil;
import flixel.util.FlxRandom;
import haxe.Log;

/**
 * ...
 * @author Malody Hoe
 */
class Background extends FlxGroup
{

	private static inline var MIN_COLOR_TWEEN_DURATION:Float = 1.0;
	private static inline var MAX_COLOR_TWEEN_DURATION:Float = 2.0;
	
	private var paths:Array<FlxSprite>;
	private var canTween:Bool;
	
	public function new() 
	{
		super();
		
		paths = new Array<FlxSprite>();
		var pathLength:Int = Std.int(FlxG.height * 1.5 - Reg.CENTER_SIZE / 2);
		for (i in 0...Reg.NUM_OF_SLOTS)
		{
			paths.push(new FlxSprite(Reg.SLOTS[i].x, Reg.SLOTS[i].y));
			add(paths[i]);
			
			if (i == 0 || i == 1)
				paths[i].y = -FlxG.height;
			if (i == 6 || i == 7)
				paths[i].x = -FlxG.width;
				
			var color:Int = i % 2 == 0 ?
				ColorScheme.lights : ColorScheme.darks;
			if(i == 0 || i == 1 || i == 4 || i == 5)
				paths[i].makeGraphic(Reg.SLOT_SIZE, pathLength, color);
			else
				paths[i].makeGraphic(pathLength, Reg.SLOT_SIZE, color);
		}
		
		canTween = true;
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		paths = null;
	}
	
	override public function update():Void 
	{
		super.update();
		
		var duration:Float = FlxRandom.floatRanged(
			MIN_COLOR_TWEEN_DURATION, MAX_COLOR_TWEEN_DURATION);

		if (canTween)
		{
			ColorScheme.randomize();
			FlxTween.color(paths[0], duration, paths[0].color, ColorScheme.lights);
			FlxTween.color(
				paths[1], duration, paths[1].color, ColorScheme.darks, 1.0, 1.0,
				{ type: FlxTween.ONESHOT, complete: function(_):Void {
					canTween = true;
				} } );
			canTween = false;
		}
		for (i in 2...Reg.NUM_OF_SLOTS)
		{
			paths[i].color = paths[i % 2 == 0 ? 0 : 1].color;
		}
	}
	
}