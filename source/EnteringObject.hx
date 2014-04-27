package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Malody Hoe
 */
class EnteringObject extends FlxSprite
{
	
	private var parent:FlxGroup;
	
	public var slot:Int;
	public var justLanded(default, null):Bool;
	private var landed:Bool;

	public function new(slot:Int, parent:FlxGroup) 
	{
		super(Reg.SLOTS[slot].x, Reg.SLOTS[slot].y);
		antialiasing = true;
		
		justLanded = false;
		landed = false;
		this.slot = slot;
		this.parent = parent;
		switch(slot)
		{
			case 0, 1:
				y = -Reg.SLOT_SIZE;
			case 2, 3:
				x = FlxG.width;
			case 4, 5:
				y = FlxG.height;
			case 6, 7:
				x = -Reg.SLOT_SIZE;
		}
		
		FlxTween.multiVar(this,
			{ x: Reg.SLOTS[slot].x, y: Reg.SLOTS[slot].y }, Reg.ENTER_DURATION,
			{ type: FlxTween.ONESHOT, complete: onLand } );
	}
	
	override public function update():Void 
	{
		super.update();
		if (landed)
			justLanded = false;
		if (justLanded)
			landed = true;
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		parent = null;
	}
	
	private function onLand(tween:FlxTween):Void
	{
		justLanded = true;
		FlxTween.singleVar(this, "alpha", 0, 0.25,
			{ type: FlxTween.ONESHOT, complete: onFadeOut } );
	}
	
	private function onFadeOut(tween:FlxTween):Void
	{
		parent.remove(this);
		destroy();
	}
	
	public function onHitFace(face:Face):Void
	{
	}
	
}