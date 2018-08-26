package com.dziadur.as3test.midasMiner.view.buttons 
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class StartGameButton extends Sprite
	{
		
		public function StartGameButton() 
		{
			alpha = 0;
			scaleX = scaleY = 0;
			useHandCursor = false;
			buttonMode = false;
			x = 497;
			y = 256;
			init();
		}
		
		protected function init():void
		{
			addChild(new TapToStartTheGame())
			fadeIn();
		}
		
		public function fadeIn():void
		{
			TweenMax.to(this, 0.5, { alpha:0.94, scaleX:1.5, scaleY:1.5, ease:Quint.easeOut} );
		}
		
		public function fadeOut():void
		{
			TweenMax.to(this, 0.5, { alpha:0, scaleX:0, scaleY:0,  ease:Quint.easeOut, onComplete:killRemove } );
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