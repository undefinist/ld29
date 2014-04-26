package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.plus.util.FlxRandomStack;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var faces:Array<Face>;
	private var enteringObjects:Array<EnteringObject>;
	private var patternStack:FlxRandomStack<String>;
	
	private var timeText:FlxText;
	
	private var timeElapsed:Float;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		if (FlxG.sound.music == null)
			FlxG.sound.playMusic("BGM");
		
		FlxG.camera.bgColor = 0xff5555ff;
		
		faces = new Array<Face>();
		for (i in 0...4)
		{
			faces.push(new Face(i * 2));
			add(faces[i]);
		}
		
		enteringObjects = new Array<EnteringObject>();
		
		patternStack = new FlxRandomStack<String>(Reg.PATTERNS, true);
		patternStack.insert(Reg.PATTERNS, true);
		patternStack.insert(Reg.PATTERNS, true);
		patternStack.shuffle();
		
		timeText = new FlxText(0, 0, FlxG.width, "0.00", 16);
		timeText.alignment = "center";
		FlxSpriteUtil.screenCenter(timeText);
		add(timeText);
		
		timeElapsed = 0;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		faces = null;
		enteringObjects = null;
		patternStack = null;
		timeText = null;
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{	
		super.update();
		
		timeElapsed += FlxG.elapsed;
		var timeParts = Std.string(timeElapsed).split(".");
		timeText.text = timeParts[0] + "." + timeParts[1].substr(0, 2);
		
		if (FlxG.keys.anyJustPressed(["A", "LEFT"]))
			rotateFaces(-1);
		else if (FlxG.keys.anyJustPressed(["D", "RIGHT"]))
			rotateFaces(1);
			
		var i:Int = 0;
		while (i < enteringObjects.length)
		{
			var obj:EnteringObject = enteringObjects[i];
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
				enteringObjects.remove(obj);
				i--;
			}
			i++;
		}
		if (enteringObjects.length == 0)
			generatePattern();
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
	
	private function generatePattern():Void
	{
		var str:String = patternStack.next();
		
		var slot:Int = FlxRandom.intRanged(0, Reg.NUM_OF_SLOTS - 1);
		var delay:Float = 0;
		
		var patterns:Array<String> = new Array<String>();
		for (i in 0...str.length)
		{
			if (i % Reg.NUM_OF_SLOTS == 0)
			{
				patterns.push("");
			}
			patterns[patterns.length - 1] += str.charAt(i);
		}
		
		for (pattern in patterns)
		{
			if (delay > 0)
			{
				FlxTimer.start(delay, function(_):Void {
					generateSinglePattern(slot, pattern);
				} );
			}
			else
				generateSinglePattern(slot, pattern);
				
			delay += Reg.ENTER_DELAY;
		}
	}
	
	private function generateSinglePattern(beginSlot:Int, pattern:String)
	{
		var index:Int = 0;
		var slot:Int = beginSlot;
		
		while (index < pattern.length)
		{
			if (pattern.charAt(index) == "+")
			{
				var o:EnteringObject = new Happiness(slot, this);
				add(o);
				enteringObjects.push(o);
			}
			else if (pattern.charAt(index) == "-")
			{
				var o:EnteringObject = new Sadness(slot, this);
				add(o);
				enteringObjects.push(o);
			}
			
			index++;
			slot = (slot + 1) % Reg.NUM_OF_SLOTS;
		}
	}
	
}