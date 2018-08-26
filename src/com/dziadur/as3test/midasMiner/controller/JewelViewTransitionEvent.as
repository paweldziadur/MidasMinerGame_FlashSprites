package com.dziadur.as3test.midasMiner.controller 
{
	import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelViewTransitionEvent extends Event 
	{
		private var _jewel:JewelView;
		
		public static const EXPLODE:String = "explode";
		
		public function JewelViewTransitionEvent(type:String, aJewel:JewelView=null) 
		{
			if (aJewel)
			{
				_jewel = aJewel;
			}
			super(type);
		}
		
		public function get jewel():JewelView 
		{
			return _jewel;
		}
		
		override public function clone():Event
		{
			return new JewelViewTransitionEvent(type, jewel);
		}
	}
}