package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import com.dziadur.as3test.midasMiner.view.buttons.EndGameButton;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * @author pawel dziadur
	 */
	
	public class EndGameCommand extends Command
	{
		[Inject]
		public var soundManger:SoundManager;
		
		[Inject]
		public var selectionModel:SelectionModel;
		
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		override public function execute():void
		{
			trace("[EndGameCommand.execute] the score in scoreResultsModel is " + scoreResultsModel.score);
			
			dispatch(new HighlightEvent(HighlightEvent.FADE_OUT));
			selectionModel.interactionAllowed = false;
			scoreResultsModel.gameOn = false;
			contextView.addChild(new EndGameButton(scoreResultsModel.score));
			soundManger.endGame();
		}
	}
}
