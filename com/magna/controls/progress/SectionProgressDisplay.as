package com.magna.controls.progress
{
	/**
	 * Flash Imports
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	
	/**
	 * Framework Imports
	 */
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.controls.progress.IconProgressDisplay;
	
	/**
	 * Project Imports
	 */	
	
	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class SectionProgressDisplay extends Sprite
	{
		//-------------------------
		//	Constants
		//-------------------------
		
		/**
		 * Constrants Description
		 */
		 
		//-------------------------
		//	Variables
		//-------------------------
		private var _fill:Shape;
		private var _isComplete:Boolean;
		private var _progress:Number;
		private var _afterIntroKill:Boolean;
		private var _progressDisplay:IconProgressDisplay;
		private var _isIntroComplete:Boolean;
		
		//-------------------------
		//	Getters & Setters
		//-------------------------
		
        public function set progress(p:Number) : void
        {
            var pFixed:* = p.toFixed(2);
            var pFloat:* = parseFloat(pFixed);
            if (pFloat != this._progress)
            {
                this._progress = pFloat;
                this.updateProgress();
            }
        }
		
        public function get progress() : Number
        {
            return this._progress;
        }		
		
		//-------------------------
		//	Constructor
		//-------------------------
        public function SectionProgressDisplay()
        {
            this._fill = new Shape();
            this._fill.graphics.beginFill(0, 0.65);
            this._fill.graphics.drawRect(0, 0, 10, 10);
            this._fill.graphics.endFill();
            addChild(this._fill);
			
            this._progress = 0;
            this._progressDisplay = new IconProgressDisplay();
            addChild(this._progressDisplay);
			
            addEventListener(Event.ADDED_TO_STAGE, 		this.addedToStageEvent);
            addEventListener(Event.REMOVED_FROM_STAGE, 	this.removedFromStageEvent);
        }
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Section Progress Outro Loader
		 * 
		 * @param	void
		 * @return	void
		 */
        public function outro() : void
        {
            if ( !this._isIntroComplete )
            {
                this._afterIntroKill = true;
                return;
            }
            if ( this._progressDisplay.progress == 1 )
            {
                this.doOutro();
            }
            else
            {
                TweenMax.killTweensOf(this._progressDisplay, false);
                TweenMax.to(this._progressDisplay, 1.2, {ease:Sine.easeOut, progress:1, onComplete:this.outro});
            }
        }
		 
		//-------------------------
		//	Protected methods
		//------------------------- 
		
		//-------------------------
		//	Private methods
		//-------------------------
		
		/**
		 * Added To Stage Event
		 * 
		 * @param	Event
		 * @return	void
		 */		
		private function addedToStageEvent(event:Event) : void
		{
            stage.addEventListener(Event.RESIZE, this.stageResizeEvent);
            this.stageResizeEvent();
            this._isIntroComplete = false;
            TweenMax.from(this._fill, 0.5, {ease:Sine.easeOut, alpha:0});
            TweenMax.from(this._progressDisplay, 0.5, {delay:0.5, alpha:0, scaleX:0.25, scaleY:0.25, ease:Expo.easeOut, onComplete:this.introComplete});
            TweenMax.to(this._progressDisplay, 0.25, {delay:0.5, glowFilter:{color:0, alpha:1, blurX:15, blurY:15, strength:1, quality:2}});			
		}
		
		/**
		 * Removed From Stage Event
		 * 
		 * @param	Event
		 * @return	void
		 */			
		private function removedFromStageEvent(event:Event) : void
		{
			stage.removeEventListener(Event.RESIZE, this.stageResizeEvent);
		}
		
		/**
		 * Resize Stage Event
		 * 
		 * @param	Event
		 * @return	void
		 */			
        private function stageResizeEvent(event:Event = null) : void
        {
            if (this._fill != null && this._progressDisplay != null)
            {
                this._fill.width = stage.stageWidth;
                this._fill.height = stage.stageHeight;
                this._progressDisplay.x = Math.round(stage.stageWidth * 0.5);
                this._progressDisplay.y = Math.round(stage.stageHeight * 0.5);
            }
        }
		
		/**
		 * On Intro Complete
		 * 
		 * @param	void
		 * @return	void
		 */			
        private function introComplete() : void
        {
            this._isIntroComplete = true;
			
            if (this._afterIntroKill)
            {
                this.outro();
            }
            else
            {
                this.updateProgress();
            }
        }
		
		/**
		 * On Outro Complete
		 * 
		 * @param	void
		 * @return	void
		 */	
        private function outroComplete() : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Remove Section Progress
		 * from Stage
		 * 
		 * @param	void
		 * @return	void
		 */			
        private function doOutro() : void
        {
            if ( !this._isComplete )
            {
                this._isComplete = true;
                
				TweenMax.killTweensOf(this._progressDisplay);
				
                TweenMax.to(
								this._progressDisplay, 
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
									}
            					}
							);
				
                TweenMax.to(
								this._fill, 
								0.5, 
								{
									delay:0.75, 
									ease:Sine.easeOut, 
									alpha:0, 
									visible:false, 
									onComplete:this.outroComplete
								}
							);
            }
        }
		
        private function updateProgress() : void
        {
            if (this._progressDisplay.alpha == 1 && !this._isComplete)
            {
                TweenMax.killTweensOf(this._progressDisplay, false);
                TweenMax.to(this._progressDisplay, 1.2, {ease:Sine.easeOut, progress:this._progress});
            }
        }		
	}
}