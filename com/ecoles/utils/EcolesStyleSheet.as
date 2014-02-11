package com.ecoles.utils {
	
	import flash.text.StyleSheet;
	
	public class EcolesStyleSheet extends StyleSheet {
		
		// Constants:
		public var CSS:String;
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function EcolesStyleSheet()
		{
			CSS = <![CDATA[
						a:link   { color: #DEC91C; }
						a:hover  { color: #FFE400; }
						a:active { color: #DEC91C; }
					]]>;
			
			parseCSS(CSS);
		}
	
		// Public Methods:
		// Protected Methods:
	}
	
}