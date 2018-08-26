package com.dziadur.as3test.midasMiner.view.dynamiteFuse
{
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import thanhtran.utils.EnterFrameManager;
	
	/**
	 * ...
	 * @author
	 */
	public class DynamiteFuseView extends Sprite
	{
		
		protected var PZ:Object = new Object;
		///// ESSENTIAL PROJECT VARIABLES
		protected var one_squig_ac:Number = 10000; // ONE SQUIG SPACE IN A/C POINTS ARRAY
		protected var one_squig_pos:Number = 10000; // ONE SQUIG SPACE IN POS POINTS ARRAY
		protected var squig_number:Number = 6; // NUMBER OF SQUIGS
		protected var curves_per_squig:Number = 5; // CURVES PER SQUIG
		protected var straight_curves:Number = 5; // STRAIGHT CURVES PER SQUIG
		protected var curve_res:Number = 200; // 1 CURVE RESOLUTION IN POS ARRAY (
		protected var straight_line_res:Number = curve_res * 5;
		protected var banner_width:uint = 960;
		protected var g_shift_X:Number = 0;
		protected var g_shift_Y:Number = 0;
		
		protected var tframes:Number = (curve_res - 1) * (curves_per_squig + straight_curves);
		protected var frcount:Number = 0;
		protected var P:Object = new Object();
		protected var A1:Object = new Object();
		protected var C1:Object = new Object();
		protected var C2:Object = new Object();
		protected var A2:Object = new Object();
		// DECLARE ARRAYS //////////////////////////////////
		////////////////////////////////////////////////////
		// CURVE ANCHOR AND CONTROL POINTS ARRAYS: X AND Y POSITIONS
		protected var PX:Array = new Array(squig_number * one_squig_ac);
		protected var PY:Array = new Array(squig_number * one_squig_ac);
		// INTERSECTION VALUE ARRAY, THERE ARE 4 INTERSECTION DEPENDABLE CURVE ANCHORS IN EACH SQUIG
		protected var INTER:Array = new Array(squig_number * one_squig_ac);
		// SQUIG PATHS ARRAYS: X AND Y POSITIONS
		protected var posX:Array = new Array(squig_number * one_squig_pos);
		protected var posY:Array = new Array(squig_number * one_squig_pos);
		
		////////////////////////////////////////////////////////////
		// NAKED WIRE COLOUR
		protected var naked_wire_colour:Number = 0xEAEAEA;
		
		protected var _initialTime:int;
		protected var _currentTime:int;
		protected var _distance:int = 650;
		protected var _timeLimitMs:int;
		
		////DECLARE NAKED WIRE PERCENTAGES ARRAYS//////////
		
		public function DynamiteFuseView()
		{
			this.visible = false;
			mouseChildren = mouseEnabled = false;
			addAsset();
			initBezierShape();
			intiBezier();
		}
		
		public function start(timeLimit:int):void
		{
			_timeLimitMs = timeLimit * 1000;
			trace("[dynamiteFuseView.start]");
			_initialTime = getTimer();
			EnterFrameManager.instance.enterFrame.add(enterFrameHandler);
			this.visible = true;
		}
		
		public function stop():void
		{
			this.visible = false;
		}
		
		protected function addAsset():void
		{
			addChild(new DynamiteFuseSprite());
		}
		
		protected function enterFrameHandler(e:Event = null):void
		{
			_currentTime = getTimer() - _initialTime;
			var currentIndex:int =  640- int(640* (_currentTime / _timeLimitMs));
			this.x = posX[currentIndex] * 0.5 + 150;
			this.y = posY[currentIndex] * 0.5 + 273;
		}
		
		protected function intiBezier():void
		{
			var iindex:Number = 0;
			//STORE "STRAIGHT" CURVES ANCHOR AND CONTROL POINTS 
			var ttx:Number = 0;
			for (var ssq:int = 0; ssq < 6; ssq++)
			{
				iindex = one_squig_ac * ssq
				
				var dispX:Number = banner_width - PX[15 + iindex];
				for (var B:int = 1; B < 16; B++)
				{
					ttx = PX[15 + iindex] + (dispX / 15) * B;
					PX[15 + B + iindex] = ttx;
					PY[15 + B + iindex] = PY[15 + iindex];
					
				}
			}
			/////// CALCULATE THE INTERSECTION DEPENDABLE ANCHORS IN //	
			//EACH SQUIG'S CURVES' ANCHOR AND CONTROL POINTS ARRAYS
			calc_intersect2(); // does 6 squigs	
			///////////////////////////////////////////////////////////////////////////////////////////////
			// RENDERING/////////////////////////////////////////////////////////////////////////
			for (var i:int = 0; i < 1; i++)
			{
				fill_arrays(i);
			}
		}
		
		protected function initBezierShape():void
		{
			PX[0] = 54.05;
			PY[0] = 199.1;
			PX[1] = 133.7;
			PY[1] = 194.1;
			PX[2] = 116.25;
			PY[2] = 204;
			PX[3] = 117.65;
			PY[3] = 272.55;
			PX[4] = 119.05;
			PY[4] = 341.1;
			PX[5] = 123.5;
			PY[5] = 466.4;
			PX[6] = 134.3;
			PY[6] = 471.75;
			PX[7] = 145.1;
			PY[7] = 477.1;
			PX[8] = 235.4;
			PY[8] = 451;
			PX[9] = 201.65;
			PY[9] = 526.5;
			PX[10] = 167.9;
			PY[10] = 602;
			PX[11] = 566.75;
			PY[11] = 614.15;
			PX[12] = 600.75;
			PY[12] = 532.45;
			PX[13] = 634.75;
			PY[13] = 450.75;
			PX[14] = 686.2;
			PY[14] = 527.1;
			PX[15] = 756.25;
			PY[15] = 525.45;
			
			///////////////////////////////////////////////////////////////////////////
			////// INTERSECTION POINTS ARRAY (BEST TO KEEP ALL 0.5)
			
			INTER[0] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[1] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[2] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[3] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
			INTER[10000] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[10001] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[10002] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[10003] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
			INTER[20000] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[20001] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[20002] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[20003] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
			INTER[30000] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[30001] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[30002] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[30003] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
			INTER[40000] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[40001] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[40002] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[40003] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
			INTER[50000] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<0>>w/<<1>>
			INTER[50001] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<1>>w/<<2>>
			INTER[50002] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<2>>w/<<3>>
			INTER[50003] = 0.5; // INTERSECTION VALUE FOR ANCHOR JOINING CURVES <<3>>w/<<4>>
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		//// BEZIER CUREVE FUNCTIONS 
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///// FUNCTION BEZIER POINT 2 ////////////////////////////////////////////////////
		
		protected function bezier_point2(u:Number, A1:Object, C1:Object, C2:Object, A2:Object):Object
		{
			var posx:Number = Math.pow(u, 3) * (A2.x + 3 * (C1.x - C2.x) - A1.x) + 3 * Math.pow(u, 2) * (A1.x - 2 * C1.x + C2.x) + 3 * u * (C1.x - A1.x) + A1.x;
			var posy:Number = Math.pow(u, 3) * (A2.y + 3 * (C1.y - C2.y) - A1.y) + 3 * Math.pow(u, 2) * (A1.y - 2 * C1.y + C2.y) + 3 * u * (C1.y - A1.y) + A1.y;
			PZ.x = posx;
			PZ.y = posy;
			return PZ;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		/////  FILL ARRAY RESPONSIBLE FOR THE BEZIER CURVE BASED MOVEMENT  /// /////////////////////////////
		
		protected function fill_arrays(uu:Number):void
		{
			var PP:Object = new Object; // TESTED POINT
			var T_A1:Object = new Object // TESTED A1
			var T_C1:Object = new Object // TESTED C1
			var T_C2:Object = new Object // TESTED C2
			var T_A2:Object = new Object // TESTED A2
			
			var squig:Number = uu; // current squig - later loop 0-5
			for (var c:int = 0; c < curves_per_squig + 5; c++)
			{
				
				for (var i:int = 0; i < curve_res; i++)
				{
					// RETRIEVE A/C FOR TESTED POINT
					T_A1.x = PX[c * 3 + squig * one_squig_ac];
					T_A1.y = PY[c * 3 + squig * one_squig_ac];
					T_C1.x = PX[c * 3 + 1 + (squig * one_squig_ac)];
					T_C1.y = PY[c * 3 + 1 + (squig * one_squig_ac)];
					T_C2.x = PX[c * 3 + 2 + (squig * one_squig_ac)];
					T_C2.y = PY[c * 3 + 2 + (squig * one_squig_ac)];
					T_A2.x = PX[c * 3 + 3 + (squig * one_squig_ac)];
					T_A2.y = PY[c * 3 + 3 + (squig * one_squig_ac)];
					
					// RETRIEVE TESTED POINT
					PP = bezier_point2((i / curve_res), T_A1, T_C1, T_C2, T_A2);
					posX[(squig * one_squig_pos) + (c * curve_res - 1) + i] = PP.x;
					posY[(squig * one_squig_pos) + (c * curve_res - 1) + i] = PP.y;
					
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////
		//////// FUNCTION I_RATIO ////////////////////////////////////////////////////////////////
		protected function i_ratio(ratio:Number, x0:Number, x1:Number):Number
		{
			var a:Number = (x0 + ((x1 - x0) * ratio));
			return a;
		}
		
		/////////////////////////////://////////////////////////////////////////////////////////////
		// FUNCTION calc_intersect2 CALCULATING INTERSCECTION DEPENDALBLE ANCHORS /////////////
		protected function calc_intersect2():void
		{
			var index:Number = 0;
			for (var s:int = 0; s < squig_number; s++)
			{
				index = s * one_squig_ac;
				
				PX[3 + index] = i_ratio(INTER[0 + index], PX[2 + index], PX[4 + index]);
				PY[3 + index] = i_ratio(INTER[0 + index], PY[2 + index], PY[4 + index]);
				
				PX[6 + index] = i_ratio(INTER[1 + index], PX[5 + index], PX[7 + index]);
				PY[6 + index] = i_ratio(INTER[1 + index], PY[5 + index], PY[7 + index]);
				
				PX[9 + index] = i_ratio(INTER[2 + index], PX[8 + index], PX[10 + index]);
				PY[9 + index] = i_ratio(INTER[2 + index], PY[8 + index], PY[10 + index]);
				
				PX[12 + index] = i_ratio(INTER[3 + index], PX[11 + index], PX[13 + index]);
				PY[12 + index] = i_ratio(INTER[3 + index], PY[11 + index], PY[13 + index]);
				
			}
		}
	
	}

}