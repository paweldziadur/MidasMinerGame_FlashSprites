package com.dziadur.as3test.midasMiner.controller 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class HighlightEvent extends Event
	{
		public static const FADE_IN:String = "fade_in";
		public static const FADE_OUT:String = "fade_in";
		public static const DELAYED_FADE_OUT:String = "delayed_fade_out";
		public static const SET_LOCATION:String = "set_location"
		
		protected var _point:Point = new Point();
		
		public function HighlightEvent(type:String, aPoint:Point=null)
		{
			super(type);
			_point = aPoint;
		}
		
		public function get point():Point 
		{
			return _point;
		}
		
		override public function clone():Event 
		{
			return new HighlightEvent(type, point);
		}
	}
}