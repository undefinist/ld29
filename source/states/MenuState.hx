package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		var title:FlxSprite = new FlxSprite();
		title.loadGraphic("sprites/title.png");
		title.scale.x = 4.0;
		title.scale.y = 4.0;
		FlxSpriteUtil.screenCenter(title);
		add(title);
		
		var words:FlxText = new FlxText(
			4, FlxG.height / 2 - 16 * 4 - 24, FlxG.width,
			"A pretentious game about pretending to be happy.", 16);
		add(words);
		
		var help:FlxText = new FlxText(
			16 * 4 * 3 + 8, FlxG.height / 2 + 8, 16 * 4 * 2 - 16,
			"A or D\nto start", 16);
		help.alignment = "center";
		add(help);
		
		var credits:FlxText = new FlxText(0, FlxG.height - 24, FlxG.width - 4,
			"A game by Malody Hoe / @maddhoexD", 16);
		credits.alignment = "right";
		add(credits);
		
		FlxG.camera.fade(0xff000000, 1.0, true);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		if (FlxG.keys.anyJustPressed(["A", "LEFT", "D", "RIGHT"]))
			FlxG.switchState(new PlayState());
	}	
}