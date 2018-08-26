package com.dziadur.as3test.midasMiner.view.counters
{
	/**
	 * ...
	 * @author pawel dziadur
	 */
	
	import com.dziadur.as3test.midasMiner.controller.TimeLeftCounterEvent;
	import org.robotlegs.mvcs.Mediator;
	
	public class TimeLeftCounterMediator extends Mediator
	{
		[Inject]
		public var view:TimeLeftCounterView;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, TimeLeftCounterEvent.TICK, onTimeLeftCounterTick);
		}
		
		private function onTimeLeftCounterTick(e:TimeLeftCounterEvent):void
		{
			view.setTimeLeft(int(e.timeLeft));
		}
	
	}

}

