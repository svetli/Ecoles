package com.magna.controls.sounds
{
	import flash.events.IEventDispatcher;
	
	public interface ISoundSlider extends IEventDispatcher
	{
		public function ISoundSlider();
		
		function get position() : Number;
		
		function set position(pos:Number) : void;
		
		function get enabled() : Boolean;
		
		function set enabled(stat:Boolean) : void;
	}
}