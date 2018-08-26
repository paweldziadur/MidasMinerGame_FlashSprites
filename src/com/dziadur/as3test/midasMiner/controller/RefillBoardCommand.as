package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.JewelItemVO;
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.ContinuousProbablityDistributionJewelTypeGenerator;
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.IRandomNumberGenerator;
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.UniqueChunkDistributionJewelTypeGenerator;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
	import flash.utils.getTimer;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author
	 */
	public class RefillBoardCommand extends Command
	{
		[Inject]
		public var container:IBoardContainer;
		
		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var continuousProbablityDistributionJewelTypeGenerator:ContinuousProbablityDistributionJewelTypeGenerator;
		
		[Inject]
		public var uniqueChunkDistributionJewelTypeGenerator:UniqueChunkDistributionJewelTypeGenerator;
		
		protected var _gravityEnabled:Boolean = true;
		protected var _startFallAltitudeOffset:int = 0;
		protected var _hitTheGroundSoundGateTime:int = 100;
		
		override public function execute():void
		{
			var randomNumberGenrator:IRandomNumberGenerator = getRandomNumberGenerator();
			var quantity:uint;
			var jewel:JewelView;
			
			soundManager.hitTheGroundSoundGateTime = _hitTheGroundSoundGateTime; // EACH CLASS IMPLEMENTING THE REFILL BOARD CAN USE IT'S OWN VALUE FOR THE HIT THE GROUND SOUND GATING
			
			for (var column:int = 0; column < 8; column++)
			{
				quantity = 8 - container.itemsVector[column].length;
				
				for (var i:int = 0; i < quantity; i++)
				{
					jewel = new JewelView(randomNumberGenrator.randomValue)
					var item:JewelItemVO = new JewelItemVO(jewel);
					
					item.y = (i * 45) * -1 - 45 + _startFallAltitudeOffset * 45; // SET THE INITIAL HEIGHT FROM WHICH THE JEWELS SHOULD FALL DOWN AS ROW ABOVE THE EDGE OF MASK AND HIGHER
					item.gravityEnabled = _gravityEnabled;
					container.add(column, item);
				}
			}
		}
		
		public function getRandomNumberGenerator():IRandomNumberGenerator
		{
			return uniqueChunkDistributionJewelTypeGenerator; // WE ARE IMPLEMENTING A CHOICE OVER RANDOM NUMBER GENERATORS HERE, THIS WILL INFLUENCE  THE GAMEPLAY DIFFICULTY
           //  return continuousProbablityDistributionJewelTypeGenerator;
		}
	
	}

}