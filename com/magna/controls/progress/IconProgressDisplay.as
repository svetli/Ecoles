package com.magna.controls.progress
{
	/**
	 * Flash Imports
	 */
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	/**
	 * Framework Imports
	 */
	import com.magna.controls.progress.IProgressDisplay;
	
	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class IconProgressDisplay extends Sprite implements IProgressDisplay
	{		 
		//-------------------------
		//	Variables
		//-------------------------
		
		public var progressAnimation:MovieClip;
		
		private var _progress:Number;
		
		//-------------------------
		//	Constructor
		//-------------------------
        public function IconProgressDisplay()
        {
            this.progressAnimation.stop();
            this._progress = 0;
        }
		
		//-------------------------
		//	Getters & Setters
		//-------------------------
		
        public function get progress() : Number
        {
            return this._progress;
        }
		
        public function set progress(pProgress:Number) : void
        {
            var currentProgress:Number;
			
            if (!isNaN(pProgress) && isFinite(pProgress))
            {
                this._progress = pProgress;
                
				currentProgress = Math.max(1, Math.min(this.progressAnimation.totalFrames, Math.round(this._progress * this.progressAnimation.totalFrames)));
                
				if (currentProgress > 0 && this.progressAnimation.currentFrame != currentProgress)
                {
                    this.progressAnimation.gotoAndStop(currentProgress);
                }
            }
        }
	}
}