package com.ecoles.controllers {
	
	import flash.utils.*;
	import com.asual.swfaddress.*;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.EcolesPageViews;	
	
	public class SWFAddressController extends Object {
	
		// Private Properties:
		private var _model:EcolesModel;
	
		// Initialization:
		public function SWFAddressController(pModel:EcolesModel) {
			this._model = pModel;
			SWFAddress.setHistory(false);
			SWFAddress.addEventListener( SWFAddressEvent.INIT, _swfAddressInitEvent );
		}
	
		public function setValueByPage(page:String) : void
		{
			if( page == EcolesPageViews.HOME )
			{
				SWFAddress.setValue("/");
			}
//			else if( page == EcolesPageViews.NEWS )
//			{
//				SWFAddress.setValue("/news/");
//			}
			else
			{
				// nothing to do ...
			}
		}	
	
		private function _swfAddressInitEvent(e:SWFAddressEvent) : void
		{
			var path:* = e.pathNames[0];
			_model.queryString = SWFAddress.getQueryString();
			
			switch( path )
			{
				case "company" :
				{
					//_model.setPage(PierlucciPageViews.NEWS);
				}
				
				default :
				{
					_model.setPage(EcolesPageViews.HOME);
				}
			}
		}		
	}
	
}