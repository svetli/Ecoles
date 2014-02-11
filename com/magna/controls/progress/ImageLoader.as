package com.magna.controls.progress {
	
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.controls.progress.ImageProgressDisplay;
	
	public class ImageLoader extends Sprite {
		
		// Public Properties:
		public var imageMask:MovieClip;
		
		// Private Properties:
        private var _currentImage:Loader;
        private var _pendingImage:Loader;
        private var _height:Number;
        private var _width:Number;
        private var _progressDisplay:ImageProgressDisplay;
        private var _pendingRequest:URLRequest;
        private static const DEFAULT_WIDTH:Number = 440;
        private static const DEFAULT_HEIGHT:Number = 120;
		
		// Initialization:
		public function ImageLoader()
		{
            this._width = DEFAULT_WIDTH;
            this._height = DEFAULT_HEIGHT;
            mask = this.imageMask;
		}
	
		// Public Methods:
        private function loadingComplete() : void
        {
            var rect:Rectangle;
			
            if (this._pendingImage != null)
            {
                this._pendingImage.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadImageProgress);
                this._pendingImage.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadImageComplete);
                this._pendingImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadImageError);
                this._pendingImage.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadImageError);
                addChild(this._pendingImage);
				
                rect = this._pendingImage.scrollRect.clone();
                TweenMax.to(
								rect, 
								0.4, 
								{
									ease:Expo.easeOut, 
									width:this._width, 
									onUpdate:function () : void
									{
										if (_pendingImage != null)
										{
											_pendingImage.scrollRect = rect;
										}
									},
									onComplete:function () : void
									{
										var _loc_1:* = _pendingRequest;
										_pendingRequest = null;
										if (_progressDisplay != null)
										{
											removeChild(_progressDisplay);
											_progressDisplay = null;
										}
										if (_currentImage != null)
										{
											removeChild(_currentImage);
											_currentImage = null;
										}
										_currentImage = _pendingImage;
										_pendingImage = null;
										if (_loc_1 != null)
										{
											loadImage(_loc_1);
										}
									}
								});
            }
        }
		
        private function updateProgress() : void
        {
            var p:* = this._pendingImage.contentLoaderInfo.bytesLoaded / this._pendingImage.contentLoaderInfo.bytesTotal;
            TweenMax.killTweensOf(this._progressDisplay);
            TweenMax.to(
							this._progressDisplay,
							0.25,
							{
								ease:Sine.easeOut, 
								width:p * this._width, 
								onComplete:function () : void
								{
									if (_progressDisplay != null)
									{
										if (_progressDisplay.width == _width)
										{
											loadingComplete();
										}
									}
								}
							});
        }
		
        public function loadImageProgress(param1:ProgressEvent) : void
        {
            this.updateProgress();
            return;
        }

        public function loadImageError(param1:ErrorEvent) : void
        {
            TweenMax.killTweensOf(this._progressDisplay);
            removeChild(this._progressDisplay);
            this._progressDisplay = null;
            this._pendingImage.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadImageProgress);
            this._pendingImage.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadImageComplete);
            this._pendingImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadImageError);
            this._pendingImage.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadImageError);
            this._pendingImage = null;
        }// end function

        public function loadImageComplete(param1:Event) : void
        {
            this.updateProgress();
        }// end function

        public function loadImage(param1:URLRequest) : void
        {
            if (this._pendingImage != null)
            {
                this._pendingRequest = param1;
            }
            else
            {
                this._pendingImage = new Loader();
                this._pendingImage.scrollRect = new Rectangle(0, 0, 0, this._height);
                this._pendingImage.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadImageProgress);
                this._pendingImage.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadImageComplete);
                this._pendingImage.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadImageError);
                this._pendingImage.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadImageError);
                this._pendingImage.load(param1);
                if (this._progressDisplay == null)
                {
                    this._progressDisplay = new ImageProgressDisplay();
                }// end if
                this._progressDisplay.width = 0;
                this._progressDisplay.height = this._height;
                addChild(this._progressDisplay);
            }// end else if
            return;
        }// end function

        public function load(param1:URLRequest) : void
        {
            this.loadImage(param1);
            return;
        }// end function		
		// Protected Methods:
	}
	
}