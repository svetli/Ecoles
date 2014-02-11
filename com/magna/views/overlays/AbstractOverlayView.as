package com.magna.views.overlays {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import com.magna.views.AbstractView;
	import com.magna.events.ChangeViewEvent;
	import com.magna.events.AlertEvent;
	import com.magna.events.TransitionEvent;
	import com.magna.transitions.AbstractTransition;
	import com.magna.transitions.DefaultOverlayTransition;
	import com.magna.models.AlertModel;	
	
	public class AbstractOverlayView extends AbstractView
	{
		protected var _clickToClose:Boolean;
		private var _isClosing:Boolean;
		
		public var close_btn:MovieClip;
		public var background:MovieClip;
		
		public function AbstractOverlayView()
		{
			_clickToClose = true;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			close_btn.addEventListener(MouseEvent.CLICK, closeClickEvent);
		}
		
        override public function intro() : AbstractTransition
        {
            var dOT:DefaultOverlayTransition = new DefaultOverlayTransition(this, DefaultOverlayTransition.INTRO);
            dOT.addEventListener(TransitionEvent.COMPLETE, introComplete);
            setTimeout(dOT.start, 100);
            return dOT;
        }		
		
        override public function outro() : AbstractTransition
        {
            _isClosing = true;
            return super.outro();
		}
		
        private function introComplete(param1:TransitionEvent) : void
        {
            stage.addEventListener(MouseEvent.CLICK, stageClickEvent, true);
        }		
		
        private function addedToStage(e:Event) : void
        {
            updatePosition();
            stage.addEventListener(Event.RESIZE, stageResizeEvent);
		}
		
        private function removedFromStage(e:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, stageResizeEvent);
            stage.removeEventListener(MouseEvent.CLICK, stageClickEvent, true);
		}
		
        private function stageResizeEvent(e:Event) : void
        {
            updatePosition();
        }
		
        public function updatePosition() : void
        {
            x = Math.round(stage.stageWidth * 0.5 - this.background.width * 0.5);
            y = Math.round(stage.stageHeight * 0.5 - this.background.height * 0.5);
        }
		
        private function stageClickEvent(e:MouseEvent) : void
        {
            if (_clickToClose && !this.background.hitTestPoint(parent.mouseX, parent.mouseY))
            {
                this.close();
            }
        }

        private function closeClickEvent(e:MouseEvent) : void
        {
            this.close();
        }
		
        public function close() : void
        {
            if (!_isClosing)
            {
                dispatchEvent(new Event(Event.CLOSE));
            }
        }
		
        public function showOverlay(overlay:String, args = null) : void
        {
            dispatchEvent(new ChangeViewEvent(ChangeViewEvent.OVERLAY, overlay, args));
        }
		
        public function alert(alr:String, args:String) : void
        {
            dispatchEvent(new AlertEvent(AlertEvent.ALERT, new AlertModel(alr, args)));
        }
		
        public function changePage(page:String, args = null) : void
        {
            dispatchEvent(new ChangeViewEvent(ChangeViewEvent.PAGE, page, args));
        }		
	}
	
}