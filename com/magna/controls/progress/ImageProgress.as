package com.magna.controls.progress {

	import flash.events.*;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	import com.greensock.*;
	import com.greensock.easing.*;

	import com.magna.controls.progress.ImageProgressDisplay;
	
	public class ImageProgress extends Sprite {
		
		// Constants:
		public static const DEFAULT_WIDTH:Number 	= 250;
		public static const DEFAULT_HEIGHT:Number 	= 360;
		
		// UI Components
		public var imageMask:MovieClip;
		
		// Private Properties:
		private var currentImage:Loader;
		private var pendingImage:Loader;
		private var pendingRequest:URLRequest;
		private var progressDisplay:ImageProgressDisplay;
		
		private var w:Number;
		private var h:Number;
		
		// Initialization:
		public function ImageProgress()
		{
			w = DEFAULT_WIDTH;
			h = DEFAULT_HEIGHT;
			mask = imageMask;
		}
	
		// Public Methods:
		public function load(url:URLRequest) : void
		{
			loadImage(url);
		}
		
		public function loadImage(url:URLRequest) : void
		{
			if(pendingImage != null)
			{
				pendingRequest = url;
			}
			else
			{
				// Init Pending Image
				pendingImage = new Loader();
				pendingImage.scrollRect = new Rectangle(0, 0, 0, h);
				pendingImage.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 			loadImageProgress);
				pendingImage.contentLoaderInfo.addEventListener(Event.COMPLETE, 					loadImageComplete);
				pendingImage.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 				loadImageError);
				pendingImage.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,	loadImageError);
				pendingImage.load(url);
				
				// Init Progress Display
				if( progressDisplay == null )
				{
					progressDisplay = new ImageProgressDisplay();
				}
				
				progressDisplay.width = 0;
				progressDisplay.height = h;
				
				addChild(progressDisplay);
			}
		}
		
		// Protected Methods:
        private function updateProgress() : void
        {
            var p:* = pendingImage.contentLoaderInfo.bytesLoaded / pendingImage.contentLoaderInfo.bytesTotal;
            
			TweenMax.killTweensOf( progressDisplay );
            
			TweenMax.to(
							progressDisplay, 
							0.25, 
							{
								ease:Sine.easeOut, 
								width:p * w, 
								onComplete: function () : void
								{
									if ( progressDisplay != null )
									{
										if ( progressDisplay.width == w )
										{
											loadingComplete();
										}
									}
								}
							}
						);
        }
		
        public function loadImageProgress(e:ProgressEvent) : void
        {
            updateProgress();
        }
		
        public function loadImageComplete(e:Event) : void
        {
            updateProgress();
        }
		
        private function loadingComplete() : void
        {
            if ( pendingImage != null )
            {
                pendingImage.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, 				loadImageProgress);
                pendingImage.contentLoaderInfo.removeEventListener(Event.COMPLETE, 						loadImageComplete);
                pendingImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, 				loadImageError);
                pendingImage.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, 	loadImageError);
                addChild(pendingImage);
				
				var rect:Rectangle;
                rect = pendingImage.scrollRect.clone();
				
                TweenMax.to(
								rect, 
								0.4, 
								{
									ease:Expo.easeOut, 
									width:w,
									onUpdate: function () : void
									{
										if ( pendingImage != null )
										{
											pendingImage.scrollRect = rect;
										}
									},
									onComplete: function () : void
									{
										var pr:* = pendingRequest;
										
										pendingRequest = null;
										
										if ( progressDisplay != null )
										{
											removeChild(progressDisplay);
											progressDisplay = null;
										}
										
										if (currentImage != null)
										{
											removeChild(currentImage);
											currentImage = null;
										}
										
										currentImage = pendingImage;
										pendingImage = null;
										
										if (pr != null)
										{
											loadImage(pr);
										}
									}
								}
							);
				// end TweenMax.to
            }
		}
		
        private function loadImageError(e:ErrorEvent) : void
        {
			trace("ErrorImageLoading: "+e);
			// Remove Progress Display
            TweenMax.killTweensOf(progressDisplay);
            removeChild(progressDisplay);
			progressDisplay = null;
            
			// Remove Pending Image
			pendingImage.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,				loadImageProgress);
            pendingImage.contentLoaderInfo.removeEventListener(Event.COMPLETE,						loadImageComplete);
            pendingImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, 				loadImageError);
            pendingImage.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,	loadImageError);
            pendingImage = null;
        }		
	}
}