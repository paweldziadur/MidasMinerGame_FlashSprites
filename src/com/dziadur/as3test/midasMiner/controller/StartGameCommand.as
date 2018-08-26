/**
 * @author Cotton Hou
 */
package com.dziadur.as3test.midasMiner.controller
{
	
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.view.ClearMethodEnabledViewContainer;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	
	public class StartGameCommand extends Command
	{
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var selectionModel:SelectionModel;
		
		[Inject]
		public var container:IBoardContainer;
		
		override public function execute():void
		{
			trace("[StartGameCommand.execute]");	
			
			clearTheBoard();
			scoreResultsModel.scoreReset();
			scoreResultsModel.gameOn = true;
			
			selectionModel.firstClickComplete = false;
			selectionModel.interactionAllowed = true;
			
			dispatch(new GameEvent(GameEvent.REFILL_BOARD_AT_START_GAME_REQUEST));
			dispatch(new TimeLeftCounterEvent(TimeLeftCounterEvent.START));
		}
		
		protected function clearTheBoard():void
		{
			// CLEAR THE MODEL OF THE GAME BOARD
			container.resetBoardVectors();
			
			// CLEAR THE VIEW OF THE GAME BOARD
			dispatch(new GameEvent(GameEvent.CLEAR_THE_BOARD_REQUEST));
		}
	}
}
