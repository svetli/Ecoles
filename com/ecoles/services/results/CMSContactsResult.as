package com.ecoles.services.results {

	import com.magna.services.soap.Result;

	public class CMSContactsResult extends Result {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _data:XML;
	
		// Initialization:
		public function CMSContactsResult(pData:String)
		{
			super(pData, "cmsRequest");
			_data =  new XML(result.contacts);
		}
	
		// Public Methods:
		// Public Methods:
		public function get data() : XML
		{
			return _data;
		}			
	}
}