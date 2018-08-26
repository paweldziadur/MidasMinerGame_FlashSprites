package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.IRandomNumberGenerator;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class RefillBoardAtStartGameCommand extends RefillBoardCommand
	{
		override public function execute():void
		{
			_gravityEnabled = false; // WE ARE HOLDING OFF WITH GRAVITY AS THE JEWELS WILL DROP SEQENTIALLY IN THE ENTRY ANIMATION
			_startFallAltitudeOffset = -4; // THE JEWELS WILL FALL FROM 4 ROWS ABOVE THE MASK, AS THIS WILL MAKE THEM COME IN INTO MASK MORE DYNAMICALLY
			_hitTheGroundSoundGateTime = 5; // THE VALUE OF 5 WILL CAUSE A MOST OF THE HIT THE GROUND SOUNDS BEING TRIGGERED DURING ENTRY ANIMATION, BUT NOT ALL (DEPENDING ON ENTRY ANIMATION VALUES)
			super.execute();
			entryAnimation();
		}
		
		public function entryAnimation():void
		{
			for (var column:int = 0; column < 8; column++)
			{
				for (var index:int = 0; index < 8; index++)
				{
					TweenMax.to(this, 0, {onComplete: drop, onCompleteParams: [column, index], delay: index * 0.0625 + column * 0.125 + Math.random() * 0.0012 - 0.00006});
				}
			}
		}
		
		private function drop(column:uint, index:uint):void
		{
			if (container.getItem(column, index))
			{
				container.getItem(column, index).gravityEnabled = true;
			}
		}
		
		override public function getRandomNumberGenerator():IRandomNumberGenerator
		{
			return uniqueChunkDistributionJewelTypeGenerator;
		}
	
	}

}