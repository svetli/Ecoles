package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	import com.ecoles.vo.ImageVO;	
	
	public class CMSClientsResult extends Result {
		
		public var logos:Array;
		private var _data:XML;
		
		// Initialization:
		public function CMSClientsResult(pData:String)
		{
			super(pData, "cmsRequest");
			_data =  new XML(result.clients);
			
			var settWhiteSpace:* = XML.ignoreWhitespace;
			var vXML:XML;
			var cVO:ImageVO;
			XML.ignoreWhitespace = true;
			logos = new Array();
			
			for each ( vXML in _data.logos )
			{
				cVO = new ImageVO();
				cVO.id 		= vXML.id;
				cVO.title	= vXML.title;
				cVO.image 	= vXML.path;
				logos.push(cVO);
			}			
			XML.setSettings(XML.defaultSettings());			
		}
	
		// Public Methods:
		public function get data() : XML
		{
			return _data;
		}	
	}
	
}