package com.dziadur.as3test.midasMiner.view.scoreEffects
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ScoreRewardSprite extends Sprite
	{
		[Embed(source="../../../../../../../lib/Kroe0555caps.ttf",fontName="kroeger 05_55 caps",mimeType="application/x-font")]
		private var kroeger_05_55_caps:Class;
		
		protected var _reward:int;
		protected var _resultTextField:TextField;
		protected var _textColor:uint;
		
		public function ScoreRewardSprite(aReward:int, aPoint:Point, aTextColor:uint = 0xF0F0F0)
		{
			_reward = aReward;
			_textColor = aTextColor;
			x = aPoint.x * 45;
			y = 315 - (aPoint.y * 45) - 135;
			scaleX = scaleY = 3.75;
			mouseEnabled = mouseChildren = false;
			init()
		}
		
		private function init():void
		{
			_resultTextField = getTextField();
			_resultTextField.x = 0;
			_resultTextField.y = 0;
			_resultTextField.text = String(_reward);
			
			addChild(_resultTextField);
			fadeOut();
		}
		
		private function getTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", 22, _textColor, null, null, null, null, null, "center");
			tf.autoSize = "center";
			tf.embedFonts = true;
			return tf;
		}
		
		public function fadeOut():void
		{
			alpha = 1.25;
			TweenMax.to(this, 2.5, {alpha: 0, y: this.y - 90, ease: Quint.easeOut, onComplete: killRemove});
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