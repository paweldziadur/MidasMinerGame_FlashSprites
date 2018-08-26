package com.dziadur.as3test.midasMiner.controller
{
	import adobe.utils.ProductManager;
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.JewelItemVO;
	import com.dziadur.as3test.midasMiner.model.ResultsHelper;
	import com.dziadur.as3test.midasMiner.model.ResultsObject;
	import com.dziadur.as3test.midasMiner.model.WinGroupObject;
	import com.dziadur.as3test.midasMiner.view.ClearMethodEnabledViewContainer;
	import com.dziadur.as3test.midasMiner.view.ClueAsset;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author
	 */
	public class ShowClueToUserCommand extends Command
	{
		[Inject]
		public var resultsHelper:ResultsHelper;
		
		[Inject]
		public var container:IBoardContainer
		
		override public function execute():void
		{
			var suggestionArray:Array = new Array();
			suggestionArray = scanTheBoard();
			
			if (suggestionArray.length>1)
			{
				dispatch(new GameItemEvent(GameItemEvent.INDICATE_AS_MOVE_SUGGESTION, suggestionArray[0]));
				dispatch(new GameItemEvent(GameItemEvent.INDICATE_AS_MOVE_SUGGESTION, suggestionArray[1]));
			}
			else
			{
				trace("[ShowClueToUserCommand.execute] NO CHANCE TO PRODUCE A WINNING MOVE IN CURRENT SITUATION!");
			}
		}
		
		private function scanTheBoard():Array
		{
			var point1:Point = new Point();
			var point2:Point = new Point();
			var suggestionArray:Array = new Array();
			var item1:JewelItemVO;
			var item2:JewelItemVO;
			
			var columnRandomOffset:int = Math.floor(Math.random() * 8); // WE WILL START SCANNIG THE BOARD FROM A RANDOM PLACE, SO WE DON'T GET CLUE RESULTS ALWAYS FROM THE SAME CORNER
			var indexRandomOffset:int = Math.floor(Math.random() * 8);
			
			for (var i:int = 0; i < 7; i++)
			{
				for (var j:int = 0; j < 7; j++)
				{
					point1.x = (i + columnRandomOffset) % 8;
					point1.y = point2.y = (j + indexRandomOffset) % 8;
					point2.x = (i + columnRandomOffset + 1) % 8;
					
					// TEST HORIZONTAL MOVE
					if (Point.distance(point1, point2) == 1 && container.getItem(point1.x, point1.y) && container.getItem(point2.x, point2.y))
					{
						item1 = container.getItem(point1.x, point1.y)
						item2 = container.getItem(point2.x, point2.y);
						
						if (resultsHelper.getResults(container.getJewelTypesGridVector(item1, item2)).winGroupsVector.length > 0)
						{
							suggestionArray.push(item1);
							suggestionArray.push(item2);
							return suggestionArray;
						}
					}
					
					// TEST VERTICAL MOVE
					point1.x = point2.x = (i + columnRandomOffset) % 8;
					point1.y = (j + indexRandomOffset) % 8;
					point2.y = (j + indexRandomOffset + 1) % 8;
					
					if (Point.distance(point1, point2) == 1 && container.getItem(point1.x, point1.y) && container.getItem(point2.x, point2.y))
					{
						item1 = container.getItem(point1.x, point1.y)
						item2 = container.getItem(point2.x, point2.y);
						
						if (resultsHelper.getResults(container.getJewelTypesGridVector(item1, item2)).winGroupsVector.length > 0)
						{
							suggestionArray.push(item1);
							suggestionArray.push(item2);
							return suggestionArray;
						}
					}
					
				}
			}
			return suggestionArray;
		}
	}

}