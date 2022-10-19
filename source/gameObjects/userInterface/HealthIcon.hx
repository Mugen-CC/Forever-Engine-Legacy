package gameObjects.userInterface;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import sys.FileSystem;

using StringTools;

class HealthIcon extends FlxSprite
{
	// rewrite using da new icon system as ninjamuffin would say it
	public var sprTracker:FlxSprite;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		updateIcon(char, isPlayer);
	}

	public function updateIcon(char:String = 'bf', isPlayer:Bool = false)
	{
		var iconPath = getIconPath(char);

		antialiasing = true;
		var iconGraphic:FlxGraphic = Paths.image('icons/icon-' + iconPath);
		loadGraphic(iconGraphic, true, Std.int(iconGraphic.width / 2), iconGraphic.height);

		initialWidth = width;
		initialHeight = height;

		animation.add('icon', [0, 1], 0, false, isPlayer);
		animation.play('icon');
		scrollFactor.set();
	}

	static private function getIconPath(char:String)
	{
		var trimmedCharacter:String = char;
		if (trimmedCharacter.contains('-'))
			trimmedCharacter = trimmedCharacter.substring(0, trimmedCharacter.indexOf('-'));

		var iconPath = char;
		while (!FileSystem.exists(Paths.getPath('images/icons/icon-' + iconPath + '.png', IMAGE)))
		{
			if (iconPath != trimmedCharacter)
				iconPath = trimmedCharacter;
			else
			{
				iconPath = 'face';
				trace('$char icon trying $iconPath instead you fuck');
			}
		}
		return iconPath;
	}

	static public function getIconColour(char:String, isPlayer:Bool = false):FlxColor
	{
		var iconPath = getIconPath(char);

		switch(iconPath)
		{
			case 'bf':
				return FlxColor.fromRGB(49,176,209);
			case 'pico':
				return FlxColor.fromRGB(183, 216, 85);
			case 'scp096':
				return FlxColor.fromRGB(204, 204, 204);
			case 'scp1788':
				return FlxColor.fromRGB(39, 222, 255);
			case 'scp4335':
				return FlxColor.fromRGB(156, 0, 196);
			default:
				return isPlayer ? 0xFF66FF33 : FlxColor.RED;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 45);
	}
}
