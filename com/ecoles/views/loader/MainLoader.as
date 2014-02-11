package com.ecoles.views.loader {
	
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    
	import com.greensock.*;
    import com.greensock.easing.*;
    import com.greensock.plugins.*;
	
	import com.magna.controls.progress.*;
	import com.magna.events.*;
	import com.ecoles.views.loader.MainLoaderView;
	import com.ecoles.controls.MainLoaderProgressDisplay;
	import com.ecoles.*;
	
    public class MainLoader extends Sprite implements IProgressDisplay
    {
        private var _preloaderProgress:Number;
        private var _progress:Number;
        private var _introAnimation:MainLoaderView;
        private var _progressBar:MainLoaderProgressDisplay;
        private var _isIntroComplete:Boolean;
        public static const DEFAULT_WIDTH:Number = 900;
        public static const DEFAULT_HEIGHT:Number = 600;

        public function MainLoader() {
            TweenPlugin.activate([BlurFilterPlugin]);
            this._progressBar = new MainLoaderProgressDisplay();
            this._progressBar.x = 450;
            this._progressBar.y = 361;
            addChild(this._progressBar);
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStage);
        }

        private function loadError(event:ErrorEvent) : void {
			trace("LOAD ERROR: " + event);
        }

        private function introComplete(event:Event) : void
        {
            TweenMax.to(this._progressBar, 1.5, {ease:Cubic.easeOut, progress:this._progress, onComplete:function () : void
            {
                _isIntroComplete = true;
                updateProgress(_progress);
                return;
            }// end function
            });
            return;
        }// end function

        private function outro(event:Event) : void
        {
            TweenMax.to(this._progressBar, 0.6, {width:1, delay:0, ease:Expo.easeOut});
            TweenMax.to(this._progressBar, 0.6, {alpha:0, delay:0, ease:Cubic.easeOut});
            return;
        }// end function

        private function stageResize(event:Event = null) : void
        {
            var _loc_2:* = new Point(0, 0);
            x = Math.round(stage.stageWidth * 0.5 - DEFAULT_WIDTH * 0.5);
            y = Math.round(stage.stageHeight * 0.5 - DEFAULT_HEIGHT * 0.5);
            _loc_2 = globalToLocal(_loc_2);
            graphics.clear();
            graphics.beginFill(0, 1);
            graphics.drawRect(_loc_2.x, _loc_2.y, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
            return;
        }// end function

        private function updateProgress(param1:Number) : void
        {
            var value:* = param1;
            this._progress = value;
            if (this._isIntroComplete)
            {
                TweenMax.to(this._progressBar, 1, {ease:Cubic.easeOut, progress:this._progress, onComplete:function () : void
            {
                if (_progress == 1 && _introAnimation != null)
                {
                    _introAnimation.outro();
                }
                return;
            }// end function
            });
            }
            return;
        }// end function

        public function set progress(param1:Number) : void
        {
            this.updateProgress(param1);
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            graphics.beginFill(0, 1);
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
            stage.addEventListener(Event.RESIZE, this.stageResize);
            this.stageResize();
            this._progressBar.scaleX = 0;
            TweenMax.to(this._progressBar, 0.5, {ease:Expo.easeOut, delay:2, scaleX:1, onComplete:this.load});
            return;
        }// end function

        private function outroComplete(event:Event) : void
        {
            setTimeout(dispatchEvent, 1000, new Event(Event.COMPLETE));
            return;
        }// end function

        private function load() : void
        {
            var _loc_3:* = new Loader();
            _loc_3.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadProgress);
            _loc_3.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadComplete);
            _loc_3.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            _loc_3.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadError);
            _loc_3.load(new URLRequest("ecoles_loader_logo.swf"));
            addChild(_loc_3);
            return;
        }// end function

        private function loadProgress(event:ProgressEvent) : void
        {
            this._preloaderProgress = event.bytesLoaded / event.bytesTotal;
            return;
        }// end function

        public function get progress() : Number
        {
            return this._progressBar.progress;
        }// end function

        private function removedFromStage(event:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, this.stageResize);
            return;
        }// end function

        private function loadComplete(event:Event) : void
        {
            this._introAnimation = event.target.content as MainLoaderView;
            this._introAnimation.addEventListener("introComplete", this.introComplete);
            this._introAnimation.addEventListener("outro", this.outro);
            this._introAnimation.addEventListener("outroComplete", this.outroComplete);
            return;
        }// end function

    }
	
}