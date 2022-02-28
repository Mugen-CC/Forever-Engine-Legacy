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

class StageHighway extends Stage
{
	public var limo:FNFSprite;
	public var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FNFSprite;

	public function new()
	{
		super();
		curStage = 'highway';

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		PlayState.defaultCamZoom = 0.90;

		var skyBG:FNFSprite = new FNFSprite(-120, -50).loadGraphic(Paths.image('backgrounds/' + curStage + '/limoSunset'));
		skyBG.scrollFactor.set(0.1, 0.1);
		add(skyBG);

		var bgLimo:FNFSprite = new FNFSprite(-200, 480);
		bgLimo.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/bgLimo');
		bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
		bgLimo.animation.play('drive');
		bgLimo.scrollFactor.set(0.4, 0.4);
		add(bgLimo);

		grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
		add(grpLimoDancers);

		for (i in 0...5)
		{
			var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
			dancer.scrollFactor.set(0.4, 0.4);
			grpLimoDancers.add(dancer);
		}

		var overlayShit:FNFSprite = new FNFSprite(-500, -600).loadGraphic(Paths.image('backgrounds/' + curStage + '/limoOverlay'));
		overlayShit.alpha = 0.5;
		// add(overlayShit);

		// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

		// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

		// overlayShit.shader = shaderBullshit;

		var limoTex = Paths.getSparrowAtlas('backgrounds/' + curStage + '/limoDrive');

		limo = new FNFSprite(-120, 550);
		limo.frames = limoTex;
		limo.animation.addByPrefix('drive', "Limo stage", 24);
		limo.animation.play('drive');
		limo.antialiasing = true;

		fastCar = new FNFSprite(-300, 160).loadGraphic(Paths.image('backgrounds/' + curStage + '/fastCarLol'));
		// loadArray.add(limo);
	}

	// return the girlfriend's type
	override  public function returnGFtype()
	{
		return 'gf-car';
	}

	override  public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.y -= 220;
		boyfriend.x += 260;
	}

	override public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		// trace('update backgrounds');
		// trace('highway update');
		grpLimoDancers.forEach(function(dancer:BackgroundDancer)
		{
			dancer.dance();
		});
	}
}