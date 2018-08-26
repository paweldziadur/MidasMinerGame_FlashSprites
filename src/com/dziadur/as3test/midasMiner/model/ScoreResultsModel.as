package com.dziadur.as3test.midasMiner.model
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameScoreUpdateEvent;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author
	 */
	public class ScoreResultsModel extends Actor
	{
		protected var _score:int = 0;
		protected var _scoreBase:int = 10;
		protected var _multiplier:Number  = 1;
		protected var _gameOn:Boolean = false; // WHEN ANY OF THE JEWELS FALL DOWN JUST AFTER THE TIME LIMIT REACHES ZERO THEY WON'T BE ADDED TO SCORE
		
		public function ScoreResultsModel()
		{
			super();
		}
		
		public function scoreReset():void
		{
			_score = 0;
			multiplier = 1;
			dispatch(new GameEvent(GameEvent.SCORE_RESET));
		}
		
		public function get score():int
		{
			return _score;
		}
		
		public function set score(value:int):void
		{
			_score = value;
			dispatch(new GameScoreUpdateEvent(GameScoreUpdateEvent.SCORE_UPDATE, score));
		}
		
		public function addToScore(value:int):void
		{
			score = score + value;
		}
		
		public function rewardWinGroup(winGroupLenght:uint):int
		{
			var reward:int = _scoreBase * (multiplier * 0.5 + 0.5) * 2 * Math.pow(2, winGroupLenght - 2);
			addToScore(reward);
			return reward;
		}
		
		public function get multiplier():Number 
		{
			return _multiplier;
		}
		
		public function set multiplier(value:Number):void
		{
			_multiplier = value;
		}
		
		public function get gameOn():Boolean 
		{
			return _gameOn;
		}
		
		public function set gameOn(value:Boolean):void 
		{
			_gameOn = value;
		}
	
	}

}