package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
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
		var iconGraphic:FlxGraphic = Paths.image('UI/forever/base/fcmedals.png');
		loadGraphic(iconGraphic, true, 100,100);

		initialWidth = width;
		initialHeight = height;

		animation.add('medal', [0, 1], 0, false);
		animation.play('medal');
		animation.frameIndex = Highscore.songFCs.get(song);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x - 100, sprTracker.y);
	}
}
