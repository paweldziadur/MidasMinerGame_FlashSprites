package com.dziadur.as3test.midasMiner.view.board 
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author 
	 */
	public class BoardMediator extends Mediator 
	{
		[Inject]
		public var view:BoardView;
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, GameItemEvent.JEWEL_CREATED, onJewelCreated);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.CLEAR_THE_BOARD_REQUEST, onClear);
		}
		
		protected function onJewelCreated(e:GameItemEvent):void
		{
			view.addChildAt(e.itemVO.displayer, 0);
		}
		
		protected function onClear(e:GameEvent):void
		{
			view.clear();
		}
		
		
	}

}