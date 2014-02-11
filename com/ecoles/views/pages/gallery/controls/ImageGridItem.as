package com.ecoles.views.pages.gallery.controls {
	
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
	import flash.text.TextField;
	
	import com.magna.controls.buttons.*;
	import com.magna.controls.progress.CGIProgressDisplay;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.vo.ImageVO;

    import com.greensock.*;
    import com.greensock.easing.*;
	
	public class ImageGridItem extends Sprite {
		
		// Constants:
        public static const ITEM_WIDTH:Number = 125;
        public static const ITEM_HEIGHT:Number = 89;		
		
		// Public Properties:
		public var loaderMask:MovieClip;
		public var border:MovieClip;
		public var image:Loader;
		public var prevItem:ImageGridItem;	
		public var label:TextField;
		
		// Private Properties:
		private var path:String;
		private var rect:Rectangle;
		private var progressDisplay:CGIProgressDisplay;
		private var _stopLoad:Boolean;		
		private var _model:EcolesModel;
		
		// Initialization:
		public function ImageGridItem(cItem:ImageVO,pItem:ImageGridItem)
		{
			buttonMode = true;
			tabEnabled = false;
			path = cItem.image;
			label.text = cItem.title;
			border.alpha = 0;
			rect = new Rectangle(0, 0, 0, ITEM_HEIGHT);

			// Set up progress display
            progressDisplay 		= new CGIProgressDisplay();
			progressDisplay.setSize(ITEM_WIDTH, ITEM_HEIGHT);
			progressDisplay.init();
            progressDisplay.width 	= 0;
            progressDisplay.mask 	= loaderMask;
			addChild(progressDisplay);
			
			if( pItem != null )
			{
				pItem.addEventListener(Event.COMPLETE, load, false, 0, true);
				prevItem = pItem;
			}
			
			addEventListener(MouseEvent.CLICK, _clickEvent);			
		}
	
		// Public Methods:
        public function startLoad() : void
        {
            _stopLoad = false;
        }
		
        public function stopLoad() : void
        {
            _stopLoad = true;
        }			
		
		public function load(e:Event = null) : void
		{
			if( image != null )
			{
				dispatchEvent(new Event(Event.COMPLETE));
			} 
			else if ( !_stopLoad )
			{
				image = new Loader();
				image.scrollRect = new Rectangle(0, 0, 0, ITEM_HEIGHT);
				image.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _loadImageProgress);
				image.contentLoaderInfo.addEventListener(Event.COMPLETE, _loadImageComplete);
				image.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _loadImageError);
				image.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _loadImageError);
				image.load( new URLRequest(EcolesConfig.ASSETS_URL +_model.language + "/gallery/thumbs/" + path));
				addChildAt(image,0);
			}
		}		
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}
		
		private function _clickEvent(e:MouseEvent) : void
		{
			dispatchEvent(new Event(Event.SELECT));
		}
		
        private function updateProgressComplete() : void
        {
            if (progressDisplay == null)
            {
                return;
            }
			
            if (progressDisplay.width == ITEM_WIDTH)
            {
                TweenMax.killTweensOf(progressDisplay);
                TweenMax.to(
								rect, 
								0.6, 
								{
									ease:Expo.easeOut, 
									width:ITEM_WIDTH, 
									onStart: function () : void
									{
										dispatchEvent(new Event(Event.COMPLETE));
									},
									onUpdate: function () : void
									{
										if (image != null)
										{
											image.scrollRect = rect.clone();
										}
										progressDisplay.x 	  = rect.width;
										progressDisplay.width = ITEM_WIDTH - progressDisplay.x;
									},
									onComplete: function () : void
									{
										removeChild(progressDisplay);
										progressDisplay = null;
										TweenMax.to(border, 0.4, {ease:Sine.easeOut, alpha:1});
									}
								}
							);
            }
        }
		
        private function _loadImageProgress(e:ProgressEvent) : void
        {
            var p:* = e.bytesLoaded / e.bytesTotal * ITEM_WIDTH;
			
            if (progressDisplay != null && e.bytesLoaded > 0)
            {
                TweenMax.killTweensOf(progressDisplay, false);
                TweenMax.to(progressDisplay, 0.6, {ease:Expo.easeOut, width:p, onComplete:updateProgressComplete});
            }
        }

        private function _loadImageError(e:ErrorEvent) : void
        {
			image.load(new URLRequest(EcolesConfig.ASSETS_URL + _model.language +"/gallery/thumbs/default.png"));
            dispatchEvent(new Event(Event.COMPLETE));
        }
		
        private function _loadImageComplete(e:Event) : void
        {
            image.x = ITEM_WIDTH * 0.5 - image.content.width * 0.5;
            image.y = ITEM_HEIGHT * 0.5 - image.content.height * 0.5;
            image.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _loadImageProgress);
            image.contentLoaderInfo.removeEventListener(Event.COMPLETE, _loadImageComplete);
            image.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _loadImageError);
            image.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _loadImageError);
        }		
		
	}
}
