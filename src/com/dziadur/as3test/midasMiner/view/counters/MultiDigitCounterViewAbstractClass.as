package com.dziadur.as3test.midasMiner.view.counters 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class MultiDigitCounterViewAbstractClass extends Sprite
	{
		protected const DIGITS_QUANTITY:uint = 10;
		protected var _labelLocation:Point = new Point(0, 0);
		protected var _multiDigitDisplayLocation:Point = new Point(6, 32);
		
		
		protected var _multiDigitTextField:Vector.<TextField>;
		protected var _labelTextField:TextField;
		protected var _multiDigitValueAsString:String;
		
		protected var _fontColour:uint = 0x000000;
		protected var _digitWidth:Number = 16;
		protected var _labelFontSize:Number = 22;
		protected var _multiDigitTextFieldFontSize:Number = 26;
		
		[Embed(source="../../../../../../../lib/Kroe0555caps.ttf",fontName="kroeger 05_55 caps",mimeType="application/x-font")]
		private var kroeger_05_55_caps:Class;
		
		public function MultiDigitCounterViewAbstractClass() 
		{
			super();
			this.mouseEnabled = this.mouseChildren = false;
			init();
		}
		
		protected function init():void
		{
			initMultiDigitTextField();
			initLabelTextField();
			trace(" ");
		}
		
		protected function updateMultiDigitCounter(value:int):void
		{
			_multiDigitValueAsString = padWithZeros(String(value), DIGITS_QUANTITY);
			
			if (_multiDigitTextField)
			{
			for (var i:int = 0; i < DIGITS_QUANTITY; i++)
			{
				_multiDigitTextField[i].text = _multiDigitValueAsString.slice(i, i + 1);
			}
			}
		}
		
		protected function initLabelTextField():void
		{
			_labelTextField = getLabelTextField();
			_labelTextField.x = 0;
			_labelTextField.y = 0;
			addChild(_labelTextField);
		}
		
		protected function initMultiDigitTextField():void
		{
			_multiDigitTextField = new Vector.<TextField>(DIGITS_QUANTITY, true);
			
			for (var i:int = 0; i < DIGITS_QUANTITY; i++)
			{
				_multiDigitTextField[i] = getDigitsTextField();
				addChild(_multiDigitTextField[i]);
				_multiDigitTextField[i].y = _multiDigitDisplayLocation.y;
				_multiDigitTextField[i].x = _multiDigitDisplayLocation.x + i * _digitWidth;
				_multiDigitTextField[i].text = "0";
			}
		}
		
		protected function padWithZeros(string:String, digitsQuantity:uint):String
		{
			return String("0000000000000000000000000000000000000000000000000000000000000000").slice(0, digitsQuantity - string.length).concat(string);
		}
		
		protected function getLabelTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", _labelFontSize, 0x000000, null, null, null, null, null, "left");
			tf.autoSize = "left";
			tf.embedFonts = true;
			tf.textColor = _fontColour;
			return tf;
		}
		
		protected function getDigitsTextField():TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("kroeger 05_55 caps", _multiDigitTextFieldFontSize, 0x000000, null, null, null, null, null, "center");
			tf.autoSize = "center";
			tf.embedFonts = true;
			tf.textColor = _fontColour;
			return tf;
		}
		
		
		
	}

}