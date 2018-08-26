package com.dziadur.as3test.midasMiner.model 
{
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class WinGroupObject extends Object
	{
		public static const ORIENTATION_HORIZONTAL:String = "orientation_horizontal";
		public static const ORIENTATION_VERTICAL:String = "orientation_vertical";
		
		public var value:uint;
		public var orientation:String;
		public var takeOutMask:uint = 0;
		public var centreVector:Vector.<Number>;
		public var columnOrRow:uint;
		
		// BECAUSE THE GRID IS 8X8 THERE CAN UP TO 2 WINGROUPS IN A SINGLE LINE. AS SUCH WE HAVE A VECTOR OF VECTOR OF UINTS, EACH UINT WILL REPRESENT AN INDEX OF ITEM OF WINGROUP.
		// AN INDEX WILL REFER A ROW IN CASE OF COLUMNS AND COLUMN IN CASE OF ROWS. THE ITEMS REFERED BY THE IDICIES WILL BE RECYCLED / REMOVED WHEN THE WINDGROP GOES OF THE BOARD
		// FROM THE LENGHT AND START INDEX OF WIN GROUPS WE CAN CALCULATE THE VISUAL CENTRE OF EACH WINGROUP, IT WILL BE USED TO ESTABLISH POSITIONS OF SCORE-REWARD RELATED SPRITE EFFECTS
		// BECAUSE THE VERTICAL AND HORIZONTAL WINGROUPS CAN INTERSECT AND THE 0-255 VALUE CAN ALSO HOLD BITS UNRELATED TO WINGROUP WE ALSO STORE A PRECALCULATED TAKE OUT MASK
		// THE TAKE OUT MASKS WILL BE CONSOLIDATED WITH BINARY OR AND BIT MATRIX ROTATION TO CALCULATE THE 8x8 TAKE OUT VECTOR MATRIX REPRESENTING ALL JEWELS TO BE TAKEN OFF THE BOARD
		// IN A SINGLE MOMENT OF TIME DURING THE BOARD UPDATE COMMAND RUN THROUGH
		
		public var groups:Vector.<Vector.<uint>>;
		
		public function WinGroupObject(aValue:uint, aOrientation:String=WinGroupObject.ORIENTATION_HORIZONTAL) 
		{
			value = aValue;
			groups = new Vector.<Vector.<uint>>;
			centreVector = new Vector.<Number>(2, true);
		}
		
		public function clone():WinGroupObject
		{
			var a:WinGroupObject = new WinGroupObject(value);
			a.groups = groups;
			a.takeOutMask = takeOutMask;
			a.centreVector = centreVector;
			a.columnOrRow = columnOrRow;
			return a;
		}
		
	}

}