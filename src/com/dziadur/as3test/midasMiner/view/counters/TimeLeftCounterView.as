package com.dziadur.as3test.midasMiner.view.counters
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class TimeLeftCounterView extends Sprite
	{
		protected var textField:Vector.<TextField>;
		
		[Embed(source="../../../../../../../lib/Kroe0555caps.ttf",fontName="kroeger 05_55 caps",mimeType="application/x-font")]
		private var kroeger_05_55_caps:Class;
		
		protected var _minutes:int;
		protected var _secondsToString:String;
		protected var _miunutesToString:String;
		
		public function TimeLeftCounterView()
		{
			this.mouseEnabled = this.mouseChildren = false;
			x = 78;
			y = 420;
			
			textField = new Vector.<TextField>;
			
			var textFieldLocX:Array = new Array(0, 0 + 6, 16 + 6, 32 + 6, 48 + 6, 64 + 6);
			var textFieldLocY:Array = new Array(0, 32, 32, 32, 32, 32);
			var textFieldText:Array = new Array("TIME", "0", "0", ":", "0", "0");
			
			for (var i:int = 0; i < 6; i++)
			{
				if (i == 0)
				{
					textField[i] = getLabelTextField();
				}
				else
				{
					textField[i] = getDigitsTextField();
				}
				addChild(textField[i]);
				textField[i].x = textFieldLocX[i];
				textField[i].y = textFieldLocY[i];
				textField[i].text = textFieldText[i];
			}
		}
		
		public function setTimeLeft(n:int):void
		{
			_minutes = int(Math.floor(n / 60));
			_secondsToString = String(n - _minutes * 60);
			_miunutesToString = String(_minutes);
			
			_secondsToString = String("00").slice(0, 2 - _secondsToString.length).concat(_secondsToString);
			_miunutesToString = String("00").slice(0, 2 - _miunutesToString.length).concat(_miunutesToString);
			
			textField[1].text = _miunutesToString.slice(0, 1);
			textField[2].text = _miunutesToString.slice(1, 2);
			
			textField[4].text = _secondsToString.slice(0, 1);
			textField[5].text = _secondsToString.slice(1, 2);
		
		}
		
		protected function getLabelTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", 22, 0x000000, null, null, null, null, null, "left");
			tf.autoSize = "left";
			tf.embedFonts = true;
			tf.textColor = 0x000000;
			return tf;
		}
		
		protected function getDigitsTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", 26, 0x000000, null, null, null, null, null, "center");
			tf.autoSize = "center";
			tf.embedFonts = true;
			tf.textColor = 0x000000;
			return tf;
		}
	
	}

}