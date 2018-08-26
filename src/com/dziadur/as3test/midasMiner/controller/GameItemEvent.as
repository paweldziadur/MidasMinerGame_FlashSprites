package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.JewelItemVO;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class GameItemEvent extends Event
	{
		public static const JEWEL_CREATED:String = "jewel_created";
		public static const HIT_THE_GROUND:String = "hit_the_ground";
		public static const INDICATE_AS_MOVE_SUGGESTION:String = "indicate_as_move_suggestion";
		
		protected var _itemVO:JewelItemVO;
		
		public function GameItemEvent(type:String, itemVO:JewelItemVO = null)
		{
			super(type);
			_itemVO = itemVO;
		}
		
		public function get itemVO():JewelItemVO
		{
			return _itemVO;
		}
		
		override public function clone():Event
		{
			return new GameItemEvent(type, itemVO);
		}
	
	}
}
