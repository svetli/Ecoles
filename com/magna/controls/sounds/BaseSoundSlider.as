package com.magna.controls.sounds
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	import com.magna.controls.sounds.ISoundSlider;
	
	dynamic public class BaseSoundSlider extends MovieClip implements ISoundSlider
	{
		private var _position:Number;
		private var _isEnabled:Boolean;
		
		public var slider:MovieClip;
		public var background:MovieClip;
		
		public function BaseSoundSlider()
		{
			tabChildren = false;
			enable();
			background.addEventListener( MouseEvent.MOUSE_DOWN, backgroundMouseDown );
			slider.alpha = 0.25;
			slider.addEventListener( MouseEvent.MOUSE_DOWN, sliderMouseDown );
			slider.addEventListener( MouseEvent.MOUSE_UP, sliderMouseUp );
		}
		
		/**
		*	Overrides
		*
		*/
		override public function set enabled(stat:Boolean) : void
		{
			if(stat)
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
		
		/**
		*	Public Methods
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
		
		/**
		*	Protected Methods
		*
		*/
		protected function setPosition(pos:Number) : void
		{
			if( pos != _position )
			{
				slider.x = Math.max(0, Math.min(1, pos)) * background.width;
				trace("slider.x = " + slider.x);
				trace("position = " + pos);
				_position = pos;
				slider.vol.text = slider.x;
				dispatchEvent( new Event(Event.CHANGE) );
			}
		}
		
		protected function enable() : void
		{
			_isEnabled 				= true;
			slider.enabled 			= true;
			background.mouseEnabled = true;
		}
		
		protected function disable() : void
		{
			_isEnabled				= false;
			slider.enabled			= false;
			background.mouseEnabled = false;
		}
		
		/**
		*	Private Methods
		*
		*/
		private function backgroundMouseDown(event:MouseEvent) : void
		{
			slider.alpha = 1;
			var pos:* = mouseX /background.width;
			setPosition( Math.max(0, Math.min(1, pos)) );
		}
		
		private function sliderMouseDown(event:MouseEvent) : void
		{
			var rect:Rectangle = new Rectangle();
			rect.x 		= 0;
			rect.y 		= 0;
			rect.width 	= background.width;
			rect.height = 0;
			slider.alpha = 1;
			slider.startDrag(false, rect);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,   stageMouseUp);
		}
		
		private function sliderMouseUp(event:MouseEvent) : void
		{
			slider.stopDrag();
			slider.alpha = 0.25;
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseUp);			
		}
		
		private function stageMouseMove(event:MouseEvent) : void
		{
			var pos:* = mouseX/background.width;
			setPosition( Math.max(0, Math.min(1, pos)) );			
		}
		
		private function stageMouseUp(event:MouseEvent) : void
		{
			slider.stopDrag();
			slider.alpha = 0.25;
			if( stage != null )
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseUp);
			}
		}
	}
}