package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	
	public class ContactResult extends Result {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _data:XML;
		
		// Initialization:
		public function ContactResult(pData:String)
		{
			debug = true;
			super(pData, "contactRequest");
			_data =  new XML(result.contacts);
		}
		
		public function get data() : XML
		{
			return _data;
		}	
	}
	
}