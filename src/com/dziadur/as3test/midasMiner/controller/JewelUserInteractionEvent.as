package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelUserInteractionEvent extends Event
	{
		public static const MOUSE_DOWN:String = "mouse_down"
		public static const MOUSE_UP:String = "mouse_up";
		public static const MOUSE_OVER:String = "mouse_over";
		
		protected var _point:Point;
		
		public function JewelUserInteractionEvent(type:String, aPoint:Point)
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
			return new JewelUserInteractionEvent(type, point);
		}
	
	}

}