package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	
	public class CMSLanguageResult extends Result {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _data:XML;
	
		// Initialization:
		public function CMSLanguageResult(pData:String) {
			
			super(pData, "cmsRequest");
			_data =  new XML(result.lang);
		}
		
		// Public Methods:
		public function get data() : XML
		{
			return _data;
		}	
	}
	
}