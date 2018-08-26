package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class StartupCommand extends Command
	{

		[Inject]
		public var soundManager:SoundManager;
		
		override public function execute():void 
		{
			// NOT MUCH TO EXECUTE IN CONTEXT START UP COMMAND, EVERYTHING SET UP, MOST OF THE VIEW IS CREATED IN Main.createChildren()
			soundManager.intro();
		}
	}

}