package com.dziadur.as3test.midasMiner.view.dynamiteFuse
{
	import com.dziadur.as3test.midasMiner.controller.TimeLeftCounterEvent;
	import com.dziadur.as3test.midasMiner.model.TimeLeftCounterModel;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class DynamiteFuseMediator extends Mediator
	{

		[Inject]
		public var timeLeftCounterModel:TimeLeftCounterModel;
		[Inject]
		public var view:DynamiteFuseView;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, TimeLeftCounterEvent.STOP, onTimeLeftCounterStop);
			eventMap.mapListener(eventDispatcher, TimeLeftCounterEvent.START, onTimeLeftCounterStart);
		}
		
		private function onTimeLeftCounterStop(e:TimeLeftCounterEvent):void
		{
			view.stop();
		}
		
		private function onTimeLeftCounterStart(e:TimeLeftCounterEvent):void
		{
			view.start(timeLeftCounterModel.timeLimit);
		}
	
	}

}