package com.dziadur.as3test.midasMiner.view.board 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author 
	 */
	public class BoardMask extends Shape
	{
		
		public function BoardMask() 
		{
		this.graphics.beginFill(0xFF0000, 0.25);
		this.graphics.drawRect(0, 0, 360, 360);
		this.graphics.endFill();
		}
		
	}

}