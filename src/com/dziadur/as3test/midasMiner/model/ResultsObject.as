package com.dziadur.as3test.midasMiner.model 
{
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ResultsObject 
	{
		public var takeOutVector:Vector.<uint> = new Vector.<uint>(8, true);
		
		public var winGroupsVector:Vector.<WinGroupObject> = new Vector.<WinGroupObject>;
		
		public function ResultsObject() 
		{
			takeOutVector[0] = takeOutVector[1] = takeOutVector[2] = takeOutVector[3] = takeOutVector[4] = takeOutVector[5] = takeOutVector[6] = takeOutVector[7] = 0;
		}
		
	}

}