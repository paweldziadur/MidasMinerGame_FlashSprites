package com.dziadur.as3test.midasMiner.view.board 
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.dziadur.as3test.midasMiner.view.ClueAsset;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author 
	 */
	public class MarkWinGroupsContainerMediator extends Mediator
	{
		[Inject]
		public var view:MarkWinGroupsContainer
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, GameItemEvent.INDICATE_AS_MOVE_SUGGESTION,onIdicateAsMoveSuggestion);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.CLEAR_THE_BOARD_REQUEST, onClear);
		}
		
		protected function onIdicateAsMoveSuggestion(e:GameItemEvent):void
		{
			e.itemVO.displayer.indicate();
			view.addChild(new ClueAsset(e.itemVO.column, e.itemVO.index));
		}
		
		protected function onClear(e:GameEvent):void
		{
			view.clear();
		}
		
	}

}