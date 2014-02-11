package com.ecoles.controllers.pages {
	
	import flash.events.*;
	import flash.net.*;
	
	import com.magna.controllers.IPageViewController;
	import com.magna.views.AbstractView;
	import com.magna.events.*;	
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.gallery.GalleryView;
	import com.ecoles.services.requests.CMSRequest;
	import com.ecoles.services.results.CMSGalleryResult;	
	
	public class GalleryController extends EventDispatcher implements IPageViewController {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _model:EcolesModel;
		private var _view:GalleryView;
		private var _dataLoader:URLLoader;		
	
		// Initialization:
		public function GalleryController(pModel:EcolesModel)
		{
			_model = pModel;
			_view  = new GalleryView();
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
			var _urlRequest:* = new CMSRequest(EcolesConfig.GALLERY_ID, this._model.language);
			this._dataLoader = new URLLoader( _urlRequest.request );
			this._dataLoader.addEventListener( Event.COMPLETE, _loadDataComplete );
			this._dataLoader.addEventListener( IOErrorEvent.IO_ERROR, _loadDataError );
			this._dataLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _loadDataError );
			dispatchEvent( new LoadEvent( LoadEvent.START ) );	
		}		
		
		private function _loadDataError(e:ErrorEvent) : void
		{
			dispatchEvent( new LoadErrorEvent(LoadErrorEvent.ERROR, e.text) );
		}
		
		private function _loadDataComplete(e:Event) : void
		{
			var dResult:* = new CMSGalleryResult(e.target.data);
			
			if ( !dResult.success )
			{
				dispatchEvent(new LoadErrorEvent(LoadErrorEvent.ERROR, dResult.message));
			}
			else
			{				
				_view.model = _model;
				_view.setGalleryData( dResult.data );
				_view.setImagesData(dResult.pictures);
			}

			dispatchEvent( new LoadEvent( LoadEvent.COMPLETE, 1 ) );
			dispatchEvent( new ViewControllerEvent( ViewControllerEvent.READY ) );
		}				
		
		/**
		*	Page Title
		*	@implemented	IPageViewController
		*/
		public function get title() : String {
			return "Gallery";
		}			
		
	
		// Public Methods:
		// Protected Methods:
	}
	
}