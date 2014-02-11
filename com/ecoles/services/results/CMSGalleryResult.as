package com.ecoles.services.results {
	
	import com.magna.services.soap.Result;
	import com.ecoles.vo.ImageVO;
	
	public class CMSGalleryResult extends Result {
		
		// Constants:
		// Public Properties:
		public var pictures:Array;
		
		// Private Properties:
		private var _data:XML;
		
		// Initialization:
		public function CMSGalleryResult(pData:String)
		{
			super(pData, "cmsRequest");
			_data =  new XML(result.gallery);
			
			
			var settWhiteSpace:* = XML.ignoreWhitespace;
			var vXML:XML;
			var cVO:ImageVO;
			XML.ignoreWhitespace = true;
			pictures = new Array();
			
			for each ( vXML in _data.pictures.image )
			{
				cVO = new ImageVO();
				cVO.id 		= vXML.id;
				cVO.title	= vXML.title;
				cVO.image 	= vXML.path;
				pictures.push(cVO);
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