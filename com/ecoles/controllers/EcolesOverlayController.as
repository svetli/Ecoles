package com.ecoles.controllers {
	
	import flash.display.*;
	import flash.events.*;
	import com.magna.events.*;
	
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.EcolesOverlayViews;
	import com.ecoles.controllers.EcolesViewController;
	import com.ecoles.controllers.overlays.*;
	
	public class EcolesOverlayController extends Sprite {
		
		// Constants:
		private static var ALPHA:Number = 0.75;
		// Public Properties:
		// Private Properties:
		private var _viewController:EcolesViewController;
		private var _fill:Shape;
		private var _model:EcolesModel;
		
		// Initialization:
		public function EcolesOverlayController(pModel:EcolesModel)
		{
			_model = pModel;
			_viewController = new EcolesViewController(pModel);
			_viewController.register( EcolesOverlayViews.ALERT, AlertController );
			_viewController.register( EcolesOverlayViews.CLIENTS_IMAGE, DefaultOverlayController);
			_viewController.addEventListener( ViewControllerEvent.READY, viewControllerReady );
			addChild(_viewController);
			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStage);			
		}
	
		private function _addedToStage(e:Event) : void
		{
			stage.addEventListener(Event.RESIZE, stageResize);
		}
		
        private function _removedFromStage(e:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, stageResize);
        }
		
        private function viewControllerReady(e:Event) : void
        {
            var _loc_2:* = this._viewController.controller as IOverlayViewController;
            _loc_2.addEventListener(ChangeViewEvent.OVERLAY, controllerChangeOverlay, false, 0, true);
            _loc_2.addEventListener(ChangeViewEvent.PAGE, controllerChangePage, false, 0, true);
            _loc_2.addEventListener(Event.CLOSE, closeOverlay, false, 0, true);
            _loc_2.addEventListener(AlertEvent.ALERT, alert, false, 0, true);
            _loc_2.track();
            return;
        }
		
        private function stageResize(e:Event = null) : void
        {
            if (_fill != null)
            {
                _fill.width = stage.stageWidth;
                _fill.height = stage.stageHeight;
            }
        }
		
        private function controllerChangeOverlay(e:ChangeViewEvent) : void
        {
            _model.setOverlay(e.view, e.data);
        }
		
        private function controllerChangePage(e:ChangeViewEvent) : void
        {
            close();
            _model.setPage(e.view, e.data);
        }
		
        public function close() : void
        {
            if (_fill != null)
            {
                removeChild(_fill);
                _fill = null;
            }
			
            _viewController.clear();
            _model.setOverlay("");
        }
		
        private function alert(e:AlertEvent) : void
        {
            _model.alert(e.alert);
        }		
		
        public function hasOverlay(overlay:String) : Boolean
        {
            return _viewController.hasViewController(overlay);
        }

        private function closeOverlay(param1:Event) : void
        {
            close();
        }
		
        public function viewOverlay(param1:String) : void
        {
            var _loc_2:Boolean;
            var _loc_3:uint;
            if (_fill != null)
            {
                _viewController.viewView(param1);
            }
            else
            {
                _loc_3 = 0;
                _fill = new Shape();
                _fill.graphics.beginFill(_loc_3, ALPHA);
                _fill.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
                _fill.graphics.endFill();
                addChildAt(_fill, 0);
                stage.addEventListener(Event.RESIZE, stageResize);
                viewOverlay(param1);
			}
        }
	}
	
}