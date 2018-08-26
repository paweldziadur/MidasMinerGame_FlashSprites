package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.TimeLeftCounterModel;
	import org.robotlegs.mvcs.Command;
	
	public class TimeLeftCounterStartCommand extends Command
	{
		[Inject]
		public var timeLeftCounterModel:TimeLeftCounterModel;
		
		override public function execute():void
		{
			trace("[TimeLeftCounterStartCommand.execute]");
			timeLeftCounterModel.start();
		}
	}
}