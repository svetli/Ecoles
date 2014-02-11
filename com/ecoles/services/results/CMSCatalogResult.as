package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	
	public class CMSCatalogResult extends Result {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _data:XML;
		
		// Initialization:
		public function CMSCatalogResult(pData:String)
		{
			super(pData, "cmsRequest");
			_data =  new XML(result.catalog);			
		}
	
		public function get data() : XML
		{
			return _data;
		}	
	}
}