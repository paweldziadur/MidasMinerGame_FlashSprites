package com.dziadur.as3test.midasMiner.view.debug 
{
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class StartGameButtonFixed extends Sprite
	{
		
		public function StartGameButtonFixed() 
		{
			alpha = 0.7;
			scaleX = scaleY = 0.3;
			useHandCursor = false;
			buttonMode = true;
			x = 728;
			y = 580;
			init();
		}
		
		public function init():void
		{
			addChild(new TapToStartTheGame())
		}
		
		public function killRemove():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
		
	}

}