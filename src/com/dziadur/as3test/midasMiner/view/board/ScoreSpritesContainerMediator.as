package com.dziadur.as3test.midasMiner.view.board 
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameScoreRewardEvent;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.view.scoreEffects.ScoreRewardSprite;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author 
	 */
	public class ScoreSpritesContainerMediator extends Mediator
	{
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var view:ScoreSpritesContainer;
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, GameScoreRewardEvent.REWARD_WIN_GROUP, onRewardWinGroup);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.CLEAR_THE_BOARD_REQUEST, onClear);
		}
		
		protected function onRewardWinGroup(e:GameScoreRewardEvent):void
		{
			var reward:int = scoreResultsModel.rewardWinGroup(e.winGroupLength);
			
			view.addChild(new ScoreRewardSprite(reward, e.point1));
		}
		
		protected function onClear(e:GameEvent):void
		{
			view.clear();
		}
		
	}

}