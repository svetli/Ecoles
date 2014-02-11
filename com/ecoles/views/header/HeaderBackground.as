package com.ecoles.views.header {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import caurina.transitions.*;
	import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    import org.papervision3d.view.*;	
	
	public class HeaderBackground extends Sprite {
		
		// Constants:
		public static const SEGMENT_HEIGHT:Number = 40;
		public static const EASING:String = "easeoutsine";
		public static const SEGMENT_WIDTH:Number = 100;
		public static const DELAY:Number = 0.05;
		public static const TIME:Number = 0.3;	
		
		// Public Properties:
		
		// Private Properties:
		private var _view:BasicView;
		private var _plane:Plane;
		private var _segments:Array;
		
		// Initialization:
		public function HeaderBackground()
		{
			addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
		}
	
		// Public Methods:
		public function intro() : void
		{
			var count:Number = 0;
			var totalSegments:Number = _segments.length;
			var i:Number = Math.round(totalSegments * 0.5);
			
			while ( i >= 0 )
			{
				count++;
				Tweener.addTween(_segments[i], {time:TIME, delay:count * DELAY, transition:EASING, rotationX:0, y:SEGMENT_HEIGHT * 0.5});
				i--;
			}
			
			var j:Number = Math.round(totalSegments * 0.5) + 1;
			
			while ( j < totalSegments )
			{
				count++;
				Tweener.addTween(this._segments[j], {time:TIME, delay:count * DELAY, transition:EASING, rotationX:0, y:SEGMENT_HEIGHT * 0.5});
				j++;
			}
			
			Tweener.addTween(this, {
							 			time:TIME + j * DELAY + i * DELAY, 
										onStart:function () : void
										{
											_view.startRendering();
										},
										onComplete:function () : void
										{
											_view.stopRendering();
										}
							});			
		}
		
		
		// Private Methods
		private function addedToStage(e:Event) : void
		{
			var plane:Plane;
			var obj3D:DisplayObject3D;
			var segments:* = Math.ceil(stage.stageWidth / SEGMENT_WIDTH) + 1;
			// initialize basic view
			_view = new BasicView(stage.stageWidth, SEGMENT_HEIGHT, false);
			_view.camera.focus = 100;
			_view.camera.zoom = 10;
			addChild(_view);
			
			// initialize segments
			_segments = new Array();
			var i:Number = 0;
			while ( i++ < segments )
			{
				plane 	= new Plane(new ColorMaterial(0x838383), SEGMENT_WIDTH, SEGMENT_HEIGHT, 1, 1);
				plane.y = (-SEGMENT_HEIGHT) * 0.5;
				obj3D	= new DisplayObject3D();
				obj3D.x	= (-stage.stageWidth) * 0.5 + i * SEGMENT_WIDTH;
				obj3D.y	= SEGMENT_HEIGHT;
				obj3D.rotationX = -90;
				obj3D.addChild( plane, "plane" );
				_segments.push(obj3D);
				_view.scene.addChild(obj3D);
			}			
		}
	}
	
}