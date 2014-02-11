/**
*	Sound Object
*
*	@package	com.magna.managers
*	@author		Svetli Nikolov
*/
package com.magna.managers
{
	import flash.media.Sound;
	
	class SoundObject
	{
		private var mSound:Sound;
		private var mVolume:Number;
		
		public function SoundObject(pSound:Sound, pVolume:Number)
		{
			mSound  = pSound;
			mVolume = pVolume;
		}
		
		public function get sound():Sound
		{
			return mSound;
		}
		
		public function get volume():Number
		{
			return mVolume;
		}
	}
}