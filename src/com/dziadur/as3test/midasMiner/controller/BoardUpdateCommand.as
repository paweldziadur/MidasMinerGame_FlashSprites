package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.ResultsHelper;
	import com.dziadur.as3test.midasMiner.model.ResultsObject;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.model.TimeLeftCounterModel;
	import com.dziadur.as3test.midasMiner.model.WinGroupObject;
	import com.dziadur.as3test.midasMiner.view.ClearMethodEnabledViewContainer;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class BoardUpdateCommand extends Command
	{
		[Inject]
		public var timeLeftCounterModel:TimeLeftCounterModel;
		
		[Inject]
		public var selectionModel:SelectionModel;
		
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var container:IBoardContainer
		
		[Inject]
		public var resultsHelper:ResultsHelper
		
		override public function execute():void
		{
			var snapshot:Vector.<Vector.<uint>> = container.getJewelTypesGridVector();
			
			var resultsObject:ResultsObject = resultsHelper.getResults(snapshot);
			
			//markWinGroups(resultsObject);
			timeLeftCounterModel.timeFromLastInteraction = 0;
			
			
			if (resultsObject.winGroupsVector.length > 0)
			{
				
				if (selectionModel.interactionCausedJewelRemoval == false)
				{
					scoreResultsModel.multiplier += 1;
				}
				else
				{
					scoreResultsModel.multiplier = 1;
				}
				
				container.takeOutJewels(resultsObject.takeOutVector);
				
				if (scoreResultsModel.gameOn) // WHEN ANY OF THE JEWELS FALL DOWN JUST AFTER THE TIME LIMIT REACHES ZERO THEY WON'T BE ADDED TO SCORE
				{
				processScoreRewards(resultsObject);
				}
			}
			
			// FINISH
			selectionModel.interactionCausedJewelRemoval = false;
			dispatch(new GameEvent(GameEvent.BOARD_UPDATE_COMPLETED));
		}
		
		private function processScoreRewards(resultsObject:ResultsObject):void
		{
			var winGroupCenre:Point = new Point();
			var winGroupObject:WinGroupObject;
			
			for (var i:int = 0; i < resultsObject.winGroupsVector.length; i++)
			{
				winGroupObject = resultsObject.winGroupsVector[i];
				
				for (var j:int = 0; j < winGroupObject.groups.length; j++)
				{
					if (winGroupObject.orientation == WinGroupObject.ORIENTATION_HORIZONTAL)
					{
						winGroupCenre = new Point(winGroupObject.centreVector[j], winGroupObject.columnOrRow)
					}
					else
					{
						winGroupCenre = new Point(winGroupObject.columnOrRow, winGroupObject.centreVector[j])
					}
					dispatch(new GameScoreRewardEvent(GameScoreRewardEvent.REWARD_WIN_GROUP, winGroupCenre, winGroupObject.groups[j].length));
				}
				
			}
		}
		
		private function markWinGroups(resultsObject:ResultsObject):void
		{
			var marksContainer:ClearMethodEnabledViewContainer;
			marksContainer = (contextView.getChildByName("markWinGroupsInDebug") as ClearMethodEnabledViewContainer);
			
			marksContainer.clear();
			
			var horHighlight:HighlightHorizontalWinGroupAsset;
			var verHighlight:HighlightVerticalWinGroupAsset;
			var biHighlight:HighlightBiDirectionalWinGroupAsset;
			var value:uint;
			
			for (var column:int = 0; column < 8; column++)
			{
				value = resultsObject.takeOutVector[column];
				trace(value.toString(2));
				
				for (var index:int = 0; index < 8; index++)
				{
					if ((value & (1 << index)) != 0)
					{
						horHighlight = new HighlightHorizontalWinGroupAsset();
						horHighlight.x = 45 * column;
						horHighlight.y = 315 - (45 * index);
						horHighlight.alpha = 0.5;
						marksContainer.addChild(horHighlight);
					}
				}
				
			}
		}
	
	}

}