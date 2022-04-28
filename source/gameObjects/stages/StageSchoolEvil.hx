package gameObjects.stages;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import gameObjects.Stage;
import gameObjects.background.*;
import meta.CoolUtil;
import meta.data.Conductor;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;

using StringTools;

/**
	This is the stage class. It sets up everything you need for stages in a more organised and clean manner than the
	base game. It's not too bad, just very crowded. I'll be adding stages as a separate
	thing to the weeks, making them not hardcoded to the songs.
**/
class StageSchoolEvil extends Stage
{
	public function new()
	{
		super();
		this.curStage = 'schoolEvil';

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		var posX = 400;
        var posY = 200;
        var bg:FNFSprite = new FNFSprite(posX, posY);
        bg.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/animatedEvilSchool');
        bg.animation.addByPrefix('idle', 'background 2', 24);
        bg.animation.play('idle');
        bg.scrollFactor.set(0.8, 0.9);
        bg.scale.set(6, 6);
        add(bg);
	}

	// return the girlfriend's type
	override public function returnGFtype()
	{
		return 'gf-pixel';
	}

	override  public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
        dad.x -= 150;
        dad.y += 50;
        boyfriend.x += 200;
        boyfriend.y += 220;
        gf.x += 180;
        gf.y += 300;
	}
}
