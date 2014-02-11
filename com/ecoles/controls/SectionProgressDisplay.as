/**
*	Section Progress Display
*
*	@package	com.ecoles.controls
*	@author		Svetli Nikolov
*/
package com.ecoles.controls
{
    import flash.display.*;
    import flash.events.*;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.controls.progress.IconProgressDisplay;
	
    public class SectionProgressDisplay extends Sprite
    {
        private var _fill:Shape;
        private var _isComplete:Boolean;
        private var _progress:Number;
        private var _afterIntroKill:Boolean;
        private var _progressDisplay:IconProgressDisplay;
        private var _isIntroComplete:Boolean;

        public function SectionProgressDisplay()
        {
            _fill = new Shape();
            _fill.graphics.beginFill(0, 0.65);
            _fill.graphics.drawRect(0, 0, 10, 10);
            _fill.graphics.endFill();
            addChild(_fill);
            _progress = 0;
            _progressDisplay = new IconProgressDisplay();
            addChild(_progressDisplay);
            addEventListener(Event.ADDED_TO_STAGE, 		addedToStageEvent);
            addEventListener(Event.REMOVED_FROM_STAGE,	removedFromStageEvent);
        }
		
        public function set progress(param1:Number) : void
        {
            var _loc_2:* = param1.toFixed(2);
            var _loc_3:* = parseFloat(_loc_2);
            
			if (_loc_3 != this._progress)
            {
                this._progress = _loc_3;
                this.updateProgress();
            }
            return;
        }
		
		public function get progress() : Number
		{
			return _progress;
		}
		
        public function outro() : void
        {
            if (!_isIntroComplete)
            {
                _afterIntroKill = true;
                return;
            }
			
            if (_progressDisplay.progress == 1)
            {
                this.doOutro();
            }
            else
            {
                TweenMax.killTweensOf(_progressDisplay, false);
                TweenMax.to(_progressDisplay, 1.2, {ease:Sine.easeOut, progress:1, onComplete:outro});
            }
        }		
		
        private function addedToStageEvent(e:Event) : void
        {
            stage.addEventListener(Event.RESIZE, stageResizeEvent);
            stageResizeEvent();
            _isIntroComplete = false;
            TweenMax.from(_fill, 0.5, {ease:Sine.easeOut, alpha:0});
            TweenMax.from(_progressDisplay, 0.5, {delay:0.5, alpha:0, scaleX:0.25, scaleY:0.25, ease:Expo.easeOut, onComplete:this.introComplete});
            TweenMax.to(_progressDisplay, 0.25, {delay:0.5, glowFilter:{color:0, alpha:1, blurX:15, blurY:15, strength:1, quality:2}});
        }		
		
        private function removedFromStageEvent(e:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, stageResizeEvent);
        }	
		
        private function stageResizeEvent(param1:Event = null) : void
        {
            if (_fill != null && _progressDisplay != null)
            {
                _fill.width = stage.stageWidth;
                _fill.height = stage.stageHeight;
                _progressDisplay.x = Math.round(stage.stageWidth * 0.5);
                _progressDisplay.y = Math.round(stage.stageHeight * 0.5);
            }
        }
		
        private function updateProgress() : void
        {
            if (_progressDisplay.alpha == 1 && !_isComplete)
            {
                TweenMax.killTweensOf(_progressDisplay, false);
                TweenMax.to(_progressDisplay, 1.2, {ease:Sine.easeOut, progress:_progress});
            }
        }
		
        private function doOutro() : void
        {
            if (!_isComplete)
            {
                _isComplete = true;
                
				TweenMax.killTweensOf(_progressDisplay);
				
                TweenMax.to(
								_progressDisplay, 
								0.75, 
								{
									alpha:0, 
									scaleX:0.25, 
									scaleY:0.25, 
									ease:Expo.easeIn, 
									onComplete:function () : void
									{
										removeChild(_progressDisplay);
    									_progressDisplay = null;
										return;
									}
								}
							);
				
                TweenMax.to(
								_fill, 
								0.5, 
								{
									delay:0.75, 
									ease:Sine.easeOut, 
									alpha:0, 
									visible:false, 
									onComplete:outroComplete
								}
							);
            }
        }
		
        private function introComplete() : void
        {
            _isIntroComplete = true;
            
			if (_afterIntroKill)
            {
                outro();
            }
            else
            {
                updateProgress();
            }
        }	
		
        private function outroComplete() : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }		
    }
}
