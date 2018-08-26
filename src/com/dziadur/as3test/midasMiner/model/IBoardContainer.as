/**
 * @author Cotton Hou
 */
package com.dziadur.as3test.midasMiner.model
{
	import flash.events.Event;
	import flash.geom.Point;

public interface IBoardContainer
{

    function add(column:uint, item:JewelItemVO):void;
   
	function getItem(column:int, index:int):JewelItemVO;
	
	function resetBoardVectors():void;
	
	function swapJewels(item1:JewelItemVO, item2:JewelItemVO):void
	
	function takeOutJewels(takeOutVector:Vector.<uint>):void
	
	function getJewelTypesGridVector(aItemToSwap1:JewelItemVO = null, aItemToSwap2:JewelItemVO = null):Vector.<Vector.<uint>>
	
	function get gridVector():Vector.<Vector.<uint>>
	
	function get itemsVector():Vector.<Vector.<JewelItemVO>>;
}
}

