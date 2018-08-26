package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.controller.JewelUserInteractionEvent;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.view.board.Highlight;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelUserInteractionCommand extends Command
	{
		[Inject]
		public var selectionModel:SelectionModel;
		
		[Inject]
		public var event:JewelUserInteractionEvent;
		
		private var _point:Point;
		
		override public function execute():void
		{
			_point = event.point;
			//trace("[JewelUserInteractionCommand.execute] " + _point.x + " " + _point.y + " " + e.type);
			
			if (event.type == JewelUserInteractionEvent.MOUSE_UP)
			{
				selectionModel.dragging = false;
			}
			else if (event.type == JewelUserInteractionEvent.MOUSE_DOWN)
			{
				if (selectionModel.firstClickComplete == false && selectionModel.interactionAllowed)
				{
					//trace("[JewelUserInteractionCommand.execute] first click " + _point.x + " " + _point.y);
					
					//dispatch(new HighlightEvent(HighlightEvent.SET_LOCATION, _point));
					
					(contextView.getChildAt(3) as Highlight).x = _point.x * 45 + 340; // CHOSEN TO GO DERICTLY TO DISPLAY LIST HERE AS IT IS MORE RESPONSIVE, AND THE HIGHLIGH FADE IN NEEDS TO FIT A VERY SHORT PERIOD BEFORE MOUSE IS DRAGGED AWAY
					(contextView.getChildAt(3) as Highlight).y = _point.y * 45 + 118;
					(contextView.getChildAt(3) as Highlight).fadeIn();
					
					selectionModel.dragging = true;
					selectionModel.firstClickPoint = _point;
					selectionModel.firstClickComplete = true;
				}
				else
				{
					//trace("[JewelUserInteractionCommand.execute] second click " + _point.x + " " + _point.y);
					
					dispatch(new HighlightEvent(HighlightEvent.FADE_OUT));
					selectionModel.secondClickPoint = _point;
				}
			}
			else if (event.type == JewelUserInteractionEvent.MOUSE_OVER && selectionModel.dragging==true && selectionModel.firstClickComplete)
			{ 
				selectionModel.dragging = false;
				selectionModel.mouseOverRegister = _point;
				dispatch(new HighlightEvent(HighlightEvent.FADE_OUT));
				selectionModel.secondClickPoint = _point;	
			}
		
		}
	
	}

}