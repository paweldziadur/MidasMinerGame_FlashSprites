package com.dziadur.as3test.midasMiner.view.dynamiteFuse 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import thanhtran.utils.EnterFrameManager;
	/**
	 * ...
	 * @author 
	 */
	public class DynamiteFuseSprite extends Sprite
	{
		
		public function DynamiteFuseSprite() // POSSIBILITY TO CHANGE FOR PARTICLES GENERATOR LATER
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF6060, 1);
			shape.graphics.drawCircle(0, 0, 5);
			shape.graphics.endFill();
			addChild(shape);
			EnterFrameManager.instance.enterFrame.add(enterFrameHandler);
		}
		
		public function enterFrameHandler(e:Event = null):void
		{
			this.alpha = Math.random() * 0.4+ 0.4;
			this.scaleX = this.scaleY = Math.random() * 0.6+0.2;
		}
		
	}

}