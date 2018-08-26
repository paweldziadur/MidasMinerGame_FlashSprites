package com.dziadur.as3test.midasMiner.controller
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pawel dziadur
	 */
	public class GameEvent extends Event
	{
		
		public static const START_GAME_CLICKED:String = "start_game_clicked";
		public static const SCORE_RESET:String = "score_reset";
		public static const END_GAME:String = "end_game";
		public static const CLEAR_THE_BOARD_REQUEST:String ="clear_the_board_request";
		public static const BOARD_UPDATE_REQUEST:String = "board_update_request";
		public static const BOARD_UPDATE_COMPLETED:String = "board_update_completed";
		public static const REFILL_BOARD_REQUEST:String = "refill_board_request";
		public static const REFILL_BOARD_AT_START_GAME_REQUEST:String = "refill_board_at_start_game_request";
		public static const SHOW_CLUE_REQUEST:String = "show_clue_request";
		
		public function GameEvent(type:String)
		{
			super(type);
		}

		override public function clone():Event
		{
			return new GameEvent(type);
		}
	
	}

}