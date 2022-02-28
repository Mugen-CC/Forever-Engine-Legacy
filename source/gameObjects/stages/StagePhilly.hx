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

class StagePhilly extends Stage
{
	var phillyCityLights:FlxTypedGroup<FNFSprite>;
	var phillyTrain:FNFSprite;
	var trainSound:FlxSound;
	var curLight:Int = 0;
	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;
	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;
	var startedMoving:Bool = false;

	public function new()
	{
		super();
        
		this.curStage = 'philly';

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		var bg:FNFSprite = new FNFSprite(-100).loadGraphic(Paths.image('backgrounds/' + curStage + '/sky'));
		bg.scrollFactor.set(0.1, 0.1);
		add(bg);

		var city:FNFSprite = new FNFSprite(-10).loadGraphic(Paths.image('backgrounds/' + curStage + '/city'));
		city.scrollFactor.set(0.3, 0.3);
		city.setGraphicSize(Std.int(city.width * 0.85));
		city.updateHitbox();
		add(city);

		phillyCityLights = new FlxTypedGroup<FNFSprite>();
		add(phillyCityLights);

		for (i in 0...5)
		{
			var light:FNFSprite = new FNFSprite(city.x).loadGraphic(Paths.image('backgrounds/' + curStage + '/win' + i));
			light.scrollFactor.set(0.3, 0.3);
			light.visible = false;
			light.setGraphicSize(Std.int(light.width * 0.85));
			light.updateHitbox();
			light.antialiasing = true;
			phillyCityLights.add(light);
		}

		var streetBehind:FNFSprite = new FNFSprite(-40, 50).loadGraphic(Paths.image('backgrounds/' + curStage + '/behindTrain'));
		add(streetBehind);

		phillyTrain = new FNFSprite(2000, 360).loadGraphic(Paths.image('backgrounds/' + curStage + '/train'));
		add(phillyTrain);

		trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
		FlxG.sound.list.add(trainSound);

		// var cityLights:FNFSprite = new FNFSprite().loadGraphic(AssetPaths.win0.png);

		var street:FNFSprite = new FNFSprite(-40, streetBehind.y).loadGraphic(Paths.image('backgrounds/' + curStage + '/street'));
		add(street);
	}

	override  public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		// trace('update backgrounds');
		if (!trainMoving)
			trainCooldown += 1;

		if (curBeat % 4 == 0)
		{
			var lastLight:FlxSprite = phillyCityLights.members[0];

			phillyCityLights.forEach(function(light:FNFSprite)
			{
				// Take note of the previous light
				if (light.visible == true)
					lastLight = light;

				light.visible = false;
			});

			// To prevent duplicate lights, iterate until you get a matching light
			while (lastLight == phillyCityLights.members[curLight])
			{
				curLight = FlxG.random.int(0, phillyCityLights.length - 1);
			}

			phillyCityLights.members[curLight].visible = true;
			phillyCityLights.members[curLight].alpha = 1;

			FlxTween.tween(phillyCityLights.members[curLight], {alpha: 0}, Conductor.stepCrochet * .016);
		}

		if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
		{
			trainCooldown = FlxG.random.int(-4, 0);
			trainStart();
		}
	}

	override  public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		if (trainMoving)
		{
			trainFrameTiming += elapsed;

			if (trainFrameTiming >= 1 / 24)
			{
				updateTrainPos(gf);
				trainFrameTiming = 0;
			}
		}
	}

	// PHILLY STUFFS!
	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	function updateTrainPos(gf:Character):Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset(gf);
		}
	}

	function trainReset(gf:Character):Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}
}