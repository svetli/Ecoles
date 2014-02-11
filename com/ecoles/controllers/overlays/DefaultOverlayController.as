package com.ecoles.controllers.overlays {
	
    import com.magna.events.*;
	import com.magna.views.AbstractView;
	import com.magna.views.overlays.AbstractOverlayView;
	
    import com.ecoles.models.EcolesModel;
	import com.ecoles.views.EcolesOverlayViews;
    import com.ecoles.views.overlays.clientsimage.*;
    
	import flash.events.*;	
	
	public class DefaultOverlayController extends EventDispatcher {
		
        private var _view:AbstractOverlayView;
        private var _model:EcolesModel;
        private var _trackingURL:String;
	
		// Initialization:
		public function DefaultOverlayController(param1:EcolesModel)
		{
            this._model = param1;
            this._view = this.getView(this._model.currentOverlay);
            this._view.addEventListener(Event.CLOSE, dispatchEvent);
            this._view.addEventListener(ChangeViewEvent.OVERLAY, dispatchEvent);
            this._view.addEventListener(ChangeViewEvent.PAGE, dispatchEvent);
            this._view.addEventListener(AlertEvent.ALERT, this.viewAlertEvent);			
		}
	
        private function viewAlertEvent(event:AlertEvent) : void
        {
            this._model.alert(event.alert);
            return;
        }// end function

        public function get view() : AbstractView
        {
            return this._view;
        }// end function

        public function init() : void
        {
            dispatchEvent(new ViewControllerEvent(ViewControllerEvent.READY));
            return;
        }// end function

        public function track() : void
        {
            if (this._trackingURL != "")
            {
                //GoogleAnalytics.trackEvent("overlay", this._trackingURL);
            }
            return;
        }// end function

        private function getView(param1:String) : AbstractOverlayView
        {
            if (param1 == EcolesOverlayViews.CLIENTS_IMAGE)
            {
                this._trackingURL = "clientsImage";
                return new ClientsImageView(this._model);
            }
            this._trackingURL = "";
			return null;
        }// end function

        public function unload() : void
        {
            this._view.removeEventListener(Event.CLOSE, dispatchEvent);
            this._view.removeEventListener(Event.CLOSE, dispatchEvent);
            this._view = null;
            return;
        }// end function
	}
	
}