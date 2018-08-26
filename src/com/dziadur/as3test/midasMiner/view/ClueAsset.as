package com.dziadur.as3test.midasMiner.view
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author
	 */
	public class ClueAsset extends Sprite
	{
		public function ClueAsset(aColumn:uint, aIndex:uint)
		{
			x = 45 * aColumn;
			y = 315 - 45 * aIndex;
			addChild(new HighlightAsset());
			alpha = 0;
			mouseChildren = mouseEnabled = false;
			fadeOut();
		}
		
		protected function fadeOut():void
		{
			TweenMax.killTweensOf(this);
			alpha = 0;
			scaleX = scaleY = 1;
			TweenMax.to(this, 0.66, {rotation: 360, alpha: 0.33, scaleX: 1.002, scaleY: 1.002, repeat: 1, yoyo: true, onComplete: killRemove});
		}
		
		public function killRemove():void
		{
			if (parent)
			{
				this.parent.removeChild(this);
			}
		}
	
	}

}