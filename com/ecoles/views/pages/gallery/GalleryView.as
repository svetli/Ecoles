package com.ecoles.views.pages.gallery {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import com.magna.transitions.AbstractTransition;
	import com.magna.controls.progress.ImageProgress;

	import com.ecoles.vo.ImageVO;
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.EcolesPageView;
	import com.ecoles.views.pages.gallery.controls.ImagesGrid;

	public class GalleryView extends EcolesPageView {
		
		// Constants:
		// Public Properties:
		public var pageTitle:TextField;
		// Private Properties:
		private var _model:EcolesModel;
		private var _grid:ImagesGrid;
		// Initialization:
		public function GalleryView()
		{
			visible		= false;
			tabChildren = false;
			
			_grid = new ImagesGrid();
			_grid.x = 20;
			_grid.y = 80;
			_grid.addEventListener(Event.CHANGE, _gridChangeEvent);
			_grid.addEventListener(Event.SELECT, _gridSelectEvent);
			addChild(_grid);
		}
		
		// Public Methods:
		public function setGalleryData(pData:XML) : void {
			pageTitle.text = pData.title;
			pageTitle.selectable = false;
			pageTitle.autoSize = TextFieldAutoSize.RIGHT;		
		}
		
		public function setImagesData(images:Array) : void
		{
			_grid.model = _model;
			_grid.setItems(images);
		}
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}
		
		private function _gridChangeEvent(e:Event) : void
		{
			trace("change event");
		}
		
		private function _gridSelectEvent(e:Event) : void
		{
			trace("select overlay");
			//showOverlay(PierlucciOverlayViews.SHOP_IMAGE, {url:_grid.selectedItem.path});
		}		

		override public function intro() : AbstractTransition {
			visible = true;
			var inT:AbstractTransition = new AbstractTransition();
			//TweenMax.to(this, 0.75, {ease:Expo.easeOut, alpha:1,onComplete:introComplete});
			_grid.startLoading();
			return super.intro();
		}
		
		override public function outro() : AbstractTransition {
			var outT:AbstractTransition = new AbstractTransition();
			//TweenMax.to(this, 0.75, {ease:Expo.easeOut, alpha:0, blurFilter:{blurX:10, blurY:10, onComplete:outT.complete}});
			return super.outro();
		}
		
		override protected function stageResizeEvent(e:Event = null) : void {
			super.stageResizeEvent(e);
		}
		
		private function introComplete() {
			_grid.startLoading();
		}
	}
	
}