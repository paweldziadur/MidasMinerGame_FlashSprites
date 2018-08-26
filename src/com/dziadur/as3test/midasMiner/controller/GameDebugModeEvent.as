/**
 * @author Cotton Hou
 */
package com.dziadur.as3test.midasMiner.controller
{

import com.dziadur.as3test.midasMiner.model.JewelItemVO;
import com.dziadur.as3test.midasMiner.view.jewels.JewelView;
import flash.events.Event;
import flash.geom.Point;


public class GameDebugModeEvent extends Event
{
	public static const MARK_WIN_GROUPS_IN_DEBUG:String = "mark_win_groups_in_debug";
	public static const CLEAR_MARKED_WIN_GROUPS_IN_DEBUG:String = "jewel_debug_panel_update";
	
	
	public var xx:int;
	public var yy:int;
	
	public var point1:Point = new Point();
	public var point2:Point = new Point();
	
	public var score:int;
	
	public var displayer:JewelView;

    public function GameDebugModeEvent(type:String, itemVO:JewelItemVO = null)
    {
        super(type);

        _itemVO = itemVO;
    }

    private var _itemVO:JewelItemVO;

    public function get itemVO ():JewelItemVO
    {
        return _itemVO;
    }

    override public function clone():Event
    {
        return new GameDebugModeEvent(type, itemVO);
    }

}
}
