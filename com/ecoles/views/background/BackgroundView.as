package com.ecoles.views.background {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	import com.ecoles.models.EcolesModel;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import com.ecoles.views.background.SndSwitch;

	public class BackgroundView extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _model:EcolesModel;
		private var _currentMatte:*;
		// UI Elements:
		public var background:MovieClip;
		public var sndSwitch:SndSwitch;
		
		// Initialization:
		public function BackgroundView(pModel:EcolesModel)
		{
			this._model = pModel;
			background.mouseChildren = false;
			background.mouseEnabled	 = false;
			
			sndSwitch = new SndSwitch(pModel);
			addChild(sndSwitch);
			
			// Hide Mattes
			this._hideMatte();
			this._showMatte("matte1");
			
			// Add Listeners
			addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStage);
		}

		// Public Methods:
		public function viewBackground(page:String) : void
		{
			switch ( page )
			{
				case "home":
				{
					TweenMax.to( _currentMatte, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{ _showMatte("matte2"); }} );
					break;
				}
				case "catalog":
				{
					TweenMax.to( _currentMatte, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{ _showMatte("matte1"); }} );
					break;
				}
				case "gallery":
				{
					TweenMax.to( _currentMatte, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{ _showMatte("matte2"); }} );
					break;
				}
				case "clients":
				{
					TweenMax.to( _currentMatte, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{ _showMatte("matte1"); }} );
					break;
				}
				default:
				{
					TweenMax.to( _currentMatte, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{ _showMatte("matte2"); }} );
					break;
				}
			}
		}		

		// Private Methods:
		private function _hideMatte(matte:String = null)
		{
			for (var i:uint = 0; i < background.matteContainer.numChildren; i++)
			{
				if( background.matteContainer.getChildAt(i).name == matte )
				{
					background.matteContainer.getChildAt(i).visible = false;
				}
				else
				{
					background.matteContainer.getChildAt(i).visible = false;
				}
			}		
		}
		
		private function _showMatte(matte:String) : void
		{
			var m:*;
			for (var i:uint = 0; i < background.matteContainer.numChildren; i++)
			{
				if( background.matteContainer.getChildAt(i).name == matte )
				{
					m = background.matteContainer.getChildAt(i);
					m.alpha = 0;
					m.visible = true;
					TweenMax.to( 
									m, 
									2, 
									{
										ease:Sine.easeOut, 
										alpha:1
									}
								);
					
					_currentMatte = m;
				}
			}			
		}		
		
		private function addedToStage(e:Event) : void
		{
			var np:* = globalToLocal( new Point() );
			
			x = stage.stageWidth * 0.5 - background.width * 0.5;
			y = stage.stageHeight* 0.5 - background.height* 0.5;
			
			sndSwitch.x = stage.stageWidth * 0.5 - 430;
			sndSwitch.y = stage.stageHeight* 0.5 - 215;
			
			// Add Background Fill
			var fill:Sprite;
			fill = new Sprite();
			fill.x = np.x;
			fill.y = np.y;
			fill.graphics.beginFill(0);
			fill.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			fill.graphics.endFill();
			addChild(fill);
			TweenMax.to( fill, 2, {ease:Sine.easeOut, alpha:0, onComplete:function():void{removeChild(fill);fill=null;}} );
			
			// Add Credits Baloon
			
			stage.addEventListener(Event.RESIZE, this.resizeStage);
		}
		
		private function removedFromStage(e:Event) : void
		{
			stage.removeEventListener(Event.RESIZE, this.resizeStage);
		}
		
		private function resizeStage(e:Event) : void
		{
			x = stage.stageWidth * 0.5 - background.width * 0.5;
			y = stage.stageHeight* 0.5 - background.height* 0.5;
			
			var np:* = globalToLocal( new Point() );
		}
	}
	
}