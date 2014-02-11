package com.ecoles.views.pages.catalog.conifers {
	
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import com.ecoles.views.pages.catalog.AbstractCatalogPage;
	import com.ecoles.utils.EcolesStyleSheet;
	import com.ecoles.views.pages.catalog.TableRow;
	
	public class ConifersPage extends AbstractCatalogPage {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		// UI Elements:
		public var titleText:TextField;		

		
		// Initialization:
		public function ConifersPage(xml)
		{
			// Title
			titleText.text = xml.title;
			
			var row:TableRow;
			var item:XML;
			var it:Number = 1;
			for each (item in xml.table.rows)
			{
				row = new TableRow(item.colA, item.colB, item.colC, item.colD);
				row.y = it * row.height;
				addChild(row);
				it++;
				
			}
		}	
	}
	
}