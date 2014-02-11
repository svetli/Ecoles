/**
*	Magna Simple Progress Bar
*
*	@package	com.magna.controls.progress
*	@author		Svetli Nikolov
*/
package com.magna.controls.progress
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class SimpleProgressBar extends Sprite
	{
		public var track:MovieClip;
		public var fill:MovieClip;
		
		public function SimpleProgressBar()
		{
			progress = 0;
		}
		
		public function set progress(p:Number):void
		{
			setProgress(p);
		}
		
		public function get progress():Number
		{
			return this.fill.width / this.track.width;
		}
		
		private function setProgress(p:Number):void
		{
			if(p != progress)
			{
				this.fill.width = Math.max(0, Math.min(1, p)) * this.track.width;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}