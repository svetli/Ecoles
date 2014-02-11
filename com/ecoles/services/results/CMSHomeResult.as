package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	
	public class CMSHomeResult extends Result {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _data:XML;
	
		// Initialization:
		public function CMSHomeResult(pData:String) {
			super(pData, "cmsRequest");
			_data =  new XML(result.home);
		}
		
		// Public Methods:
		public function get data() : XML
		{
			return _data;
		}	
	}
	
}