package com.dziadur.as3test.midasMiner.view.jewels
{
	import com.dziadur.as3test.midasMiner.controller.JewelUserInteractionEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelMediator extends Mediator
	{
		[Inject]
		public var view:JewelView;
	
		override public function onRegister():void
		{
			addViewListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addViewListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			if (view.fall == 0)
			{
			addViewListener(MouseEvent.MOUSE_UP, onMouseUp);	
			dispatch(new JewelUserInteractionEvent(JewelUserInteractionEvent.MOUSE_DOWN, new Point(view.column, view.row)));
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
			removeViewListener(MouseEvent.MOUSE_UP, onMouseUp);
			dispatch(new JewelUserInteractionEvent(JewelUserInteractionEvent.MOUSE_UP, new Point(view.column, view.row)));
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			dispatch(new JewelUserInteractionEvent(JewelUserInteractionEvent.MOUSE_OVER, new Point(view.column, view.row)));
		
		}
	
	}

}