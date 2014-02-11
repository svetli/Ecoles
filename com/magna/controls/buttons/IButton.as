/**
*	Magna Library: Button Interface
*
*	@package	com.magna.controls.buttons
*	@author		Svetli Nikolov
*/
package com.magna.controls.buttons
{
	import flash.events.*;
	
    public interface IButton extends IEventDispatcher
    {

        public function IButton();

        function get enabled() : Boolean;

        function set enabled(param1:Boolean) : void;

        function get selected() : Boolean;

        function set selected(param1:Boolean) : void;

    }
}