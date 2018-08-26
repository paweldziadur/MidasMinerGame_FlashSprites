package com.dziadur.as3test.midasMiner.view.jewels
{
	
	/**
	 * ...
	 * @author
	 */
	public interface IJewelView
	{
		function explode(explosionType:uint):void
		
		function indicate():void
		
		function killRemove():void
		
		function get jewelType():uint
		
		function set jewelType(value:uint):void
		
		function get fall():uint
		
		function set fall(value:uint):void
		
		function get column():int
		
		function get row():int
	}

}