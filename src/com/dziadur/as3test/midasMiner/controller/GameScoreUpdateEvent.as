package com.dziadur.as3test.midasMiner.controller 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class GameScoreUpdateEvent extends Event
	{
		public static const SCORE_UPDATE:String = "score_update";
		
		protected var _score:int;
		
		public function GameScoreUpdateEvent(type:String, aScore:int)
		{
			super(type);
			_score = aScore;
		}
		
		public function get score():int 
		{
			return _score;
		}
		
		override public function clone():Event 
		{
			return new GameScoreUpdateEvent(type, score);
		}

	}
}