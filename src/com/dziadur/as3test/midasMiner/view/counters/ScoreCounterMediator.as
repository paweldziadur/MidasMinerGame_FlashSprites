package com.dziadur.as3test.midasMiner.view.counters 
{

	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameScoreUpdateEvent;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author 
	 */
	public class ScoreCounterMediator extends Mediator
	{
		[Inject]
		public var view:ScoreCounterView;
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, GameScoreUpdateEvent.SCORE_UPDATE, onScoreUpdate);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.SCORE_RESET, onScoreReset);
		}
		
		protected function onScoreUpdate(e:GameScoreUpdateEvent):void
		{
			view.scoreDisplayUpdate(e.score);
		}
		
		protected function onScoreReset(e:GameEvent):void
		{
			view.scoreDisplayReset();
		}
		
	}

}