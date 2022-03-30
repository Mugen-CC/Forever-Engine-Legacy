package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import haxe.Exception;
import meta.data.Highscore;
import sys.FileSystem;

using StringTools;

class FCMedal extends FlxSprite
{
	// rewrite using da new icon system as ninjamuffin would say it
	public var sprTracker:FlxSprite;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;

	public function new(song:String)
	{
		super();
		updateMedal(song);
	}

	public function updateMedal(song:String)
	{
		antialiasing = true;
		var iconGraphic:FlxGraphic = Paths.image('UI/forever/base/fcmedals');
		loadGraphic(iconGraphic, true, 100,100);

		initialWidth = width;
		initialHeight = height;

		animation.add('medal', [0, 1,2,3,4,5,6,7,8], 0, false);
		animation.play('medal');

		var medalSkin:Int;
		switch (Init.trueSettings.get('Medal Skin'))
		{
			case 'Default':
				medalSkin = 0;
			case 'Newgrounds':
				medalSkin = 1;
			case 'Foundation':
				medalSkin = 2;
			default:
				throw new Exception('Unknown medal skin "${Init.trueSettings.get('Medal Skin')}"');
		}
		animation.frameIndex = 3*medalSkin + Highscore.getFC(song);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y + 45);
	}
}
