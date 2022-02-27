package gameObjects.stages;

import gameObjects.Stage;

class StageSpooky extends Stage
{
	// Spooky
	var halloweenBG:FNFSprite;

	public function new(curStage)
	{
		super();
		this.curStage = curStage;

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			curStage = 'spooky';
			PlayState.curStage = curStage;
		}

		// to apply to foreground use foreground.add(); instead of add();
		foreground = new FlxTypedGroup<FlxBasic>();

		//
		curStage = 'spooky';
		// halloweenLevel = true;

		var hallowTex = Paths.getSparrowAtlas('backgrounds/' + curStage + '/halloween_bg');

		halloweenBG = new FNFSprite(-200, -100);
		halloweenBG.frames = hallowTex;
		halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
		halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
		halloweenBG.animation.play('idle');
		halloweenBG.antialiasing = true;
		add(halloweenBG);
	}

	// return the girlfriend's type
	public function returnGFtype(curStage)
	{
		return 'gf';
	}
}