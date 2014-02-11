package com.ecoles.controllers.pages {

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.geom.*;
	
	import com.magna.controllers.IPageViewController;
	import com.magna.views.AbstractView;
	import com.magna.events.*;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.home.HomeView;
	import com.ecoles.services.requests.CMSRequest;
	import com.ecoles.services.results.CMSHomeResult;

	public class HomeController extends EventDispatcher implements IPageViewController {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _model:EcolesModel;
		private var _view:HomeView;
		private var _dataLoader:URLLoader;		
	
		// Initialization:
		public function HomeController(pModel:EcolesModel) {
			this._model = pModel;
			this._view	= new HomeView();
		}
	
		/**
		*	Get View
		*	@implemented	IPageViewController
		*/
		public function get view() : AbstractView {
			return _view;
		}
		
		/**
		*	Unload View
		*	@implemented	IPageViewController
		*/
		public function unload() : void {
			_model = null;
			_view.destroy();
		}
		
		/**
		*	Initialize
		*	@implemented	IPageViewController
		*/		
		public function init() : void {
			// loading data
			var _urlRequest:* = new CMSRequest(EcolesConfig.HOME_ID, this._model.language);
			this._dataLoader = new URLLoader( _urlRequest.request );
			this._dataLoader.addEventListener( Event.COMPLETE, _loadDataComplete );
			this._dataLoader.addEventListener( IOErrorEvent.IO_ERROR, _loadDataError );
			this._dataLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _loadDataError );
			dispatchEvent( new LoadEvent( LoadEvent.START ) );			
		}
		
		/**
		*	Page Title
		*	@implemented	IPageViewController
		*/
		public function get title() : String {
			return "Home";
		}
		
		
		private function _loadDataError(e:ErrorEvent) : void
		{
			dispatchEvent( new LoadErrorEvent(LoadErrorEvent.ERROR, e.text) );
		}
		
		private function _loadDataComplete(e:Event) : void
		{
			var dResult:* = new CMSHomeResult(e.target.data);
			
			if ( !dResult.success )
			{
				dispatchEvent(new LoadErrorEvent(LoadErrorEvent.ERROR, dResult.message));
			}
			else
			{
				_view.model = _model;
				_view.setHomeData( dResult.data );
			}

			dispatchEvent( new LoadEvent( LoadEvent.COMPLETE, 1 ) );
			dispatchEvent( new ViewControllerEvent( ViewControllerEvent.READY ) );
		}		
	}
	
}