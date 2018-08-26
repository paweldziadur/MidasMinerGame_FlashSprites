package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author
	 */
	public class HitTheGroundCommand extends Command
	{
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var container:IBoardContainer;
		
		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var event:GameItemEvent;
		
		override public function execute():void
		{
			checkAllFalls();
			soundManager.hitTheGround(scoreResultsModel.multiplier);
		}
		
		private function checkAllFalls():void
		{
			var fallCount:uint = 0;
			
			for (var column:int = 0; column < 8; column++)
			{
				for (var i:int = container.itemsVector[column].length - 1; i >= 0; i--)
				{
					fallCount += container.getItem(column, i).fall;
				}
			}
			
			if (fallCount == 0)
			{
				dispatch(new GameEvent(GameEvent.BOARD_UPDATE_REQUEST));
			}
		}
	
	}

}