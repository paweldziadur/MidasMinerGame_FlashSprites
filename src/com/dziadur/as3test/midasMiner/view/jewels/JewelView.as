package com.dziadur.as3test.midasMiner.view.jewels
{
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class JewelView extends Sprite implements IJewelView
	{
		protected var _jewelType:int;
		protected var _fall:uint;
		protected var _column:int;
		protected var _row:int;
		
		public function JewelView(aJewelType:int)
		{
			buttonMode = false;
			useHandCursor = false;
			jewelType = aJewelType;
		}
		
		public function get jewelType():uint
		{
			return _jewelType;
		}
		
		public function set jewelType(value:uint):void
		{
			_jewelType = value;
			// REMOVE ALL CHILDREN FROM THE CONTAINER
			//
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			// ADD THE APPROPRIATE ASSET
			//
			var dynClass:Class = getDefinitionByName(String("Jewel_" + value)) as Class;
			var jewelAsset:Sprite = new dynClass() as Sprite;
			addChild(jewelAsset);
			
			// ADDING THE SPRITE BELOW WILL HELP MOUSE INTERACTION
			//
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFFFF00, 0);
			square.graphics.drawRect(-22.5, -22.5, 45, 45);
			square.graphics.endFill();
			addChild(square);
		}

		public function get fall():uint
		{
			return _fall;
		}
		
		public function set fall(value:uint):void
		{
			_fall = value;
		}
		
		public function get column():int
		{
			return Math.round(x / 45); 
		}
		
		public function get row():int
		{
			return Math.round(y / 45); 
		}
		
		public function indicate():void
		{
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0.5, { rotation: Math.random() * 0 - 0, scaleX: 1.025, scaleY: 1.025, repeat:3, yoyo:true, onComplete: idnicateFinish } );
		}
		
		protected function idnicateFinish():void
		{
			scaleX = scaleY = 1;
		}
		
		public function explode(explosionType:uint):void
		{ 
			alpha = 0.66;
			if (explosionType <  2)
			{
			TweenMax.to(this, 0.75, {alpha: 0.33, rotation: Math.random() * 90 - 45, scaleX: 0.1, scaleY: 0.1, ease: Quint.easeOut, onComplete: killRemove});;
			}
			else
			{
			TweenMax.to(this, 0.75, {alpha: 0.33, rotation: Math.random() * 90 - 45, scaleX: 0.1, scaleY: 0.1, ease: Quint.easeOut, onComplete: plasmaStyleBlow});;
			}
		}
		
		protected function plasmaStyleBlow():void
		{
			TweenMax.to(this, 1.75, {alpha: 0, rotation: Math.random() * 180 - 90, scaleX: 2 + Math.random() * 18, scaleY: 2 + Math.random() * 18, ease: Quint.easeOut, onComplete: killRemove});;
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