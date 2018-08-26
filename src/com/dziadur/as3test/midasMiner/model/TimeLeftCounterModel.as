package com.dziadur.as3test.midasMiner.model
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.TimeLeftCounterEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.robotlegs.mvcs.Actor;
	
	public class TimeLeftCounterModel extends Actor
	{
		protected var _timeLimit:int = 60;
		protected var _showClueTime:int = 25;
		
		public var timer:Timer = new Timer(1000);
		public var timeFromLastInteraction:uint = 0;
	
		public function TimeLeftCounterModel()
		{
			super();	
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public function start():void
		{
			timeFromLastInteraction = 0;
			timer.reset();
			timer.start();
		}
		
		public function stop():void
		{
			timeFromLastInteraction = 0;
			timer.stop();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			timeFromLastInteraction++
			{
				if (timeFromLastInteraction >= _showClueTime)
				{
					timeFromLastInteraction = _showClueTime * 0.125;
					dispatch(new GameEvent(GameEvent.SHOW_CLUE_REQUEST));
				}
			}
			
			if (timer.currentCount <= _timeLimit)
			{
				dispatch(new TimeLeftCounterEvent(TimeLeftCounterEvent.TICK, _timeLimit - this.timer.currentCount));
			}
			
			if (timer.currentCount >= _timeLimit)
			{
				timer.reset();
				dispatch(new GameEvent(GameEvent.END_GAME));
			}
		}
		
		public function get timeLimit():int 
		{
			return _timeLimit;
		}
	}
}