package com.dziadur.as3test.midasMiner.view.board 
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.HighlightEvent;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author 
	 */
	public class HighlightMediator extends Mediator
	{
		
		[Inject]
		public var view:Highlight;
		
		override public function onRegister():void 
		{
            this.eventMap.mapListener(this.eventDispatcher, HighlightEvent.FADE_IN, onFadeIn);
            this.eventMap.mapListener(this.eventDispatcher, HighlightEvent.FADE_OUT, onFadeOut);
            this.eventMap.mapListener(this.eventDispatcher, HighlightEvent.DELAYED_FADE_OUT, onDelayedFadeOut);
            this.eventMap.mapListener(this.eventDispatcher, HighlightEvent.SET_LOCATION, onSetLocation);
            this.eventMap.mapListener(this.eventDispatcher, GameEvent.CLEAR_THE_BOARD_REQUEST, onClear);
		}
		
		protected function onFadeIn(e:HighlightEvent):void
		{
			view.fadeIn();
		}
		
		protected function onFadeOut(e:HighlightEvent):void
		{
			view.fadeOut();
		}	
		
		protected function onDelayedFadeOut(e:HighlightEvent):void
		{
			view.delayedFadeOut();
		}
		
		protected function onSetLocation(e:HighlightEvent):void
		{
			view.fadeOut();
			view.x = e.point.x * 45 + 340;
			view.y = e.point.y * 45 + 118;
			view.fadeIn();
		}
		
		protected function onClear(e:GameEvent):void
		{
			view.fadeOut();
		}
	}

}