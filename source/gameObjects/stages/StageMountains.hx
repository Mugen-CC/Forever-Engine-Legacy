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

class StageMountains extends Stage
{
	var backCloud2:FNFSprite;
	var backCloud:FNFSprite;
	var frontCloud:FNFSprite;

	public function new()
	{
		super();
		this.curStage = 'mountains';

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		PlayState.defaultCamZoom = 0.9;
		addAsset('sky', 0.0);
		backCloud2 = addAsset('backCloud2', 0.05, 150);
		addAsset('backMountains', 0.1);
		backCloud = addAsset('backCloud', 0.12, -50);
		addAsset('frontMountains', 0.3,100);
		frontCloud = addAsset('frontCloud', 0.34, 750);
		addAsset('ground', 0.9);
	}

	override public function returnGFtype()
	{
		return null;
	}

	override public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.x += 225;
	}

	function addAsset(assetName:String, scroll:Float, xOffset:Float = 0)
	{
		var asset:FNFSprite = new FNFSprite(-339+xOffset,-150).loadGraphic(Paths.image('backgrounds/$curStage/$assetName'));
		asset.antialiasing = true;
		asset.scrollFactor.set(scroll, scroll);
		asset.active = false;
		add(asset);
		return asset;
	}

	override public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		backCloud2.x += 2 * elapsed;
		backCloud.x += 2 * elapsed;
		frontCloud.x += 2 * elapsed;
	}
}