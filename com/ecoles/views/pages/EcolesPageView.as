package com.ecoles.views.pages {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.views.pages.AbstractPageView;
	
	public class EcolesPageView extends AbstractPageView {
		
		// Constants:
		
		// Public Properties:
		// Public Properties:
        public static var DEFAULT_WIDTH:Number = 700;
        public static var DEFAULT_HEIGHT:Number = 400;			
		// Private Properties:
	
		// Initialization:
		public function EcolesPageView() {
			super();
		}
		
        override protected function stageResizeEvent(param1:Event = null) : void {
            x = Math.round( (stage.stageWidth * 0.5) - (DEFAULT_WIDTH * 0.5) );
            y = Math.round( (stage.stageHeight * 0.5) - (DEFAULT_HEIGHT * 0.5) );
        }			
	
		// Public Methods:
		// Protected Methods:
	}
	
}