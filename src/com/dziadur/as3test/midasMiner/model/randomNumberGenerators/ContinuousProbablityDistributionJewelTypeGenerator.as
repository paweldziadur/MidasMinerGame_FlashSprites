package com.dziadur.as3test.midasMiner.model.randomNumberGenerators 
{
	import org.robotlegs.mvcs.Actor;
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class ContinuousProbablityDistributionJewelTypeGenerator extends Actor implements IRandomNumberGenerator
	{
		
		public function get randomValue():uint
		{
			return Math.floor(Math.random() * 5 + 1);
		}
	
		
	}

}