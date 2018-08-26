package com.dziadur.as3test.midasMiner.view.debug
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class StartGameButtonFixedMediator extends Mediator
	{
		
		[Inject]
		public var view:StartGameButtonFixed;
		
		override public function onRegister():void
		{
			addViewListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			dispatch(new GameEvent(GameEvent.START_GAME_CLICKED));
		}
	
	}

}