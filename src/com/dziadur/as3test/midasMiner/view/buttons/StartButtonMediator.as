package com.dziadur.as3test.midasMiner.view.buttons
{

import com.dziadur.as3test.midasMiner.controller.GameEvent;
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;


public class StartButtonMediator extends Mediator
{

    [Inject]
    public var view:StartGameButton;

    override public function onRegister ():void
    {
        addViewListener(MouseEvent.MOUSE_DOWN, onClick);
    }

    protected function onClick(event:MouseEvent):void
    {
        dispatch(new GameEvent(GameEvent.START_GAME_CLICKED));
		view.fadeOut();
    }
}
}
