package com.dziadur.as3test.midasMiner.controller {
    import flash.events.Event;
 
    public class TimeLeftCounterEvent extends Event {
        public static const START:String = "start";
        public static const STOP:String = "stop";
        public static const TICK:String = "tick";
		
		public var timeLeft:int;
 
        public function TimeLeftCounterEvent(type:String, timeLeft:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.timeLeft = timeLeft;
        }
    }
}