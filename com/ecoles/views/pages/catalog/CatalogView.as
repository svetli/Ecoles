package com.ecoles.views.pages.catalog {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import com.magna.transitions.AbstractTransition;
	import com.magna.controls.progress.ImageLoader;

	import com.ecoles.vo.ImageVO;
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.EcolesPageView;
	
	public class CatalogView extends EcolesPageView {
		
		// Constants:
		// Public Properties:
		public var pageTitle:TextField;
		public var container:ContentContainer;
		public var imageLoader:ImageLoader;
		
		// Private Properties:
		private var _model:EcolesModel;
		// UI Elements:

		
		// Initialization:
		public function CatalogView(pModel:EcolesModel)
		{
			visible = false;
			_model = pModel;
			container._model = pModel;
			container.imageLoader = imageLoader;
		}
		
		public function init(pData:XML) : void 
		{
			pageTitle.text = pData.title;
			pageTitle.selectable = false;			
			container.init(pData);
		}
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}
		
		override public function intro() : AbstractTransition {
			visible = true;
			var inT:AbstractTransition = new AbstractTransition();
			//TweenMax.to(this, 0.75, {ease:Expo.easeOut, alpha:1,onComplete:introComplete});
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
	}
	
}