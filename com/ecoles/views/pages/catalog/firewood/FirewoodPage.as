package com.ecoles.views.pages.catalog.firewood {
	
	import flash.text.TextField;
	
	import com.ecoles.views.pages.catalog.AbstractCatalogPage;
	import com.ecoles.utils.EcolesStyleSheet;
	
	public class FirewoodPage extends AbstractCatalogPage {
		
		// UI Elements:
		public var descriptionText:TextField;
		public var titleText:TextField;	
		
		// Initialization:
		public function FirewoodPage(xml) {
			// Description
			descriptionText.styleSheet 	= new EcolesStyleSheet();
			descriptionText.htmlText	= formatText(xml.description);
			// Title
			titleText.text = xml.title;	
		}
		
		private function formatText(txt:String) : String
		{
			var regExp:* = /\[url=([a-zA-Z0-9:\-_\/.]*)\](.*?)\[\/url\]/gi;
			return txt.replace(regExp, "<a href=\'$1\' target=\'_blank\'>$2</a>");
		}	
	}
	
}