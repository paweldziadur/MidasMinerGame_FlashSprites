package com.dziadur.as3test.midasMiner.view.buttons 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class EndGameButton extends StartGameButton
	{
		public var score:int;
		
		public function EndGameButton(aScore:int) 
		{
			score = aScore;
			super();
		}
		
		override protected function init():void 
		{
			var yourScoreWas:YourScoreWas = new YourScoreWas();
			yourScoreWas._scoreTF.text = String(score);
			addChild(yourScoreWas);
			fadeIn();
		}
		
		private function getTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", 22, 0x000000, null, null, null, null, null, "left");
			tf.autoSize = "left";
			tf.embedFonts = true;
			return tf;
		}
	}

}