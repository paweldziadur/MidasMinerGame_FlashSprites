package com.dziadur.as3test.midasMiner.view.counters 
{
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ScoreCounterView extends MultiDigitCounterViewAbstractClass
	{
		public var score:int = 0;
		
		public function ScoreCounterView() 
		{
			super();
			score = 0;
			x = 54;
			y = 98;
		}
		override protected function init():void 
		{
			super.init();
			_labelTextField.text = "SCORE";
		}
		
		public function scoreDisplayUpdate(value:int):void
		{
			TweenMax.killTweensOf(this.score);
			
			TweenMax.to(this, 0.5, {score: value, onUpdate: function():void
				{
					updateMultiDigitCounter(score);
				}});
		}
		
		public function scoreDisplayReset():void
		{
			TweenMax.killTweensOf(this.score);
			score = 0;
			updateMultiDigitCounter(0);
		}
		
	}

}