/**
*	Magna Library: Base ScrollBar
*
*	@package	com.magna.controls.scrollbars
*	@author		Svetli Nikolov
*/
package com.magna.controls.scrollbars
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	dynamic public class BaseScrollBar extends MovieClip implements IScrollBar
	{
		private var _position:Number;
		private var _isEnabled:Boolean;
		
		public var slider:MovieClip;
		public var gutter:MovieClip;
		
		public function BaseScrollBar()
		{
			tabChildren = false;
			enable();
			gutter.addEventListener( MouseEvent.MOUSE_DOWN, gutterMouseDown );
			slider.addEventListener( MouseEvent.MOUSE_DOWN, sliderMouseDown );
			slider.addEventListener( MouseEvent.MOUSE_UP  , sliderMouseUp);
		}
		
        private function sliderMouseDown(e:MouseEvent) : void
        {
            var rect:* 	= new Rectangle();
            rect.x 		= slider.x;
            rect.y 		= 0;
            rect.width 	= 0;
            rect.height = gutter.height - slider.height;
			
            slider.startDrag(false, rect);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, 	stageMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, 	stageMouseUp);
        }
		
        private function stageMouseMove(e:MouseEvent) : void
        {
            var pos:* = slider.y / (gutter.height - slider.height);
            setPosition(Math.max(0, Math.min(1, pos)));
        }
		
        private function stageMouseUp(param1:MouseEvent) : void
        {
            slider.stopDrag();
			
            if ( stage != null )
            {
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
                stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseUp);
            }
        }
		
        private function sliderMouseUp(param1:MouseEvent) : void
        {
            slider.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseUp);
        }		
		
        private function gutterMouseDown(e:MouseEvent) : void
        {
            var pos:* = mouseY / (gutter.height - slider.height);
            this.setPosition(Math.max(0, Math.min(1, pos)));
        }
		
		/**
		*	Class Implementation
		*
		*/
        public function set position(pos:Number) : void
        {
            setPosition(pos);
		}
		
        public function get position() : Number
        {
            return _position;
        }
		
        override public function set enabled(stat:Boolean) : void
        {
            if (stat)
            {
                enable();
            }
            else
            {
                disable();
            }
        }
		
        override public function get enabled() : Boolean
        {
            return _isEnabled;
        }
		
        protected function setPosition(pos:Number) : void
        {
            if ( pos != _position)
            {
                slider.y = Math.max(0, Math.min(1, pos)) * (gutter.height - slider.height);
                _position = pos;
                dispatchEvent(new Event(Event.SCROLL));
            }
        }
		
        protected function disable() : void
        {
            _isEnabled = false;
            gutter.mouseEnabled = false;
            slider.enabled = false;
        }

        protected function enable() : void
        {
            _isEnabled = false;
            gutter.mouseEnabled = true;
            slider.enabled = true;
        }
	}
}