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
class StageSpooky extends Stage
{
	var halloweenBG:FNFSprite;

	public function new()
	{
		super();
		this.curStage = 'spooky';

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

        // halloweenLevel = true;

        var hallowTex = Paths.getSparrowAtlas('backgrounds/' + curStage + '/halloween_bg');

        halloweenBG = new FNFSprite(-200, -100);
        halloweenBG.frames = hallowTex;
        halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
        halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
        halloweenBG.animation.play('idle');
        halloweenBG.antialiasing = true;
        add(halloweenBG);
	}
}
