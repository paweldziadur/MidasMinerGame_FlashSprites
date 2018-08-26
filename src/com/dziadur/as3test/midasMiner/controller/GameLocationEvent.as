package com.dziadur.as3test.midasMiner.controller 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class GameLocationEvent extends Event
	{
		public static const SWAP_JEWELS_ATTEMPT:String = "swap_jewels_attempt";
		
		protected var _point1:Point = new Point();
		protected var _point2:Point = new Point();
		
		public function GameLocationEvent(type:String, aPoint1:Point=null, aPoint2:Point = null)
		{
			super(type);
			_point1 = aPoint1;
			_point2 = aPoint2;
		}
		
		public function get point1():Point 
		{
			return _point1;
		}
		
		public function get point2():Point 
		{
			return _point2;
		}
		
		override public function clone():Event 
		{
			return new GameLocationEvent(type, point1, point2);
		}
	}
}