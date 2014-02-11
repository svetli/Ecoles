package com.magna.controls.progress {
	
	import flash.display.Shape;
	
	public class CGIProgressDisplay extends Shape {
		
		// Constants:
		// Public Properties:
		private var pWidth:Number  = 120;
		private var pHeight:Number = 90;
		// Private Properties:
	
		// Initialization:
		public function CGIProgressDisplay() { }
	
		// Public Methods:
		public function setSize(w:Number,h:Number) : void
		{
			pWidth  = w;
			pHeight = h;
		}
		
		public function init() : void
		{
			graphics.beginFill(0, 0.25);
			graphics.drawRect(0,0, pWidth, pHeight);
			graphics.endFill();
		}
		
		// Protected Methods:
	}
	
}