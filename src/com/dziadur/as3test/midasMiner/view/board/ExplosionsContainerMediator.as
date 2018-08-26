package com.dziadur.as3test.midasMiner.view.board 
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.JewelViewTransitionEvent;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author 
	 */
	public class ExplosionsContainerMediator extends Mediator
	{
		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var view:ExplosionsContainer;
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, JewelViewTransitionEvent.EXPLODE, onExplode);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.CLEAR_THE_BOARD_REQUEST, onClear);
		}
		
		protected function onExplode(e:JewelViewTransitionEvent):void
		{
			view.addChild(e.jewel);
			e.jewel.explode(scoreResultsModel.multiplier);
			
			soundManager.jewelExplosion();
		}
		
		protected function onClear(e:GameEvent):void
		{
			view.clear();
		}
		
	}

}