package com.dziadur.as3test.midasMiner.model
{
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.dziadur.as3test.midasMiner.controller.GameLocationEvent;
	import com.dziadur.as3test.midasMiner.controller.JewelUserInteractionEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Actor;
	
	public class SelectionModel extends Actor
	{
		public var firstClickComplete:Boolean = false;
		
		protected var _interactionAllowed:Boolean = true;
		protected var _interactionCausedJewelRemoval:Boolean = false;
		protected var _dragging:Boolean = false;
		
		protected var _firstClickPoint:Point;
		protected var _secondClickPoint:Point;
		protected var _mouseOverRegister:Point;
		
		public function SelectionModel()
		{
			super();
		}
		
		public function get firstClickPoint():Point
		{
			return _firstClickPoint;
		}
		
		public function set firstClickPoint(value:Point):void
		{
			if (_interactionAllowed)
			{
				_firstClickPoint = value;
			}
		}
		
		public function get secondClickPoint():Point
		{
			return _secondClickPoint;
		}
		
		public function set secondClickPoint(value:Point):void
		{
			if (_interactionAllowed)
			{
				_secondClickPoint = value;
				firstClickComplete = false;
				if (Point.distance(firstClickPoint, secondClickPoint) == 1)
				{
					replaceAttempt();
				}
			}
		}
		
		public function replaceAttempt():void
		{
			firstClickComplete = false;
			
			dispatch(new GameLocationEvent(GameLocationEvent.SWAP_JEWELS_ATTEMPT, firstClickPoint, secondClickPoint));
		}
		
		public function get interactionAllowed():Boolean
		{
			return _interactionAllowed;
		}
		
		public function set interactionAllowed(value:Boolean):void
		{
			_interactionAllowed = value;
			if (_interactionAllowed)
			{
				firstClickComplete = false;
			}
		}
		
		public function get mouseOverRegister():Point
		{
			return _mouseOverRegister;
		}
		
		public function set mouseOverRegister(value:Point):void
		{
			_mouseOverRegister = value;
		}
		
		public function get interactionCausedJewelRemoval():Boolean
		{
			return _interactionCausedJewelRemoval;
		}
		
		public function set interactionCausedJewelRemoval(value:Boolean):void
		{
			_interactionCausedJewelRemoval = value;
		}
		
		public function get dragging():Boolean
		{
			return _dragging;
		}
		
		public function set dragging(value:Boolean):void
		{
			_dragging = value;
		}
	}
}