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

class StageSchool extends Stage
{
	//School
	var bgGirls:BackgroundGirls;

	public function new()
	{
		super();
		this.curStage = 'school';

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
		// defaultCamZoom = 0.9;

		var bgSky = new FNFSprite().loadGraphic(Paths.image('backgrounds/' + curStage + '/weebSky'));
		bgSky.scrollFactor.set(0.1, 0.1);
		add(bgSky);

		var repositionShit = -200;

		var bgSchool:FNFSprite = new FNFSprite(repositionShit, 0).loadGraphic(Paths.image('backgrounds/' + curStage + '/weebSchool'));
		bgSchool.scrollFactor.set(0.6, 0.90);
		add(bgSchool);

		var bgStreet:FNFSprite = new FNFSprite(repositionShit).loadGraphic(Paths.image('backgrounds/' + curStage + '/weebStreet'));
		bgStreet.scrollFactor.set(0.95, 0.95);
		add(bgStreet);

		var fgTrees:FNFSprite = new FNFSprite(repositionShit + 170, 130).loadGraphic(Paths.image('backgrounds/' + curStage + '/weebTreesBack'));
		fgTrees.scrollFactor.set(0.9, 0.9);
		add(fgTrees);

		var bgTrees:FNFSprite = new FNFSprite(repositionShit - 380, -800);
		var treetex = Paths.getPackerAtlas('backgrounds/' + curStage + '/weebTrees');
		bgTrees.frames = treetex;
		bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
		bgTrees.animation.play('treeLoop');
		bgTrees.scrollFactor.set(0.85, 0.85);
		add(bgTrees);

		var treeLeaves:FNFSprite = new FNFSprite(repositionShit, -40);
		treeLeaves.frames = Paths.getSparrowAtlas('backgrounds/' + curStage + '/petals');
		treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
		treeLeaves.animation.play('leaves');
		treeLeaves.scrollFactor.set(0.85, 0.85);
		add(treeLeaves);

		var widShit = Std.int(bgSky.width * 6);

		bgSky.setGraphicSize(widShit);
		bgSchool.setGraphicSize(widShit);
		bgStreet.setGraphicSize(widShit);
		bgTrees.setGraphicSize(Std.int(widShit * 1.4));
		fgTrees.setGraphicSize(Std.int(widShit * 0.8));
		treeLeaves.setGraphicSize(widShit);

		fgTrees.updateHitbox();
		bgSky.updateHitbox();
		bgSchool.updateHitbox();
		bgStreet.updateHitbox();
		bgTrees.updateHitbox();
		treeLeaves.updateHitbox();

		bgGirls = new BackgroundGirls(-100, 190);
		bgGirls.scrollFactor.set(0.9, 0.9);

		if (PlayState.SONG.song.toLowerCase() == 'roses')
			bgGirls.getScared();

		bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
		bgGirls.updateHitbox();
		add(bgGirls);
	}

	// return the girlfriend's type
	override  public function returnGFtype()
	{
		return 'gf-pixel';
	}
	override  public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void
	{
		boyfriend.x += 200;
		boyfriend.y += 220;
		dad.x += 200;
		dad.y += 580;
		gf.x += 200;
		gf.y += 320;
	}

	override  public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		// trace('update backgrounds');
		bgGirls.dance();
	}
}
