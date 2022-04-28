package meta.data;

import flixel.FlxG;
import flixel.math.FlxMath;

using StringTools;


class ScoreMetaData
{
	public var score:Int;
	public var accuracy:Float;
	public var comboBreaks:Int;

	public function new(_score:Int = 0, _acc:Float = 0, _misses:Int = -1){
		score = _score;
		accuracy = _acc;
		comboBreaks = _misses;
	}

	public function save(_score:Int, _acc:Float, _misses:Int){
		if(score < _score) score = _score;
		if(accuracy < _acc) accuracy = _acc;
		if(comboBreaks > _misses || comboBreaks < 0) comboBreaks = _misses;
	}

	static public function lerp(lerpScore:ScoreMetaData, intendedScore:ScoreMetaData, lerpVal:Float){
		if(lerpScore == null) return intendedScore;
		if(intendedScore == null) return lerpScore;
		var newScore:Int = Math.floor(FlxMath.lerp(lerpScore.score, intendedScore.score, lerpVal));
		if (newScore == lerpScore.score && newScore != intendedScore.score)
			newScore += FlxMath.signOf(intendedScore.score - newScore);
		
		var newAcc:Float = FlxMath.lerp(lerpScore.accuracy, intendedScore.accuracy, lerpVal);
		if (Math.abs(newAcc - lerpScore.accuracy) == 0.01)
			newAcc = intendedScore.accuracy;

		var newMisses:Int = Math.floor(FlxMath.lerp(lerpScore.comboBreaks, intendedScore.comboBreaks, lerpVal));
		if (newMisses == lerpScore.comboBreaks && newMisses != intendedScore.comboBreaks)
			newMisses += FlxMath.signOf(intendedScore.comboBreaks - newMisses);
		if (intendedScore.comboBreaks < 0) newMisses = -1;

		return new ScoreMetaData(newScore,newAcc,newMisses);
	}
}
class Highscore
{
	#if (haxe >= "4.0.0")
	private static var songScores:Map<String, ScoreMetaData> = new Map();
	private static var songFCs:Map<String, Int> = new Map();
	#else
	private static var songScores:Map<String, ScoreMetaData> = new Map<String, ScoreMetaData>();
	private static var songFCs:Map<String, Int> = new Map<String, Int>();
	#end


	public static function saveScore(song:String, score:Int, accuracy:Float, comboBreaks:Int, diff:Int):Void
	{
		if(comboBreaks == 0)
		{
			if (songFCs.exists(song))
			{
				if (songFCs.get(song) < diff)
					setFC(song, diff);
			}
			else
				setFC(song, diff);
		}

		var daSong:String = formatSong(song, diff);
			setScore(daSong, score, accuracy, comboBreaks);
	}

	public static function saveWeekScore(week:Int = 1, score:Int = 0, accuracy:Float, comboBreaks:Int, diff:Int):Void
	{
		if (comboBreaks == 0)
		{
			if (songFCs.exists('week' + week))
			{
				if (songFCs.get('week' + week) < diff)
					setFC('week' + week, diff);
			}
			else
				setFC('week' + week, diff);
		}

		var daWeek:String = formatSong('week' + week, diff);
		setScore(daWeek, score, accuracy, comboBreaks);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int, acc:Float, misses:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		var songScore = songScores.exists(song) ? songScores.get(song) : new ScoreMetaData();
		songScore.save(score,acc,misses);
		songScores.set(song, songScore);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	static function setFC(song:String, diff:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songFCs.set(song, diff);
		FlxG.save.data.songFCs = songFCs;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String
	{
		var daSong:String = song;

		var difficulty:String = '-' + CoolUtil.difficultyFromNumber(diff).toLowerCase();
		difficulty = difficulty.replace('-normal', '');

		daSong += difficulty;

		return daSong;
	}

	public static function getScore(song:String, diff:Int):ScoreMetaData
	{
		if (!songScores.exists(formatSong(song, diff)))
			setScore(formatSong(song, diff), 0,0,-1);

		return songScores.get(formatSong(song, diff));
	}

	public static function getWeekScore(week:Int, diff:Int):ScoreMetaData
	{
		if (!songScores.exists(formatSong('week' + week, diff)))
			setScore(formatSong('week' + week, diff), 0,0,-1);

		return songScores.get(formatSong('week' + week, diff));
	}

	public static function getFC(song:String):Int
	{
		if (!songFCs.exists(song))
			setFC(song, -1);

		return songFCs.get(song);
	}

	public static function getWeekFC(week:Int):Int
	{
		if (!songFCs.exists('week' + week))
			setFC('week' + week, -1);

		return songFCs.get('week' + week);
	}

	public static function clear():Void
	{
		songScores = new Map<String, ScoreMetaData>();
		songFCs = new Map<String, Int>();
		FlxG.save.data.songScores = songScores;
		FlxG.save.data.songFCs = songFCs;
		FlxG.save.flush();
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
		if (FlxG.save.data.songFCs != null)
		{
			songFCs = FlxG.save.data.songFCs;
		}
	}
}
