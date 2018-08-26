package
{
	import com.dziadur.as3test.midasMiner.AS3TestTaskContext;
	import com.dziadur.as3test.midasMiner.view.board.BoardMask;
	import com.dziadur.as3test.midasMiner.view.board.BoardView;
	import com.dziadur.as3test.midasMiner.view.board.ExplosionsContainer;
	import com.dziadur.as3test.midasMiner.view.board.Highlight;
	import com.dziadur.as3test.midasMiner.view.board.MarkWinGroupsContainer;
	import com.dziadur.as3test.midasMiner.view.board.ScoreSpritesContainer;
	import com.dziadur.as3test.midasMiner.view.buttons.StartGameButton;
	import com.dziadur.as3test.midasMiner.view.counters.ScoreCounterView;
	import com.dziadur.as3test.midasMiner.view.counters.TimeLeftCounterView;
	import com.dziadur.as3test.midasMiner.view.debug.StartGameButtonFixed;
	import com.dziadur.as3test.midasMiner.view.dynamiteFuse.DynamiteFuseView;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		
		private var forceInclude:Array = [Jewel_0, Jewel_1, Jewel_2, Jewel_3, Jewel_4, Jewel_5, BackGround];
		
		protected var context:AS3TestTaskContext;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			scaleX = scaleY = 1;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.context = new AS3TestTaskContext(this);
		}
		
		public function createChildren():void
		{
			// ADD BACKGROUND
			addChild(new BackGround());
			
			// ADD EXPLOSIONS CONTAINER
			var explosionsContainer:ExplosionsContainer = new ExplosionsContainer();
			explosionsContainer.x = 340;
			explosionsContainer.y = 118;
			addChild(explosionsContainer);
			
			var epxlosionsMask:BoardMask = new BoardMask();
			epxlosionsMask.x = 340 - 23;
			epxlosionsMask.y = 118 - 23;
			
			addChild(epxlosionsMask)
			explosionsContainer.mask = epxlosionsMask;
			
			// ADD HIGHLIGHT
			var highLight:Highlight = new Highlight();
			highLight.name = "highLight";
			addChild(highLight);
			
			var board:BoardView = new BoardView();
			board.x = 340;
			board.y = 118;
			addChild(board);
			
			// ADD BOARD MASK
			var boardMask:BoardMask = new BoardMask();
			boardMask.x = 340 - 23;
			boardMask.y = 118 - 23;
			
			addChild(boardMask);
			board.mask = boardMask;
			
			// ADD MARK WIN GROUPS IN DEBUG CONTAINER THIS IS ALSO USED FOR SHOWING CLUES TO USER
			var markWinGroupsInDebug:MarkWinGroupsContainer = new MarkWinGroupsContainer();
			markWinGroupsInDebug.x = board.x;
			markWinGroupsInDebug.y = board.y;
			markWinGroupsInDebug.name = "markWinGroupsInDebug";
			addChild(markWinGroupsInDebug);
			
			// ADD SCORE SPRITES CONTAINER
			var scoreSpritesContainer:ScoreSpritesContainer = new ScoreSpritesContainer();
			scoreSpritesContainer.x = board.x;
			scoreSpritesContainer.y = board.y;
			addChild(scoreSpritesContainer);
			
			// ADD TIME AND SCORE COUNTER VIEWS
			addChild(new TimeLeftCounterView());
			addChild(new ScoreCounterView);
			
			// ADD DYNAMITE FUSE VIEW
			addChild(new DynamiteFuseView());
			
		//	addChild(new (StartGameButtonFixed)); // MIGHT BE USED DURING DEBUG TO RETRIGGER START OF THE GAME
	
			// ADD START GAME BUTTON
			addChild(new StartGameButton());
		}
	}
}