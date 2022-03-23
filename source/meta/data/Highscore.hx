package meta.data;

import flixel.FlxG;
import flixel.math.FlxMath;

using StringTools;

class ScoreMetaData
{
	public var score:Int = 0;
	public var accuracy:Float = 0;
	public var comboBreaks:Int = -1;
	public function new(){}

	public static function lerp(lerpScore:ScoreMetaData, intendedScore:ScoreMetaData, lerpVal:Float)
	{
		var resultScore:ScoreMetaData = new ScoreMetaData();
		resultScore.score = Math.floor(FlxMath.lerp(lerpScore.score, intendedScore.score, lerpVal));
		if(resultScore.score != intendedScore.score && resultScore.score == lerpScore.score)
			resultScore.score += FlxMath.signOf(intendedScore.score - resultScore.score);
		resultScore.accuracy = FlxMath.lerp(lerpScore.accuracy, intendedScore.accuracy, lerpVal);
		if (Math.abs(intendedScore.accuracy - resultScore.accuracy)<0.01)
			resultScore.accuracy = intendedScore.accuracy;
		resultScore.comboBreaks = Math.ceil(FlxMath.lerp(lerpScore.comboBreaks, intendedScore.comboBreaks, lerpVal));
		if (resultScore.comboBreaks != intendedScore.comboBreaks && resultScore.comboBreaks == lerpScore.comboBreaks)
			resultScore.comboBreaks += FlxMath.signOf(intendedScore.comboBreaks - resultScore.comboBreaks);

		return resultScore;
	}
}
class Highscore
{
	#if (haxe >= "4.0.0")
	public static var songScores:Map<String, ScoreMetaData> = new Map();
	#else
	public static var songScores:Map<String, ScoreMetaData> = new Map<String, ScoreMetaData>();
	#end

	public static function saveScore(song:String, score:Int = 0, accuracy:Float = 0, combobreaks:Int = -1, ?diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		updateScore(daSong, score, accuracy, combobreaks);
	}

	public static function saveWeekScore(week:Int = 1, score:Int = 0, accuracy:Float = 0, combobreaks:Int = -1, ?diff:Int = 0):Void
	{
		var daWeek:String = formatSong('week' + week, diff);
		updateScore(daWeek, score, accuracy, combobreaks);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function updateScore(song:String, score:Int = 0, accuracy:Float = 0, combobreaks:Int = -1, ?diff:Int = 0):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		if (!songScores.exists(song))
		{
			songScores.set(song, new ScoreMetaData());
		}
		else
		{
			var scoreMetaData:ScoreMetaData = songScores.get(song);
			if (scoreMetaData.score < score)
				scoreMetaData.score = score;
			if (scoreMetaData.accuracy < accuracy)
				scoreMetaData.accuracy = accuracy;
			if (scoreMetaData.comboBreaks == -1 || scoreMetaData.comboBreaks > combobreaks)
				scoreMetaData.comboBreaks = combobreaks;

			songScores.set(song, scoreMetaData);
		}
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String
	{
		var daSong:String = song;

		var difficulty:String = '-' + CoolUtil.difficultyFromNumber(diff).toLowerCase();

		daSong += difficulty;

		return daSong;
	}

	public static function getScore(song:String, diff:Int):ScoreMetaData
	{
		if (!songScores.exists(formatSong(song, diff)))
			updateScore(formatSong(song, diff));

		return songScores.get(formatSong(song, diff));
	}

	public static function getWeekScore(week:Int, diff:Int):ScoreMetaData
	{
		if (!songScores.exists(formatSong('week' + week, diff)))
			updateScore(formatSong('week' + week, diff));

		return songScores.get(formatSong('week' + week, diff));
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
	}

	public static function clear():Void
	{
		FlxG.save.data.songScores = new Map<String, ScoreMetaData>();
		FlxG.save.flush();
	}
}
