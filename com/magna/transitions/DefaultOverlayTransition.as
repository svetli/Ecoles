package com.magna.transitions {
	
	import flash.geom.*;
	import com.magna.views.overlays.AbstractOverlayView;
	import com.magna.transitions.AbstractTransition;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class DefaultOverlayTransition extends AbstractTransition
	{
        private var _direction:String;
        private var _overlay:AbstractOverlayView;
        public static const OUTRO:String = "outro";
        public static const INTRO:String = "intro";		
		
		public function DefaultOverlayTransition(overlay:AbstractOverlayView, dir:String)
		{
			_overlay 	= overlay;
			_direction 	= dir;
			_overlay.visible = false;
		}
		
        override public function start() : void
        {
            var _loc_3:Number;
            var _loc_1:* = _overlay.parent.globalToLocal(new Point(0, 0));
            _overlay.visible = true;
            _overlay.cacheAsBitmap = true;
            
			var _loc_2:* = _loc_1.clone();
            _loc_2.x = _loc_2.x + _overlay.stage.stageWidth * 0.5;
            _loc_2.y = _loc_2.y + _overlay.stage.stageHeight * 0.5;
            
			if (_direction == INTRO)
            {
                _loc_3 = Math.round(_loc_1.y - _overlay.height);
                _overlay.y = Math.round(_loc_2.y - _overlay.height * 0.5);
                TweenMax.from(_overlay, 1, {ease:Expo.easeOut, y:_loc_3, onComplete:completeEvent, onUpdate:super.update});
            }
            else
            {
                _loc_3 = Math.round(_loc_2.y - _overlay.height);
                TweenMax.to(this._overlay, 0.5, {ease:Quint.easeIn, y:_loc_3, onComplete:completeEvent, onUpdate:super.update});
            }
			
            super.start();
        }
		
        private function completeEvent() : void
        {
            _overlay.cacheAsBitmap = false;
            super.complete();
            return;
        }		
	}
	
}