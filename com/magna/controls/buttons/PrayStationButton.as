package com.magna.controls.buttons
{
    import flash.events.*;
	import com.magna.controls.buttons.BaseButton;
	import com.magna.controls.buttons.IButton;
	
    dynamic public class PrayStationButton extends BaseButton implements IButton
    {
        public function PrayStationButton()
        {
            addEventListener(Event.ADDED_TO_STAGE, 		addedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, 	removedFromStage);
        }

        protected function addedToStage(param1:Event) : void
        {
            addEventListener(Event.ENTER_FRAME, enterFrame);
        }

        protected function removedFromStage(param1:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, enterFrame);
        }

        protected function enterFrame(e:Event) : void
        {
            if (!selected && !enabled)
            {
                prevFrame();
                return;
            }
			
            if (hitTestPoint(stage.mouseX, stage.mouseY) || selected)
            {
                nextFrame();
            }
            else
            {
                prevFrame();
            }
        }
    }
}
