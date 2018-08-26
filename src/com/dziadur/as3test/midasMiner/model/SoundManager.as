package com.dziadur.as3test.midasMiner.model
{
	import flash.media.Sound;
	import flash.utils.getTimer;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author
	 */
	public class SoundManager extends Actor
	{
		[Embed(source="../../../../../../lib/sounds/basicSounds/swap_jewels.mp3")]
		private const swapJewelsSound:Class; 
		protected var _swapJewels:Sound;
		
		[Embed(source="../../../../../../lib/sounds/basicSounds/explosion.mp3")]
		private const jewelExplosionSound:Class; 
		protected var _jewelExplosion:Sound;
		
		[Embed(source="../../../../../../lib/sounds/basicSounds/cllick.mp3")]
		private const mouseButtonSound:Class; 
		protected var _mouseButton:Sound;
		
		[Embed(source="../../../../../../lib/sounds/basicSounds/end_game.mp3")]
		private const endGameSound:Class; 
		protected var _endGame:Sound;
		
		////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
		//  HIT THE GROUND SOUNDS
		//
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_0.mp3")]
		private const HitTheGroundSound_0:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_1.mp3")]
		private const HitTheGroundSound_1:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_2.mp3")]
		private const HitTheGroundSound_2:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_3.mp3")]
		private const HitTheGroundSound_3:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_4.mp3")]
		private const HitTheGroundSound_4:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_5.mp3")]
		private const HitTheGroundSound_5:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_6.mp3")]
		private const HitTheGroundSound_6:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_7.mp3")]
		private const HitTheGroundSound_7:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_8.mp3")]
		private const HitTheGroundSound_8:Class;
		
		[Embed(source="../../../../../../lib/sounds/hitTheGroundSounds/hit_9.mp3")]
		private const HitTheGroundSound_9:Class;
		
		////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
		
		protected var _hitTheGroundSounds:Vector.<Sound> = new Vector.<Sound>;
		protected var _hitTheGroundSoundGateTime:int = 50;
		protected var _timeOfPreviousHitTheGroundSoundFX:int = 0;
		
		private var forceInclude:Array = [HitTheGroundSound_0, HitTheGroundSound_1, HitTheGroundSound_2, HitTheGroundSound_3, HitTheGroundSound_4, HitTheGroundSound_5, HitTheGroundSound_6, HitTheGroundSound_7, HitTheGroundSound_8, HitTheGroundSound_9];
		
		public function SoundManager()
		{
			initBasicSounds();
			initHitTheGroundSounds();
		}
		
		protected function initBasicSounds():void
		{
			_mouseButton = new mouseButtonSound() as Sound;
			_endGame = new endGameSound() as Sound;
			_jewelExplosion = new jewelExplosionSound() as Sound;
			_swapJewels = new swapJewelsSound() as Sound;
		}
		
		protected function initHitTheGroundSounds():void
		{
			_hitTheGroundSounds[0] = new HitTheGroundSound_0() as Sound;
			_hitTheGroundSounds[1] = new HitTheGroundSound_1() as Sound;
			_hitTheGroundSounds[2] = new HitTheGroundSound_2() as Sound;
			_hitTheGroundSounds[3] = new HitTheGroundSound_3() as Sound;
			_hitTheGroundSounds[4] = new HitTheGroundSound_4() as Sound;
			_hitTheGroundSounds[5] = new HitTheGroundSound_5() as Sound;
			_hitTheGroundSounds[6] = new HitTheGroundSound_6() as Sound;
			_hitTheGroundSounds[7] = new HitTheGroundSound_7() as Sound;
			_hitTheGroundSounds[8] = new HitTheGroundSound_8() as Sound;
			_hitTheGroundSounds[9] = new HitTheGroundSound_9() as Sound;
		}
		
		public function mouseButton():void
		{
			_mouseButton.play();
		}
		
		public function swapJewels():void
		{
			_swapJewels.play();
		}
		
		public function jewelExplosion():void
		{
			_jewelExplosion.play();
		}
		
		public function intro():void
		{
			// WE CAN USE IMPLEMENT SOME SOUNDS FOR THE INTRO HERE 
		}
		
		public function endGame():void
		{
			_endGame.play();
		}
		
		public function hitTheGround(soundVersion:uint):void
		{
			var currentTime:int = getTimer();
			
			if (currentTime - _timeOfPreviousHitTheGroundSoundFX > hitTheGroundSoundGateTime) // WE ARE BLOCKING HIT THE GROUND SOUNDS WHICH COME ABOUT SIMILAR TIME, ONLY ONE SOUND PER 100 ms ALLOWED
			{
				_hitTheGroundSounds[soundVersion % 10].play();
			}
			
			_timeOfPreviousHitTheGroundSoundFX = currentTime;
		}
		
		public function get hitTheGroundSounds():Vector.<Sound>
		{
			return _hitTheGroundSounds;
		}
		
		public function get hitTheGroundSoundGateTime():int
		{
			return _hitTheGroundSoundGateTime;
		}
		
		public function set hitTheGroundSoundGateTime(value:int):void
		{
			_hitTheGroundSoundGateTime = value;
		}
	
	}

}