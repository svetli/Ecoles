package com.magna.controls.progress
{
	import flash.events.IEventDispatcher;
	
	public interface IProgressDisplay extends IEventDispatcher
	{
		public function IProgressDisplay();
		
		function set progress(p:Number):void;
		
		function get progress():Number;
	}
}