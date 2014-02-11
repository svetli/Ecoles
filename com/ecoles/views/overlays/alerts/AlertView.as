package com.ecoles.views.overlays.alerts
{
	import com.magna.controls.buttons.*;
    import com.ecoles.models.*;
    import com.magna.views.overlays.*;
    import flash.events.*;
    import flash.text.*;

    public class AlertView extends AbstractOverlayView
    {
        public var title_txt:TextField;
        public var message_txt:TextField;
        public var ok_btn:BaseButton;
        private var _model:EcolesModel;

        public function AlertView(param1:EcolesModel)
        {
            this._model = param1;
            this.title_txt.text = param1.alertObject.title.toUpperCase();
            this.message_txt.autoSize = TextFieldAutoSize.LEFT;
            this.message_txt.text = param1.alertObject.message;
            background.height = this.message_txt.y + this.message_txt.height + 80;
            this.ok_btn.y = background.height - 40;
            this.ok_btn.addEventListener(MouseEvent.CLICK, this.okClickEvent);
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageEvent);
            return;
        }// end function

        private function removedFromStageEvent(param1:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageEvent);
            if (this._model.alertObject.onOK != undefined)
            {
                this._model.alertObject.onOK();
            }// end if
            return;
        }// end function

        private function okClickEvent(param1:MouseEvent) : void
        {
            super.close();
            return;
        }// end function

    }
}
