package com.magna.controls.progress {
	
	import flash.display.Shape;
	
	public class ImageProgressDisplay extends Shape
	{
		// Initialization:
		public function ImageProgressDisplay()
		{
			graphics.beginFill(0, 0.5);
			graphics.drawRect(0, 0, 1, 1);
			graphics.endFill();
		}
	}
	
}