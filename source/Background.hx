package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Malody Hoe
 */
class Background extends FlxGroup
{

	private var base:FlxSprite;
	private var paths:Array<FlxSprite>;
	
	public function new() 
	{
		super();
		
		base = new FlxSprite(-FlxG.width, -FlxG.height);
		base.color = 0xff8888ff;
		add(base);
		
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
				
			var color:Int = i % 2 == 0 ? 0xffccccff : 0xff4444cc;
			if(i == 0 || i == 1 || i == 4 || i == 5)
				paths[i].makeGraphic(Reg.SLOT_SIZE, pathLength, color);
			else
				paths[i].makeGraphic(pathLength, Reg.SLOT_SIZE, color);
		}
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		base = null;
		paths = null;
	}
	
}