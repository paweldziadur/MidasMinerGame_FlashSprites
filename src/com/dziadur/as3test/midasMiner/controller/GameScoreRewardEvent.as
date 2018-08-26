package com.dziadur.as3test.midasMiner.controller 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class GameScoreRewardEvent extends Event
	{
		public static const REWARD_WIN_GROUP:String = "reward_win_group";
		
		protected var _point1:Point = new Point();
		protected var _winGroupLength:uint;
		
		public function GameScoreRewardEvent(type:String, aPoint1:Point=null, aWinGroupLength:uint = 0)
		{
			super(type);
			_point1 = aPoint1;
			_winGroupLength = aWinGroupLength;
		}
		
		public function get point1():Point 
		{
			return _point1;
		}
		
		public function get winGroupLength():uint 
		{
			return _winGroupLength;
		}
		
		override public function clone():Event 
		{
			return new GameScoreRewardEvent(type, point1, winGroupLength);
		}
	}
}