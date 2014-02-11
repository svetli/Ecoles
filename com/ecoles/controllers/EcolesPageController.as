package com.ecoles.controllers {
	
	import flash.display.*;
	import flash.events.*;
	
	import com.magna.controllers.IPageViewController;
	import com.magna.managers.BrowserManager;
	import com.magna.events.*;
	import com.magna.views.AbstractView;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.EcolesPageViews;
	import com.ecoles.controllers.pages.*;
	
	import com.ecoles.controls.SectionProgressDisplay;	
	
	
	public class EcolesPageController extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		private var _model:EcolesModel;
		private var _viewController:EcolesViewController;
		private var _isPreloading:Boolean;
		private var _pendingPage:String;
		private var _preloader:SectionProgressDisplay;
		
		/**
		*	Class Constructor
		*	@param	EcolesModel
		*	@param	string	
		*/
		public function EcolesPageController( model:EcolesModel, view:String = "auto" )
		{
			_model = model;
			_viewController = new EcolesViewController(model, view);
			_viewController.register( EcolesPageViews.HOME , HomeController );
			_viewController.register( EcolesPageViews.CONTACTS, ContactsController );
			_viewController.register( EcolesPageViews.GALLERY , GalleryController );
			_viewController.register( EcolesPageViews.CATALOG , CatalogController );
			_viewController.register( EcolesPageViews.CLIENTS , ClientsController );
			_viewController.addEventListener(LoadEvent.COMPLETE, 		_controllerLoadComplete	);
			_viewController.addEventListener(LoadEvent.PROGRESS, 		_controllerLoadProgress	);
			_viewController.addEventListener(LoadEvent.START,	 		_controllerLoadStart	);
			_viewController.addEventListener(LoadErrorEvent.ERROR,		_controllerLoadError	);
			_viewController.addEventListener(ViewControllerEvent.READY,	_controllerReadyEvent	);
			addChild(_viewController);
		}
		
		/**
		*	Ecoles View Controller Loading Events
		*	
		*/
		private function _controllerLoadComplete(e:LoadEvent) : void
		{
			if( _isPreloading )
			{
				_preloader.outro();
			}
			else
			{
				dispatchEvent(e);
			}
		}
		
		private function _controllerLoadProgress(e:LoadEvent) : void
		{
			if(_isPreloading)
			{
				_preloader.progress = e.progress;
			}
			
			dispatchEvent(e);
		}
		
		private function _controllerLoadStart(e:LoadEvent) : void
		{
			if( _viewController.mode == EcolesViewController.AUTO )
			{
				_isPreloading = true;
				_viewController.mode = EcolesViewController.MANUAL;
				_preloader = new SectionProgressDisplay();
				_preloader.addEventListener(Event.COMPLETE, _preloaderCompleteEvent);
				_preloader.progress = e.progress;
				stage.addChild(_preloader);
			}
			
			dispatchEvent(e);
		}
		
		private function _controllerLoadError(e:LoadErrorEvent) : void
		{
			dispatchEvent(e);
		}
		
		private function _controllerReadyEvent(e:ViewControllerEvent) : void
		{
			var vc:IPageViewController;
			
			if( _isPreloading )
			{
				_preloader.outro();
			}
			else
			{
				vc = _viewController.controller as IPageViewController;
				vc.addEventListener( ChangeViewEvent.OVERLAY, 		_controllerChangeViewEvent, false, 0, true );
				vc.addEventListener( ChangeViewEvent.PAGE,			_controllerChangeViewEvent, false, 0, true );
				vc.addEventListener( ChangeViewEvent.CHANGE_VIEW, 	_controllerChangeViewEvent, false, 0, true );
				vc.addEventListener( AlertEvent.ALERT,				_controllerAlertEvent,		false, 0, true );
				
				BrowserManager.setTitle(EcolesConfig.TITLE + " - " + vc.title.toUpperCase() );
				
				dispatchEvent(e);
			}
		}
		
		private function _controllerChangeViewEvent(e:ChangeViewEvent) : void
		{
			if( e.type == ChangeViewEvent.OVERLAY )
			{
				_model.setOverlay( e.view, e.data );
			}
			else
			{
				_model.setPage( e.view, e.data );
			}
		}
		
		private function _controllerAlertEvent(e:AlertEvent) : void
		{
			_model.alert(e.alert);
		}
		
		public function set mode(pMode:String) : void
		{
			_viewController.mode = pMode;
		}
		
		public function get mode() : String
		{
			return _viewController.mode;
		}
		
        public function get view() : AbstractView
        {
            return _viewController.view;
        }
		
		public function hasPage(page:String) : Boolean
		{
			return _viewController.hasViewController(page);
		}
		
		public function viewPage(page:String) : void
		{
			if( _viewController.view != null )
			{
				_viewController.view.mouseEnabled  = false;
				_viewController.view.mouseChildren = false;
			}
			
			_viewController.viewView(page);
		}
		
		private function _preloaderCompleteEvent(e:Event) : void
		{
			stage.removeChild(_preloader);
			_preloader = null;
			_isPreloading = false;
			_viewController.mode = EcolesViewController.AUTO;
			dispatchEvent(new LoadEvent(LoadEvent.COMPLETE, 1));
			_controllerReadyEvent(new ViewControllerEvent(ViewControllerEvent.READY));
			_viewController.view.intro();
		}
	}
	
}