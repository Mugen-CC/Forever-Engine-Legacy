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

class StageMallEvil extends Stage
{
	public function new()
	{
		super();
		this.curStage = 'mallEvil';

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
		var bg:FNFSprite = new FNFSprite(-400, -500).loadGraphic(Paths.image('backgrounds/mall/evilBG'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.2, 0.2);
		bg.active = false;
		bg.setGraphicSize(Std.int(bg.width * 0.8));
		bg.updateHitbox();
		add(bg);

		var evilTree:FNFSprite = new FNFSprite(300, -300).loadGraphic(Paths.image('backgrounds/mall/evilTree'));
		evilTree.antialiasing = true;
		evilTree.scrollFactor.set(0.2, 0.2);
		add(evilTree);

		var evilSnow:FNFSprite = new FNFSprite(-200, 700).loadGraphic(Paths.image("backgrounds/mall/evilSnow"));
		evilSnow.antialiasing = true;
		add(evilSnow);
	}

	// return the girlfriend's type
	override public function returnGFtype(song:String = "")
	{
		return 'gf-christmas';
	}

	override  public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.x += 320;
	}
}