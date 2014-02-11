package com.ecoles.views.loader
{
    import flash.display.*;
    import flash.events.*;
    import com.greensock.*;
    import com.greensock.easing.*;

    public class MainLoaderView extends MovieClip
    {
        public var logo:MovieClip;
        private var _isLoaded:Boolean;
        private static const INTRO_COMPLETE_FRAME:String = "introComplete";
        private static const OUTRO_COMPLETE_FRAME:String = "outroComplete";
        private static const OUTRO_FRAME:String = "outro";
        private static const INTRO_FRAME:String = "intro";

        public function MainLoaderView()
        {
            var _loc_1:FrameLabel = null;
			
            for each (_loc_1 in currentLabels)
            {
                if (_loc_1.name == INTRO_FRAME)
                {
                    addFrameScript((_loc_1.frame - 1), this.introFrame);
                }
                if (_loc_1.name == INTRO_COMPLETE_FRAME)
                {
                    addFrameScript((_loc_1.frame - 1), this.introCompleteFrame);
                }
                if (_loc_1.name == OUTRO_FRAME)
                {
                    addFrameScript((_loc_1.frame - 1), this.outroFrame);
                }
                if (_loc_1.name == OUTRO_COMPLETE_FRAME)
                {
                    addFrameScript((_loc_1.frame - 1), this.outroCompleteFrame);
                }
            }
            return;
        }// end function

        private function introFrame() : void
        {
            TweenMax.to(this.logo, 0.7, {alpha:1, delay:0.15, ease:Cubic.easeOut});
            return;
        }// end function

        private function outroFrame() : void
        {
            TweenMax.to(this.logo, 0.35, {alpha:0, delay:1.15, ease:Quint.easeOut});
            dispatchEvent(new Event("outro"));
            return;
        }// end function

        private function outroCompleteFrame() : void
        {
            stop();
            dispatchEvent(new Event("outroComplete"));
            return;
        }// end function

        public function outro() : void
        {
            this._isLoaded = true;
            play();
            return;
        }// end function

        private function introCompleteFrame() : void
        {
            if (!this._isLoaded)
            {
                stop();
            }
            dispatchEvent(new Event("introComplete"));
            return;
        }// end function

    }
}
