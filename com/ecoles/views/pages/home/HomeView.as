package com.ecoles.views.pages.home {
	
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLRequest;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.transitions.AbstractTransition;
	import com.magna.controls.progress.ImageProgress;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.EcolesPageView;
	
	public class HomeView extends EcolesPageView {
		
		private var _model:EcolesModel;
		public var introHolder:MovieClip;
		public var homeImage:ImageProgress;
		
		// Initialization:
		public function HomeView() {
			visible = false;
		}

		// Public Methods:
		public function setHomeData(pData:XML) : void {
			introHolder.pageTitle.text = pData.title;
			introHolder.pageTitle.selectable = false;
			introHolder.pageTitle.autoSize = TextFieldAutoSize.RIGHT;
			introHolder.introText.autoSize = TextFieldAutoSize.LEFT;
			introHolder.introText.htmlText = pData.intro_text;
			introHolder.introText.selectable = false;
			homeImage.load(new URLRequest(EcolesConfig.ASSETS_URL + _model.language + "/home/images/" + pData.intro_image));
			homeImage.x = parseInt(pData.intro_image_x);
			homeImage.y = parseInt(pData.intro_image_y);
		}
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}
		
		override public function intro() : AbstractTransition {
			visible = true;
			var inT:AbstractTransition = new AbstractTransition();
			//TweenMax.to(this, 0.75, {ease:Expo.easeOut, alpha:1, blurFilter:{blurX:10, blurY:10}});
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