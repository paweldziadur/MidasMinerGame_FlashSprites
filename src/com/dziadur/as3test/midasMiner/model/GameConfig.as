package com.dziadur.as3test.midasMiner.model 
{
	import org.robotlegs.mvcs.Actor;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class GameConfig extends Actor
	{
		public const TIME_LIMIT:uint = 600;
		
		public const DEBUG_MODE:Boolean = false;
		
		public const SHOW_CLUE_TIME:uint = 30;
		
		public function GameConfig() 
		{
			super();
		}
	}

}