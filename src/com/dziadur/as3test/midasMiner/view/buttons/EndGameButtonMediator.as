package com.dziadur.as3test.midasMiner.view.buttons
{
/**
 * @author Pawel Dziadur
 */
import com.dziadur.as3test.midasMiner.controller.GameEvent;
import flash.events.MouseEvent;
import org.robotlegs.mvcs.Mediator;


public class EndGameButtonMediator extends Mediator
{

    [Inject]
    public var view:EndGameButton;

    override public function onRegister ():void
    {
        addViewListener(MouseEvent.CLICK, onClick);
    }

    protected function onClick (event:MouseEvent):void
    {
        dispatch(new GameEvent(GameEvent.START_GAME_CLICKED));
		view.fadeOut();
    }
}
}
