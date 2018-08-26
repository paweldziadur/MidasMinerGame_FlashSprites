package com.dziadur.as3test.midasMiner.model
{
	import flash.display.NativeMenuItem;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ResultsHelper extends Actor
	{
		protected var _resultsVector:Vector.<WinGroupObject>;
		
		public function ResultsHelper()
		{
			_resultsVector = new Vector.<WinGroupObject>(256, true);
			computeResultsVector();
		}
		
		protected function computeResultsVector():Vector.<WinGroupObject>
		{
			for (var i:int = 0; i < 256; i++)
			{
				var winGroupObject:WinGroupObject = getWinGroupsPerLine(i);
				
				if (winGroupObject.groups.length > 0)
				{
					_resultsVector[i] = winGroupObject.clone();
				}
			}
			return _resultsVector;
		}
		
		protected function getBinaryValueAsStringPaddedWithZeros(value:uint):String
		{
			const digitsQuantity:uint = 8;
			var string:String = value.toString(2);
			return String("0000000000000000000000000000000000000000000000000000000000000000").slice(0, digitsQuantity - string.length).concat(string);
		}
		
		protected function getWinGroupsPerLine(value:uint):WinGroupObject
		{
			var pattern:RegExp = /(\w)\1*/gi;
			var result:Array = new Array();
			
			var winGroupObject:WinGroupObject = new WinGroupObject(value);
			var takeOutMask:uint = 0;
			var groupIndex:uint;
			var gridLineAsString:String = getBinaryValueAsStringPaddedWithZeros(value);
			
			var from:uint;
			var to:uint;
			var centre:Number;
			
			result = pattern.exec(gridLineAsString);
			
			while (result != null)
			{
				//trace(result.index, "\t", pattern.lastIndex, "\t", result[0]);
				if (result[0].length > 2 && result[1] != "0")
				{
					groupIndex = winGroupObject.groups.push(new Vector.<uint>) - 1;
					from = 7 - result.index;
					to = 8 - pattern.lastIndex;
					
					for (var i:int = from; i >= to; i--)
					{
						winGroupObject.groups[groupIndex].push(i);
						takeOutMask |= 1 << i
					}
					winGroupObject.centreVector[groupIndex] = winGroupObject.groups[groupIndex].length * 0.5 + to - 0.5;
				}
				result = pattern.exec(gridLineAsString);
			}
			winGroupObject.takeOutMask = takeOutMask;
			return winGroupObject;
		}
		
		public function getQuantityOfWinGroupsAfterReplace(item1:JewelItemVO, item2:JewelItemVO):int
		{
			return 0;
		}
		
		public function getResults(jewelTypesGridVector:Vector.<Vector.<uint>>):ResultsObject
		{
			var resultsObject:ResultsObject = new ResultsObject();
			
			var value:int;
			
			var winGroupObject:WinGroupObject;
			
			var horizontalTakeOutVector:Vector.<uint> = getFixedLenghtVectorOfUint(8);
			
			// ITERATE THROGH JEWEL TYPES
			for (var type:int = 0; type < 5; type++)
			{
				// ITERATE THROUGH COLUMNS SCANNING FOR WINNING VALUES
				for (var column:int = 0; column < 8; column++)
				{
					value = jewelTypesGridVector[type][column];
					
					if (_resultsVector[value] != null)
					{
						winGroupObject = _resultsVector[value].clone();
						winGroupObject.columnOrRow = column;
						winGroupObject.orientation = WinGroupObject.ORIENTATION_VERTICAL;
						resultsObject.takeOutVector[column] |= winGroupObject.takeOutMask;
						resultsObject.winGroupsVector.push(winGroupObject);
					}
				}
				
				// ITERATE THROUGH ROWS (INDEXES IN _itemsVector COLUMNS) SCANNING FOR WINNING VALUES
				for (var index:int = 0; index < 8; index++)
				{
					value = jewelTypesGridVector[type][8 + index]
					
					if (_resultsVector[value] != null)
					{
						winGroupObject = _resultsVector[value].clone();
						winGroupObject.columnOrRow = index;
						winGroupObject.orientation = WinGroupObject.ORIENTATION_HORIZONTAL;
						horizontalTakeOutVector[index] |= winGroupObject.takeOutMask;
						resultsObject.winGroupsVector.push(winGroupObject);
					}
				}
			}
			
			// ROTATE THE BIT MATRIX OF HORIZONTAL TAKE OUT VECTOR CLOCKWISE BY 90 DEGREES
			horizontalTakeOutVector = rotateBitMatrix(horizontalTakeOutVector);
			
			// CONSOLIDATE IT WITH COLUMN-WISE TAKE OUT VECTOR MATRIX ALREADY IN PLACE
			for (var i:int = 0; i < 8; i++) 
			{
				resultsObject.takeOutVector[i] |= horizontalTakeOutVector[i];
			}
			
			return resultsObject;
		}
		
		private function getFixedLenghtVectorOfUint(length:uint):Vector.<uint>
		{
			var vector:Vector.<uint> = new Vector.<uint>(length, true);
			for (var i:int = 0; i < length; i++)
			{
				vector[i] = 0;
			}
			return vector;
		}
		
		private function rotateBitMatrix(matrixOf8x8Bits:Vector.<uint>):Vector.<uint>
		{
			var rotatedMatrix:Vector.<uint> = new Vector.<uint>(8, true);
			
			rotatedMatrix[0] = rotatedMatrix[1] = rotatedMatrix[2] = rotatedMatrix[3] = rotatedMatrix[4] = rotatedMatrix[5] = rotatedMatrix[6] = rotatedMatrix[7] = 0;
			
			for (var i:int = 0; i < 8; i++)
			{
				for (var j:int = 0; j < 8; j++)
				{
					rotatedMatrix[i] |= ((matrixOf8x8Bits[j] & (1 << i)) >> i) << j;
				}
			}
			return rotatedMatrix;
		}
		
		public function get resultsVector():Vector.<WinGroupObject> 
		{
			return _resultsVector;
		}
	
	}

}