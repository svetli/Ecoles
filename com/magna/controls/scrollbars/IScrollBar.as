/**
*	Magna Library: ScrollBar Interface
*
*	@package	com.magna.controls.scrollbars
*	@author		Svetli Nikolov
*/
package com.magna.controls.scrollbars
{
	import flash.events.IEventDispatcher;
	
	public interface IScrollBar extends IEventDispatcher
	{
		public function IScrollBar();
		
		function set position(pos:Number) : void;
		
		function get position() : Number;
		
		function set enabled(stat:Boolean) : void;
		
		function get enabled() : Boolean;
	}
}