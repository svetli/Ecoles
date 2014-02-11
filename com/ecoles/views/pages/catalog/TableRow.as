package com.ecoles.views.pages.catalog {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class TableRow extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		public var colA:TextField;
		public var colB:TextField;
		public var colC:TextField;
		public var colD:TextField;
		
		// Initialization:
		public function TableRow(a:String, b:String, c:String, d:String)
		{
			colA.htmlText = a;
			colB.htmlText = b;
			colC.htmlText = c;
			colD.htmlText = d;
		}
		// Public Methods:
		// Protected Methods:
	}
	
}