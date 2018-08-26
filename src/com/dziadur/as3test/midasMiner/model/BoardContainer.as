package com.dziadur.as3test.midasMiner.model
{
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.dziadur.as3test.midasMiner.controller.JewelViewTransitionEvent;
	import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
	import flash.events.Event;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class BoardContainer extends Actor implements IBoardContainer
	{
		
		[Inject]
		public var jewelModelHelper:JewelModelHelper;
		
		private var _gridVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(5, true);
		private var _itemsVector:Vector.<Vector.<JewelItemVO>> = new Vector.<Vector.<JewelItemVO>>(8, true);
		
		public function BoardContainer()
		{
			_gridVector = new Vector.<Vector.<uint>>(5, true);
			resetBoardVectors();
		}
		
		public function add(column:uint, item:JewelItemVO):void
		{
			item.column = column;
			item.jewelModelHelper = jewelModelHelper;
			item.name = "jewel_" + column + "_" + index; // WE ARE ASSIGNING THE NAME PROPERTY HOWEVER IT IS NOT USED IN FOR THE CURRENT REVISION OF GAME SOURCE
			
			var index:uint = itemsVector[column].push(item) - 1;
			_itemsVector[column][index].index = index;
			dispatch(new GameItemEvent(GameItemEvent.JEWEL_CREATED, item));
		}
		

		public function swapJewels(item1:JewelItemVO, item2:JewelItemVO):void
		{
			var index1:uint = itemsVector[item1.column].indexOf(item1);
			var index2:uint = itemsVector[item2.column].indexOf(item2);
			
			var column1:uint = item1.column;
			var column2:uint = item2.column;
			
			itemsVector[column1][index1] = item2;
			itemsVector[column2][index2] = item1;
			
			updateIndexValues(column1);
			updateIndexValues(column2);
			item1.gravityEnabled = item2.gravityEnabled = true;
			dispatch(new GameEvent(GameEvent.BOARD_UPDATE_REQUEST));
		}
		
		protected function getNewZeroedJewelTypesGridVector():Vector.<Vector.<uint>>
		{
			var jewelTypesGridVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(5, true);
			for (var i:int = 0; i < 5; i++)
			{
				jewelTypesGridVector[i] = new Vector.<uint>(16, true);
				
				for (var j:int = 0; j < 16; j++)
				{
					jewelTypesGridVector[i][j] = 0;
				}
			}
			return jewelTypesGridVector;
		}
		
		public function getJewelTypesGridVector(aItemToSwap1:JewelItemVO = null, aItemToSwap2:JewelItemVO = null):Vector.<Vector.<uint>>
		{
			var jewelTypesGridVector:Vector.<Vector.<uint>> = getNewZeroedJewelTypesGridVector();
			var len:int;
			var item:JewelItemVO;
			
			for (var column:int = 0; column < 8; column++)
			{
				len = itemsVector[column].length;
				
				for (var index:int = 0; index < len; index++)
				{
					item = getItem(column, index);
					
					if (item.y == 315 - item.index * 45) // SET RESPECTIVE BIT IN VECTOR TO 1, CONSIDER ONLY ITEMS WHICH ARE STATIC AND NOT DURING FREE FALL
					{
						jewelTypesGridVector[item.jewelType - 1][column] |= (1 << index); // SET BIT IN MATRIX OF COLUMNS FOR 1 JEWEL TYPE
						jewelTypesGridVector[item.jewelType - 1][8 + index] |= (1 << column); // SET BIT IN MATRIX OF ROWS FOR 1 JEWEL TYPE
					}
				}
			}
			
			if (aItemToSwap1 && aItemToSwap2)
			{
				// IF WE PASS TWO ITEMS AS ARGUMENTS THEIR BIT MATRIX MARKS WILL BE SWAPPED IN A RETURNED jewelTypesGridVecor
				// IT WILL BE REQUIRED TO QUICK CHECK IF THERE WOULD BE ANY WINS SHOWING UP IN AN ATTEMPT TO SWAP THE JEWELS
				
				// TO DO SO WE NEED TO SET THEIR RESPECIVE BITS TO ZERO
				//
				// aItemToSwap1 COLUMNS MATRIX
				jewelTypesGridVector[aItemToSwap1.jewelType - 1][aItemToSwap1.column] &= ~(1 << aItemToSwap1.index);
				// aItemToSwap1 ROWS MATRIX
				jewelTypesGridVector[aItemToSwap1.jewelType - 1][8 + aItemToSwap1.index] &= ~(1 << aItemToSwap1.column);
				// aItemToSwap2 COLUMNS MATRIX
				jewelTypesGridVector[aItemToSwap2.jewelType - 1][aItemToSwap2.column] &= ~(1 << aItemToSwap2.index);
				// aItemToSwap2 ROWS MATRIX
				jewelTypesGridVector[aItemToSwap2.jewelType - 1][8 + aItemToSwap2.index] &= ~(1 << aItemToSwap2.column);
				
				// SET RESPECIVE BITS TO 1 WHILE SWAPPING THE ITEMS IDENTITY: 
				// TYPE OF aItemToSwap1 GETS MAPPED AT CO-ORDS OF aItemToSwap2
				// AND TYPE OF aItemToSwap2 GETS MAPPED AT CO-ORDS OF aItemToSwap1
				//
				// aItemToSwap1 COLUMNS MATRIX
				jewelTypesGridVector[aItemToSwap1.jewelType - 1][aItemToSwap2.column] |= (1 << aItemToSwap2.index);
				// aItemToSwap1 ROWS MATRIX
				jewelTypesGridVector[aItemToSwap1.jewelType - 1][8 + aItemToSwap2.index] |= (1 << aItemToSwap2.column);
				// aItemToSwap2 COLUMNS MATRIX
				jewelTypesGridVector[aItemToSwap2.jewelType - 1][aItemToSwap1.column] |= (1 << aItemToSwap1.index);
				// aItemToSwap2 ROWS MATRIX
				jewelTypesGridVector[aItemToSwap2.jewelType - 1][8 + aItemToSwap1.index] |= (1 << aItemToSwap1.column);
			}
			
			return jewelTypesGridVector;
		}
		
		public function takeOutJewels(takeOutVector:Vector.<uint>):void
		{
			
			for (var column:int = 0; column < 8; column++)
			{
				///////////////////////////////////////////////////////////
				// CREATE LOOK UP TABLE OF INDEXES TO REMOVE IN EACH COLUMN
				var takeOutColumnLookup:Vector.<uint> = new Vector.<uint>
				{
					for (var index:int = 0; index < 8; index++)
					{
						if ((takeOutVector[column] & (1 << index)) != 0)
						{
							takeOutColumnLookup.push(index);
						}
					}
				}
				////////////////////////////////////////////////////////////
				//trace("[ModelMatrix.takeOutJewels] column " + column + " takeOutColumnLookup " + takeOutColumnLookup);
				processColumnUpdate(column, takeOutColumnLookup);
			}
			dispatch(new GameEvent(GameEvent.REFILL_BOARD_REQUEST));
		}
		
		protected function processColumnUpdate(column:uint, takeOutColumnLookup:Vector.<uint>):void
		{
			// TAKE OUT REQUESTED JEWELS DISPLAYERS OFF THE DISPLAY LISTS
			for (var i:int = 0; i < takeOutColumnLookup.length; i++)
			{
				// REMOVE DISPLAYER AFTER A QUICK EXPLOSION
				
				dispatch(new JewelViewTransitionEvent(JewelViewTransitionEvent.EXPLODE, itemsVector[column][takeOutColumnLookup[i]].displayer));
			}
			// REMOVE MODEL ITEMS FROM THE VECTOR
			itemsVector[column] = removeItemsFromVector(itemsVector[column], takeOutColumnLookup);
			// UPDATE STORED INDEX VALUES INSIDE ITEMS, THIS WILL CAUSE THEM TO DETECT 'GRAVITY' BY DIFFERENCE OF ALTITUDE TO INDEX AND FALL
			updateIndexValues(column);
		}
		
		protected function updateIndexValues(column:uint):void
		{
			var len:uint = itemsVector[column].length;
			
			for (var j:int = 0; j < len; j++)
			{
				itemsVector[column][j].index = j;
				itemsVector[column][j].column = column;
				itemsVector[column][j].name = "jewel_" + column + "_" + j
			}
		}
		
		protected function removeItemsFromVector(vector:Vector.<JewelItemVO>, indicesToRemove:Vector.<uint>):Vector.<JewelItemVO>
		{
			var newVector:Vector.<JewelItemVO> = vector;
			var index:uint;
			
			for (var i:int = 0; i < indicesToRemove.length; i++)
			{
				newVector.splice(indicesToRemove[i] - i, 1);
			}
			return newVector;
		}
		
		public function resetBoardVectors():void
		{
			_gridVector = new Vector.<Vector.<uint>>(5, true);
			
			for (var i:int = 0; i < 5; i++)
			{
				_gridVector[i] = new Vector.<uint>(8, true);
				
				for (var j:int = 0; j < 8; j++)
				{
					_gridVector[i][j] = 0;
				}
			}
			
			for (var column:int = 0; column < 8; column++)
			{
				_itemsVector[column] = new Vector.<JewelItemVO>;
			}
		}
		
		// GETTERS AND SETTERS
		
		public function getItem(column:int, index:int):JewelItemVO
		{
			return _itemsVector[column][index];
		}
		
		public function get itemsVector():Vector.<Vector.<JewelItemVO>>
		{
			return _itemsVector;
		}
		
		public function get gridVector():Vector.<Vector.<uint>>
		{
			return _gridVector;
		}
		
		public function set gridVector(value:Vector.<Vector.<uint>>):void
		{
			_gridVector = value;
		}
	}

}