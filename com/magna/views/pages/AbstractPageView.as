package com.magna.views.pages {
	
	import flash.events.Event;
	import com.magna.events.*;
	import com.magna.views.AbstractView;
	
	public class AbstractPageView extends AbstractView {
		
		// Constants:
		// Public Properties:
        public static var DEFAULT_WIDTH:Number = 900;
        public static var DEFAULT_HEIGHT:Number = 600;
		// Private Properties:
	
		// Initialization:
		public function AbstractPageView() {
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStageEvent);
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageEvent);
		}
	
		// Public Methods:
        public function showOverlay(param1:String, param2 = null) : void {
            dispatchEvent(new ChangeViewEvent(ChangeViewEvent.OVERLAY, param1, param2));
        }

        public function alert(param1) : void {
            dispatchEvent(new AlertEvent(AlertEvent.ALERT, param1));
        }

        public function changePage(param1:String, param2 = null) : void {
            dispatchEvent(new ChangeViewEvent(ChangeViewEvent.PAGE, param1, param2));
        }		
		
		// Protected Methods:
        protected function addedToStageEvent(param1:Event) : void {
            stage.addEventListener(Event.RESIZE, this.stageResizeEvent, false, 1);
            this.stageResizeEvent();
        }
		
        protected function removedFromStageEvent(param1:Event) : void {
            this.stageResizeEvent();
            stage.removeEventListener(Event.RESIZE, this.stageResizeEvent);
        }
		
        protected function stageResizeEvent(param1:Event = null) : void {
            x = Math.round( (stage.stageWidth * 0.5) - (DEFAULT_WIDTH * 0.5) );
            y = Math.round( (stage.stageHeight * 0.5) - (DEFAULT_HEIGHT * 0.5) );
        }		
	}
	
}