package com.magna.models {
	
	dynamic public class LanguageModel extends Object {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _lang:String;
		
		// Initialization:
		public function LanguageModel() { }
	
		public function setData(pData:XML) : void
		{
			var pXML:XML = new XML(pData);
			var pairs:XMLList  = pXML.children();
			for each ( var item:XML in pairs )
			{
				this[item.name()] = item;
			}
		}
	
		public function set lang(lang:String) : void 
		{
			_lang = lang;
		}
		
		public function get lang() : String
		{
			return _lang;
		}
		
		public function toString() : String
		{
			return _lang;
		}
	}	
}