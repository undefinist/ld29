package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var faces:Array<Face>;
	private var enteringObjects:Array<EnteringObject>;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.bgColor = 0xff5555ff;
		
		faces = new Array<Face>();
		for (i in 0...4)
		{
			faces.push(new Face(i * 2));
			add(faces[i]);
		}
		
		enteringObjects = new Array<EnteringObject>();
		enteringObjects.push(new Happiness(0, this));
		add(enteringObjects[0]);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		faces = null;
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.anyJustPressed(["A", "LEFT"]))
			rotateFaces(-1);
		else if (FlxG.keys.anyJustPressed(["D", "RIGHT"]))
			rotateFaces(1);
			
		for (obj in enteringObjects)
		{
			if (obj.justLanded)
			{
				for (face in faces)
				{
					if (obj.slot == face.slot)
					{
						obj.onHitFace(face);
						break;
					}
				}
			}
		}
	}
	
	private function rotateFaces(direction:Int):Void
	{
		for (face in faces)
		{
			if(direction > 0)
				face.nextSlot();
			else if (direction < 0)
				face.previousSlot();
		}
	}
	
}