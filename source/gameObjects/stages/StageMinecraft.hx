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

class StageMinecraft extends Stage
{
	var xDelta = 0;
	var yDelta = 0;

	public function new()
	{
		super();
		this.curStage = 'minecraft';

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
		var bg:FNFSprite = new FNFSprite(xDelta, yDelta).loadGraphic(Paths.image('backgrounds/' + curStage + '/backgroundrender1'));
		bg.antialiasing = true;
		// bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;

		// add to the final array
		add(bg);

		//
		PlayState.defaultCamZoom = 0.9;
		var ground:FNFSprite = new FNFSprite(xDelta, yDelta).loadGraphic(Paths.image('backgrounds/' + curStage + '/foregroundrender1'));
		ground.antialiasing = true;
		// bg.scrollFactor.set(0.9, 0.9);
		ground.active = false;

		// add to the final array
		add(ground);

		/*var stageFront:FNFSprite = new FNFSprite(-650, 600).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagefront'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;

		// add to the final array
		add(stageFront);

		var stageCurtains:FNFSprite = new FNFSprite(-500, -300).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagecurtains'));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;

		// add to the final array
		add(stageCurtains);*/
	}

	override public function returnGFtype(song:String = "")
	{
		return 'gf-minecraft';
	}

	override public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.x += 350 + xDelta;
		boyfriend.y += 230 + yDelta;
		dad.x += 310 + xDelta;
		dad.y += 130 + yDelta;
		gf.x += 180 + xDelta;
		gf.y += 300 + yDelta;
	}
}