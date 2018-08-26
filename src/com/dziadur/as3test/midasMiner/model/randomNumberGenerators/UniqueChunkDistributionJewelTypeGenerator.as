package com.dziadur.as3test.midasMiner.model.randomNumberGenerators 
{
	import org.robotlegs.mvcs.Actor;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class UniqueChunkDistributionJewelTypeGenerator extends Actor implements IRandomNumberGenerator
	{
		private var _previousRandomJewelTypeIndex:int = 0;
		private var _previousRandomJewelTypeVector:Vector.<uint>;
		
		public function UniqueChunkDistributionJewelTypeGenerator() 
		{
			_previousRandomJewelTypeVector = new Vector.<uint>(4096, true);
		}
		
		public function get randomValue():uint
		{
			var n:uint;

			n = Math.floor(Math.random() * 5 + 1);
			
			if (_previousRandomJewelTypeIndex > 0)
			{
				while (n == _previousRandomJewelTypeVector[_previousRandomJewelTypeIndex - 1])
				{
					n = Math.floor(Math.random() * 5 + 1);
				}
			}
			
			if (_previousRandomJewelTypeIndex > 7)
			{
				while (n == _previousRandomJewelTypeVector[_previousRandomJewelTypeIndex - 8])
				{
					n = Math.floor(Math.random() * 5 + 1);
				}
			}
			_previousRandomJewelTypeVector[_previousRandomJewelTypeIndex] = n;
			_previousRandomJewelTypeIndex = (_previousRandomJewelTypeIndex + 1) % 4096;
			return n;
		}
		
	}

}