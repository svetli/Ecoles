package com.ecoles.views.pages.catalog.woodpulp {
	
	import flash.text.TextField;
	
	import com.ecoles.views.pages.catalog.AbstractCatalogPage;
	import com.ecoles.utils.EcolesStyleSheet;
	
	public class WoodpulpPage extends AbstractCatalogPage {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		// UI Elements:
		public var descriptionText:TextField;
		public var titleText:TextField;		

		
		// Initialization:
		public function WoodpulpPage(xml) {
			// Description
			descriptionText.styleSheet 	= new EcolesStyleSheet();
			descriptionText.htmlText	= formatText(xml.description);
			// Title
			titleText.text = xml.title;	
		}

		// Public Methods:
		// Protected Methods:
		// Private Methods:
		private function formatText(txt:String) : String
		{
			var regExp:* = /\[url=([a-zA-Z0-9:\-_\/.]*)\](.*?)\[\/url\]/gi;
			return txt.replace(regExp, "<a href=\'$1\' target=\'_blank\'>$2</a>");
		}	
	}
	
}