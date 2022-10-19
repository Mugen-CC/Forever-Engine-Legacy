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

class StagePark extends Stage
{

	public function new()
	{
		super();
		this.curStage = 'park';

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
		PlayState.defaultCamZoom = 0.9;
		var bg:FNFSprite = new FNFSprite(-470, -235).loadGraphic(Paths.image('backgrounds/' + curStage + '/resolution'));
		bg.antialiasing = true;
		//bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;

		// add to the final array
		add(bg);
	}

	override public function returnGFtype(song:String = "")
	{
		return 'gf-park';
	}

	override public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.x += 125;
		dad.x -= 160;
		gf.y += 245;
	}
}