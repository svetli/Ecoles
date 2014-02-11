package com.magna.transitions
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
	
	// TweenMax
    import com.greensock.*;
    import com.greensock.plugins.*;
    
	// Papervision3D
	import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    import org.papervision3d.view.*;
	
	public class PV3DViewTransition extends AbstractTransition
	{
		private var _container:Sprite;
		private var _tweens:Dictionary;
		private var _view:BasicView;
		
		/**
		*	Class Contructor
		*	@param	target	Sprite
		*	@param	posX	Number
		*	@param	posY	Number
		*/
		
		public function PV3DViewTransition(target:Sprite, posX:Number, posY:Number)
		{
			// Init ...
			_container 	= target;
			_tweens 	= new Dictionary();
			
			var inPoint:Point = _container.globalToLocal( new Point(0,0) );
			TweenPlugin.activate([BezierThroughPlugin, BezierPlugin]);
			
			// Init View ...
			_view = new BasicView( posX, posY, false );
			_view.x = inPoint.x;
			_view.y = inPoint.y;
			_view.camera.focus = 100;
			_view.camera.zoom = 10;
			_view.singleRender();
			
			_container.addChild(_view);
		}
		
		/**
		*	Override
		*	AbstractTransition
		*/
        override public function start() : void
        {
            var tween:Object;
            var tweeningFunction:Function;
			
            for each ( tween in _tweens )
            {
                tween.source.visible = false;
                tweeningFunction = tween.tweeningFunction;
                tweeningFunction( tween.target, tween.time, tween.args );
            }
			
            TweenMax.to(this, 2, {onUpdate:update, onComplete:complete});
            super.start();
        }
		
		/**
		*	Override
		*	AbstractTransition
		*/		
        override public function update() : void
        {
            _view.singleRender();
            super.update();
        }
		
		/**
		*	Override
		*	AbstractTransition
		*/		
        override public function complete() : void
        {
            var tween:Object;
			
            for each ( tween in _tweens )
            {
                tween.source.visible = true;
                _view.scene.removeChild(tween.target);
            }
			
            _container.removeChild(_view);
            super.complete();
        }
		
		/**
		*	Add Tween To Render
		*	@param	tweenFunction	Function
		*	@param	target			DisplayObject
		*	@param	time			Number
		*	@param	args			Object
		*/
		public function addTween( tweenFunction:Function, 
								  target:DisplayObject, 
								  time:Number, 
								  args:Object,
								  objWidth:Number  = 0,
								  objHeight:Number = 0,
								  segmentsH:Number = 1,
								  align:String 	   = "center" ) : DisplayObject3D
		{
			var dObj:Object 		= new Object();
			dObj.tweeningFunction 	= tweenFunction;
			dObj.source 			= target;
			dObj.time 				= time;
			dObj.args				= args;
			dObj.target				= _getPlaneFromDO( target, objWidth, objHeight, segmentsH, align );
			
			_view.scene.addChild( dObj.target );
			_tweens[target] = dObj;
			
			return dObj.target;
		}
		
		/**
		*	Create Plane From Display Object
		*	@param	target		DisplayObject
		*	@param	objWidth	Object Width
		*	@param	objHeight	Object Height
		*	@param	segmentsH	Number of segments vertically
		*	@param	align		Alignment
		*/
		private function _getPlaneFromDO( target:DisplayObject, 
										  objWidth:Number,
										  objHeight:Number, 
										  segmentsH:Number,
										  align:String ) : DisplayObject3D
		{
			var dObj:DisplayObject3D;
			
			objWidth  = (objWidth  > 0) ? (objWidth)  : (target.width);
			objHeight = (objHeight > 0) ? (objHeight) : (target.height);
			
            var point:* = new Point();
            point.x = target.x + objWidth  * 0.5;
            point.y = target.y + objHeight * 0.5;
            point = _container.localToGlobal(point);
            point = _view.globalToLocal(point);
            point.x = point.x - _view.viewport.viewportWidth * 0.5;
            point.y = _view.viewport.viewportHeight * 0.5 - point.y;
			
            var movieMaterial:* = new MovieMaterial(target, true, true);
            movieMaterial.smooth = true;
            movieMaterial.doubleSided = true;
			
            var plane:* = new Plane( movieMaterial, objWidth, objHeight, 1, segmentsH);
			
            if (align != "center")
            {
                dObj 	= new DisplayObject3D();
                dObj.x 	= point.x - objWidth * 0.5;
                dObj.y 	= point.y;
                dObj.x 	= objWidth * 0.5;
                dObj.addChild(plane);
                return dObj;
            }
			
            plane.x = point.x;
            plane.y = point.y;
            return plane;			
		}
	}
}
