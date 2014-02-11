package com.magna.controls.textinputs
{
	import flash.events.IEventDispatcher;
	
    public interface ITextInput extends IEventDispatcher
    {
        public function ITextInput();

        function get enabled() : Boolean;

        function set enabled(param1:Boolean) : void;

        function set text(param1:String) : void;

        function get text() : String;

    }
}
