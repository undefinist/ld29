package;

import flixel.group.FlxGroup;

/**
 * ...
 * @author Malody Hoe
 */
class Sadness extends EnteringObject
{

	public function new(slot:Int, parent:FlxGroup) 
	{
		super(slot, parent);
		loadGraphic("sprites/faces.png", true);
		animation.frameIndex = 4;
		color = 0xff000000;
	}
	
	override public function onHitFace(face:Face):Void 
	{
		face.sadder();
	}
	
}