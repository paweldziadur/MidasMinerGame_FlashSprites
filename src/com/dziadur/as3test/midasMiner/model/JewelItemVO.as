package com.dziadur.as3test.midasMiner.model
{
	import com.dziadur.as3test.midasMiner.controller.GameDebugModeEvent;
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.dziadur.as3test.midasMiner.view.ClearMethodEnabledViewContainer;
	import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import org.robotlegs.mvcs.Actor;
	import thanhtran.utils.EnterFrameManager;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelItemVO extends Actor
	{
		
		public var jewelModelHelper:JewelModelHelper;
		public var gravityEnabled:Boolean = true;
		
		protected var _displayer:JewelView;
		protected var _fall:uint;
		protected var _jewelType:int;
		protected var _index:uint;
		protected var _name:String;
		protected var _timeFrame:int;
		protected var _newY:int;
		protected var _initialAltitude:int;
		protected var _initialTime:int;
		protected var _ground:int;
		protected var _hitTheGroudAlertResponsibility:Boolean = true;
		protected var _column:int;
		protected var _x:Number;
		protected var _y:Number;
		
		public function JewelItemVO(displayer:JewelView)
		{
			_displayer = displayer;
			_jewelType = displayer.jewelType;
			
			x = column * 45;
			EnterFrameManager.instance.enterFrame.add(enterFrameHandler);
		}
		
		public function enterFrameHandler(e:Event = null):void
		{
			displayer.x = x;
			displayer.y = y;
			
			if (gravityEnabled)
			{
				if ((y < _ground) && fall == 0)
				{
					fall = 1;
					_initialAltitude = y;
					_initialTime = getTimer();
				}
				
				if (fall != 0)
				{
					if (y >= _ground)
					{
						y = _ground;
						fall = 0;
						return;
					}
					else
					{
						_timeFrame = getTimer() - _initialTime;
						_newY = _initialAltitude + 0.00080 * _timeFrame * _timeFrame; // other slower time factor could be e.g. 0.00050 
						
						if (_newY >= _ground)
						{
							y = _ground;
							fall = 0;
							return;
						}
						else
						{
							y = _newY;
						}
					}
				}
			}
		}
		
		public function get displayer():JewelView
		{
			return _displayer;
		}
		
		public function get index():uint
		{
			return _index;
		}
		
		public function set index(value:uint):void
		{
			_index = value;
			_ground = 315 - index * 45;
		}
		
		public function get column():int
		{
			return _column;
		}
		
		public function set column(value:int):void
		{
			_column = value;
			x = value * 45;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get jewelType():int
		{
			return _jewelType;
		}
		
		public function set jewelType(value:int):void
		{
			_jewelType = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
			if (displayer && displayer.name)
			{
				displayer.name = name;
			}
		}
		
		public function get fall():uint
		{
			return _fall;
		}
		
		public function set fall(value:uint):void
		{
			_fall = value;
			if (displayer && displayer.fall)
			{
				displayer.fall = value;
			}
			if (value == 0)
			{
				jewelModelHelper.dispatchEvent(new GameItemEvent(GameItemEvent.HIT_THE_GROUND, this));
			}
		}
	
	}

}