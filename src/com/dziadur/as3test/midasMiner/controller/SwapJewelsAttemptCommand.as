package com.dziadur.as3test.midasMiner.controller
{
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.JewelItemVO;
	import com.dziadur.as3test.midasMiner.model.ResultsHelper;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import com.dziadur.as3test.midasMiner.model.TimeLeftCounterModel;
	import com.dziadur.as3test.midasMiner.view.ClearMethodEnabledViewContainer;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author
	 */
	public class SwapJewelsAttemptCommand extends Command
	{

		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var scoreResultsModel:ScoreResultsModel;
		
		[Inject]
		public var selectionModel:SelectionModel;
		
		[Inject]
		public var container:IBoardContainer;
		
		[Inject]
		public var resultsHelper:ResultsHelper
		
		[Inject]
		public var event:GameLocationEvent;
		
		[Inject]
		public var timeLeftCounterModel:TimeLeftCounterModel;
		
		
		override public function execute():void
		{
			// BLOCK THE USER INTERACTION FOR THE TIME  BEING OF SWAPPING ANIMATION
			selectionModel.interactionAllowed = false;
			
			// RESET THE TIME FROM LAST INTERACTION BACK TO 0 (THIS VALUE IS RESPONSIBLE FOR TRIGGERING SHOWING THE CLUES TO USER
			timeLeftCounterModel.timeFromLastInteraction = 0;
			
			// CLEAR THE CLUE MARKS CONTAINER
			var marksContainer:ClearMethodEnabledViewContainer;
			marksContainer = (contextView.getChildByName("markWinGroupsInDebug") as ClearMethodEnabledViewContainer);
			marksContainer.clear();
			
			
			// PLAY SOUND
			soundManager.swapJewels();
			
			var item1:JewelItemVO = container.getItem(event.point1.x, 7 - event.point1.y);
			var item2:JewelItemVO = container.getItem(event.point2.x, 7 - event.point2.y);
			
			item1.gravityEnabled = false;
			item2.gravityEnabled = false;
			
			// SET SCORE REWARDS MULTIPLIER BACK TO 1 AS ALWAYS AFTER USER'S ATTEMPT TO SWAP JEWELS
			selectionModel.interactionCausedJewelRemoval = true;
			scoreResultsModel.multiplier = 1;
			
			if (resultsHelper.getResults(container.getJewelTypesGridVector(item1,item2)).winGroupsVector.length>0)
			{
				// WINNING SITUATION
				TweenMax.to(item1, 0.175, {x: event.point2.x * 45, y: event.point2.y * 45});
				TweenMax.to(item2, 0.175, {x: event.point1.x * 45, y: event.point1.y * 45, onComplete: function():void
					{
						container.swapJewels(item1, item2);
						// UNLIOCK THE USER INTERACTION 
						selectionModel.interactionAllowed = true;
					}});
			}
			else
			{
				// SWAP ATTEMPT HAS NOT PRODUCED ANY WINNING GROUPS OF JEWELS
				TweenMax.to(item1, 0.25, {x: event.point2.x * 45, y: event.point2.y * 45, repeat: 1, yoyo: true});
				TweenMax.to(item2, 0.25, {x: event.point1.x * 45, y: event.point1.y * 45, repeat: 1, yoyo: true, onComplete: function():void
					{
						item1.gravityEnabled = true;
						item2.gravityEnabled = true;
						selectionModel.interactionAllowed = true;
					}});
			}
		}
		
		
	
	}

}