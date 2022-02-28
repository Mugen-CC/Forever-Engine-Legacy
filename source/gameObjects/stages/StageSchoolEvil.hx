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
import gameObjects.stages.*;
import meta.CoolUtil;
import meta.data.Conductor;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;

class StageSchoolEvil extends Stage
{

	public function new()
	{
		super();
		this.curStage = 'schoolEvil';

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		//
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
	override  public function returnGFtype()
	{
		return 'gf-pixel';
	}

	override  public function repositionPlayers( boyfriend:Character, dad:Character, gf:Character):Void
	{
		// REPOSITIONING PER STAGE
		dad.x -= 150;
		dad.y += 50;
		boyfriend.x += 200;
		boyfriend.y += 220;
		gf.x += 180;
		gf.y += 300;
	}
}
