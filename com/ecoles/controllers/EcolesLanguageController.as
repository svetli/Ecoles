package com.ecoles.controllers {
	
	import flash.events.*;
	import flash.net.*;
	
	import com.magna.events.*;
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.services.requests.CMSRequest;
	import com.ecoles.services.results.CMSLanguageResult;	
	
	public class EcolesLanguageController extends EventDispatcher {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _model:EcolesModel;
		private var _dataLoader:URLLoader;
	
		// Initialization:
		public function EcolesLanguageController(pModel:EcolesModel)
		{
			_model = pModel;
			// read & parse swf address
			// &lang=xx
			_init();
		}
		
		private function _init() : void
		{
			var urlRequest:* = new CMSRequest(EcolesConfig.LANGUAGE_ID, this._model.language);
			this._dataLoader = new URLLoader( urlRequest.request );
			this._dataLoader.addEventListener( Event.COMPLETE, _loadDataComplete );
			this._dataLoader.addEventListener( IOErrorEvent.IO_ERROR, _loadDataError );
			this._dataLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _loadDataError );			
		}

		private function _loadDataError(e:ErrorEvent) : void
		{
			trace("Unable to load language file. " + e);
			//dispatchEvent(ErrorEvent.IO_ERROR);
		}
		
		private function _loadDataComplete(e:Event) : void
		{
			var dResult:* = new CMSLanguageResult(e.target.data);
			
			if ( !dResult.success )
			{
				dispatchEvent( new IOErrorEvent(IOErrorEvent.IO_ERROR) );
			}
			else
			{
				_model.langModel.setData(dResult.data);
			}

			dispatchEvent( new Event(Event.COMPLETE) );
		}			
	}
	
}