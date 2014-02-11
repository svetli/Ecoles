package com.ecoles.controllers.overlays
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	import com.magna.views.AbstractView;
	import com.magna.views.overlays.AbstractOverlayView;
	import com.magna.events.ViewControllerEvent;
	
	import com.ecoles.controllers.overlays.IOverlayViewController;
	import com.ecoles.views.overlays.alerts.*;
	import com.ecoles.models.EcolesModel;
	
	public class AlertController extends EventDispatcher implements IOverlayViewController
	{
		private var _model:EcolesModel;
		private var _view:AbstractOverlayView;
		
		public function AlertController(pModel:EcolesModel)
		{
			_model = pModel;
			_view = new AlertView(pModel);
			_view.addEventListener(Event.CLOSE, dispatchEvent);
		}
		
        public function get view() : AbstractView
        {
            return this._view;
        }

        public function unload() : void
        {
            return;
		}

        public function track() : void
        {
            return;
        }

        public function init() : void
        {
            dispatchEvent(new ViewControllerEvent(ViewControllerEvent.READY));
            return;
        }
		
	}
}