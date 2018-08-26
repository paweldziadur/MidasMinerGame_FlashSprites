package com.dziadur.as3test.midasMiner.view 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ClearMethodEnabledViewContainer extends Sprite
	{
		
		public function ClearMethodEnabledViewContainer() 
		{
			super();
		}
		
		public function clear():void
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
	}

}