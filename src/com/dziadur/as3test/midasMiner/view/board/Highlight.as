package com.dziadur.as3test.midasMiner.view.board 
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Highlight extends Sprite 
	{
		public function Highlight() 
		{
			super();
			addChild(new HighlightAsset());
			alpha = 0;
		}
		
		public function fadeIn():void
		{
			TweenMax.to(this, 0.05, { alpha:0.75, scaleX:1, scaleY:1, ease:Quint.easeOut} );
		}
		
		public function delayedFadeOut():void
		{
			TweenMax.to(this, 0.05, { alpha:0, scaleX:0, scaleY:0, ease:Quint.easeOut, delay:0.15} );
		}
		
		public function fadeOut():void
		{
			TweenMax.to(this, 0.05, { alpha:0, scaleX:0, scaleY:0, ease:Quint.easeOut} );
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