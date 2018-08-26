package com.dziadur.as3test.midasMiner
{
	import com.dziadur.as3test.midasMiner.controller.BoardUpdateCommand;
	import com.dziadur.as3test.midasMiner.controller.EndGameCommand;
	import com.dziadur.as3test.midasMiner.controller.GameDebugModeEvent;
	import com.dziadur.as3test.midasMiner.controller.GameEvent;
	import com.dziadur.as3test.midasMiner.controller.GameItemEvent;
	import com.dziadur.as3test.midasMiner.controller.GameLocationEvent;
	import com.dziadur.as3test.midasMiner.controller.GameScoreRewardEvent;
	import com.dziadur.as3test.midasMiner.controller.HitTheGroundCommand;
	import com.dziadur.as3test.midasMiner.controller.JewelUserInteractionCommand;
	import com.dziadur.as3test.midasMiner.controller.JewelUserInteractionEvent;
	import com.dziadur.as3test.midasMiner.controller.JewelViewTransitionEvent;
	import com.dziadur.as3test.midasMiner.controller.RefillBoardAtStartGameCommand;
	import com.dziadur.as3test.midasMiner.controller.RefillBoardCommand;
	import com.dziadur.as3test.midasMiner.controller.ShowClueToUserCommand;
	import com.dziadur.as3test.midasMiner.controller.SwapJewelsAttemptCommand;
	import com.dziadur.as3test.midasMiner.controller.StartGameCommand;
	import com.dziadur.as3test.midasMiner.controller.StartupCommand;
	import com.dziadur.as3test.midasMiner.controller.TimeLeftCounterEvent;
	import com.dziadur.as3test.midasMiner.controller.TimeLeftCounterStartCommand;
	import com.dziadur.as3test.midasMiner.model.GameConfig;
	import com.dziadur.as3test.midasMiner.model.IBoardContainer;
	import com.dziadur.as3test.midasMiner.model.BoardContainer;
	import com.dziadur.as3test.midasMiner.model.JewelItemVO;
	import com.dziadur.as3test.midasMiner.model.JewelModelHelper;
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.ContinuousProbablityDistributionJewelTypeGenerator;
	import com.dziadur.as3test.midasMiner.model.randomNumberGenerators.UniqueChunkDistributionJewelTypeGenerator;
	import com.dziadur.as3test.midasMiner.model.ResultsHelper;
	import com.dziadur.as3test.midasMiner.model.ScoreResultsModel;
	import com.dziadur.as3test.midasMiner.model.SelectionModel;
	import com.dziadur.as3test.midasMiner.model.SoundManager;
	import com.dziadur.as3test.midasMiner.model.TimeLeftCounterModel;
	import com.dziadur.as3test.midasMiner.view.ApplicationMediator;
	import com.dziadur.as3test.midasMiner.view.board.BoardMediator;
	import com.dziadur.as3test.midasMiner.view.board.BoardView;
	import com.dziadur.as3test.midasMiner.view.board.ExplosionsContainer;
	import com.dziadur.as3test.midasMiner.view.board.ExplosionsContainerMediator;
	import com.dziadur.as3test.midasMiner.view.board.Highlight;
	import com.dziadur.as3test.midasMiner.view.board.HighlightMediator;
	import com.dziadur.as3test.midasMiner.view.board.MarkWinGroupsContainer;
	import com.dziadur.as3test.midasMiner.view.board.MarkWinGroupsContainerMediator;
	import com.dziadur.as3test.midasMiner.view.board.ScoreSpritesContainer;
	import com.dziadur.as3test.midasMiner.view.board.ScoreSpritesContainerMediator;
	import com.dziadur.as3test.midasMiner.view.buttons.EndGameButton;
	import com.dziadur.as3test.midasMiner.view.buttons.EndGameButtonMediator;
	import com.dziadur.as3test.midasMiner.view.buttons.StartButtonMediator;
	import com.dziadur.as3test.midasMiner.view.buttons.StartGameButton;
	import com.dziadur.as3test.midasMiner.view.counters.ScoreCounterMediator;
	import com.dziadur.as3test.midasMiner.view.counters.ScoreCounterView;
	import com.dziadur.as3test.midasMiner.view.counters.TimeLeftCounterMediator;
	import com.dziadur.as3test.midasMiner.view.counters.TimeLeftCounterView;
	import com.dziadur.as3test.midasMiner.view.debug.StartGameButtonFixed;
	import com.dziadur.as3test.midasMiner.view.debug.StartGameButtonFixedMediator;
	import com.dziadur.as3test.midasMiner.view.dynamiteFuse.DynamiteFuseMediator;
	import com.dziadur.as3test.midasMiner.view.dynamiteFuse.DynamiteFuseView;
	import com.dziadur.as3test.midasMiner.view.jewels.JewelMediator;
	import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 *
	 * @author pawel dziadur
	 */
	public class AS3TestTaskContext extends Context
	{
		
		public function AS3TestTaskContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			// COMMAND MAP
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent);
			
			commandMap.mapEvent(GameEvent.START_GAME_CLICKED, StartGameCommand, GameEvent);
			commandMap.mapEvent(GameEvent.END_GAME, EndGameCommand, GameEvent);
			commandMap.mapEvent(GameEvent.BOARD_UPDATE_REQUEST, BoardUpdateCommand, GameEvent);
			commandMap.mapEvent(GameEvent.REFILL_BOARD_REQUEST, RefillBoardCommand, GameEvent);
			commandMap.mapEvent(GameEvent.REFILL_BOARD_AT_START_GAME_REQUEST, RefillBoardAtStartGameCommand, GameEvent);
			commandMap.mapEvent(GameEvent.SHOW_CLUE_REQUEST, ShowClueToUserCommand, GameEvent);
			
			commandMap.mapEvent(GameLocationEvent.SWAP_JEWELS_ATTEMPT, SwapJewelsAttemptCommand, GameLocationEvent);
			
			commandMap.mapEvent(JewelUserInteractionEvent.MOUSE_DOWN, JewelUserInteractionCommand, JewelUserInteractionEvent);
			commandMap.mapEvent(JewelUserInteractionEvent.MOUSE_OVER, JewelUserInteractionCommand, JewelUserInteractionEvent);
			commandMap.mapEvent(JewelUserInteractionEvent.MOUSE_UP, JewelUserInteractionCommand, JewelUserInteractionEvent);
			
			commandMap.mapEvent(TimeLeftCounterEvent.START, TimeLeftCounterStartCommand, TimeLeftCounterEvent);
			commandMap.mapEvent(GameItemEvent.HIT_THE_GROUND, HitTheGroundCommand,GameItemEvent);
			
			
			// SINGLETONS
			injector.mapSingletonOf(IBoardContainer, BoardContainer);
			injector.mapSingleton(ContinuousProbablityDistributionJewelTypeGenerator);
			injector.mapSingleton(UniqueChunkDistributionJewelTypeGenerator);
			injector.mapSingleton(SoundManager);
			injector.mapSingleton(JewelModelHelper);
			injector.mapSingleton(TimeLeftCounterModel);
			injector.mapSingleton(SelectionModel);
			injector.mapSingleton(ScoreResultsModel);
			injector.mapSingleton(ResultsHelper);
			
			// MEDIATOR MAP
			mediatorMap.mapView(Main, ApplicationMediator);
			mediatorMap.mapView(ExplosionsContainer, ExplosionsContainerMediator);
			mediatorMap.mapView(Highlight, HighlightMediator);
			mediatorMap.mapView(BoardView, BoardMediator);
			mediatorMap.mapView(ScoreSpritesContainer, ScoreSpritesContainerMediator);
			mediatorMap.mapView(MarkWinGroupsContainer, MarkWinGroupsContainerMediator);
			mediatorMap.mapView(JewelView, JewelMediator);
			mediatorMap.mapView(StartGameButton, StartButtonMediator);
			mediatorMap.mapView(EndGameButton, EndGameButtonMediator);
			mediatorMap.mapView(TimeLeftCounterView, TimeLeftCounterMediator);
			mediatorMap.mapView(ScoreCounterView, ScoreCounterMediator);
			mediatorMap.mapView(DynamiteFuseView, DynamiteFuseMediator);
			
			// DEBUG VIEWS 
			mediatorMap.mapView(StartGameButtonFixed, StartGameButtonFixedMediator);
			
			// STARTUP
			super.startup();
		}
	
	}

}