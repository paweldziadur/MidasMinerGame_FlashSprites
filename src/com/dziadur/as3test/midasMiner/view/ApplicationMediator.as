package com.dziadur.as3test.midasMiner.view 
{
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view:Main;
		
		override public function onRegister():void 
		{
			view.createChildren();
		}
	}

}