package;

import flixel.group.FlxGroup;

/**
 * ...
 * @author Malody Hoe
 */
class Happiness extends EnteringObject
{

	public function new(slot:Int, parent:FlxGroup) 
	{
		super(slot, parent);
		loadGraphic("sprites/faces.png", true);
		animation.frameIndex = 1;
	}
	
	override public function onHitFace(face:Face):Void 
	{
		face.happier();
	}
	
}