package gameObjects.stages;

import gameObjects.Stage;

class StageSchoolEvil extends Stage
{

	public function new(curStage)
	{
		super();
		this.curStage = curStage;

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			curStage = 'schoolEvil';
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
	public function returnGFtype(curStage)
	{
		return 'gf-pixel';
	}

	public function repositionPlayers(curStage, boyfriend:Character, dad:Character, gf:Character):Void
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
