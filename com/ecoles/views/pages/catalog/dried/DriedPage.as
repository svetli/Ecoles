package com.ecoles.views.pages.catalog.dried {
	
	import flash.text.TextField;
	
	import com.ecoles.views.pages.catalog.AbstractCatalogPage;
	import com.ecoles.utils.EcolesStyleSheet;
	import com.ecoles.views.pages.catalog.TableRow;
	
	public class DriedPage extends AbstractCatalogPage {
		
		public var titleText:TextField;
		
		// Initialization:
		public function DriedPage(xml) {
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