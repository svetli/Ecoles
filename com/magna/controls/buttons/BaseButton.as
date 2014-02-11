/**
*	Magna Library: Base Button
*
*	@package	com.magna.controls.buttons
*	@author		Svetli Nikolov
*/
package com.magna.controls.buttons
{
	import com.magna.controls.buttons.IButton;
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.text.TextField;
	
	public class BaseButton extends MovieClip implements IButton
	{
        private var _isSelected:Boolean;
        private var _isEnabled:Boolean;
        public  var hit:Sprite;
		public  var bLabel:TextField; 
		
        public function BaseButton()
        {
            if ( hit != null )
            {
                hitArea = hit;
                hitArea.visible = false;
            }
			
            tabEnabled 		= false;
            mouseChildren 	= false;
            tabChildren 	= false;
            enable();
        }
		
        protected function enable() : void
        {
            buttonMode 		= true;
            mouseEnabled 	= true;
            Mouse.show();
            _isEnabled 		= true;
        }
		
        protected function disable() : void
        {
            buttonMode 		= false;
            mouseEnabled 	= false;
            Mouse.show();
            _isEnabled 		= false;
		}
		
        override public function set enabled(p:Boolean) : void
        {
            if (p) {
                enable();
            } else {
                disable();
            }
		}
		
        override public function get enabled() : Boolean
        {
            return _isEnabled;
        }		
		
        protected function setSelected(p:Boolean) : void
        {
            if ( _isSelected == p ) {
                return;
            }
			
            _isSelected = p;
			
            if ( _isSelected ) {
                dispatchEvent(new Event(Event.SELECT));
            }
        }
		
        public function set selected(p:Boolean) : void
        {
            setSelected(p);
        }
		
        public function get selected() : Boolean
        {
            return _isSelected;
        }		
	}
}