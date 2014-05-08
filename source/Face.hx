package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Malody Hoe
 */
class Face extends FlxSprite
{

	private static inline var HAPPY_INDEX:Int = 0;
	private static inline var SMILE_INDEX:Int = 1;
	private static inline var POKER_INDEX:Int = 2;
	private static inline var SAD_INDEX:Int = 3;
	private static inline var CRY_INDEX:Int = 4;
	
	private var tween:FlxTween;
	
	public var isCrying(get, never):Bool;
	private function get_isCrying():Bool
	{
		return animation.frameIndex == CRY_INDEX;
	}
	
	public var slot:Int; // which of the 8 slots this face is in
	
	public function new(slot:Int) 
	{
		super(Reg.SLOTS[slot].x, Reg.SLOTS[slot].y);
		loadGraphic("sprites/faces.png", true);
		animation.frameIndex = POKER_INDEX;
		antialiasing = true;
		
		this.slot = slot;
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		tween = null;
	}
	
	public function happier():Void
	{
		var index:Int = animation.frameIndex - 1;
		if (index < HAPPY_INDEX)
			index = HAPPY_INDEX;
		animation.frameIndex = index;
	}
	
	public function sadder():Void
	{
		var index:Int = animation.frameIndex + 1;
		if (index > CRY_INDEX)
			index = CRY_INDEX;
		animation.frameIndex = index;
	}
	
	public function previousSlot():Void
	{
		slot = (slot + Reg.NUM_OF_SLOTS - 1) % Reg.NUM_OF_SLOTS;
		moveTo(slot);
	}
	
	public function nextSlot():Void
	{
		slot = (slot + 1) % Reg.NUM_OF_SLOTS;
		moveTo(slot);
	}
	
	@:access(flixel.tweens.FlxTween.finish)
	private function moveTo(slot:Int):Void
	{
		if (tween != null)
		{
			if (!tween.finished)
				tween.finish();
		}
		tween = FlxTween.tween(this,
			{ x: Reg.SLOTS[slot].x, y: Reg.SLOTS[slot].y }, 0.1,
			{ type: FlxTween.ONESHOT, ease: FlxEase.cubeOut } );
	}
	
}