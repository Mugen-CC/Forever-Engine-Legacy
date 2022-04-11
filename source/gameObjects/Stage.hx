package gameObjects;

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
import gameObjects.background.*;
import gameObjects.stages.*;
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
class Stage extends FlxTypedGroup<FlxBasic>
{
	var daPixelZoom = PlayState.daPixelZoom;
	public var foreground:FlxTypedGroup<FlxBasic>;
	var curStage:String;

	public function new()
	{
		super();
	}

	static public function create(curStage:String):Stage
	{
		switch (CoolUtil.spaceToDash(PlayState.SONG.song.toLowerCase()))
		{
			case 'spookeez' | 'south' | 'monster':
				curStage = 'spooky';
			case 'pico' | 'blammed' | 'philly-nice':
				curStage = 'philly';
			case 'milf' | 'satin-panties' | 'high':
				curStage = 'highway';
			case 'cocoa' | 'eggnog':
				curStage = 'mall';
			case 'winter-horrorland':
				curStage = 'mallEvil';
			case 'senpai' | 'roses':
				curStage = 'school';
			case 'thorns':
				curStage = 'schoolEvil';
			case 'funny-scream' | 'scopophobia':
				curStage = 'mountains';
			default:
				curStage = 'stage';
		}
		trace('Stage "$curStage" created.');
		switch (curStage)
		{
			case 'stage':
				return new StageStage();
				/*
			case 'spooky':
				return new StageSpooky();
			case 'philly':
				return new StagePhilly();
			case 'highway':
				return new StageHighway();
			case 'mall':
				return new StageMall();
			case 'mallEvil':
				return new StageMallEvil();
			case 'school':
				return new StageSchool();
			case 'schoolEvil':
				return new StageSchoolEvil();*/
			case 'mountains':
				return new StageMountains();
			default:
				return new StageStage();
		}
	}

	// return the girlfriend's type
	public function returnGFtype(song:String = "")
	{
		return 'gf';
	}

	// get the dad's position
	public function dadPosition(boyfriend:Character, dad:Character, gf:Character, camPos:FlxPoint):Void
	{
		var characterArray:Array<Character> = [dad, boyfriend];
		for (char in characterArray) {
			switch (char.curCharacter)
			{
				case 'gf':
					char.setPosition(gf.x, gf.y);
					gf.visible = false;
				/*
					if (isStoryMode)
					{
						camPos.x += 600;
						tweenCamIn();
				}*/
				/*
				case 'spirit':
					var evilTrail = new FlxTrail(char, null, 4, 24, 0.3, 0.069);
					evilTrail.changeValuesEnabled(false, false, false, false);
					add(evilTrail);
					*/
			}
		}
	}

	public function repositionPlayers(boyfriend:Character, dad:Character, gf:Character):Void {}

	public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character) {}

	public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character) {}

	override function add(Object:FlxBasic):FlxBasic
	{
		if (Init.trueSettings.get('Disable Antialiasing') && Std.isOfType(Object, FlxSprite))
			cast(Object, FlxSprite).antialiasing = false;
		return super.add(Object);
	}
}
