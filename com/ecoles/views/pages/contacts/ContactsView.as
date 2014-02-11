package com.ecoles.views.pages.contacts {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import com.magna.transitions.AbstractTransition;
	import com.magna.controls.progress.ImageProgress;

	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.EcolesPageView;
	import com.ecoles.views.pages.contacts.controls.ContactForm;
	
	public class ContactsView extends EcolesPageView {
		
		// Constants:
		// Public Properties:
		public var pageTitle:TextField;
		public var infoText:TextField;
		// Private Properties:
		private var _model:EcolesModel;
		private var _form:ContactForm;
		
		// Initialization:
		public function ContactsView()
		{
			visible		= false;
			tabChildren = false;
		}

		// Public Methods:
		public function setHomeData(pData:XML) : void {
			pageTitle.text = pData.title;
			pageTitle.selectable = false;
			pageTitle.autoSize = TextFieldAutoSize.RIGHT;
			infoText.htmlText = pData.info;
			infoText.selectable = false;
			infoText.autoSize = TextFieldAutoSize.RIGHT;
			_form		= new ContactForm(_model);
			_form.x		= 40;
			_form.y		= 80;			
			_form.setXMLData(pData);
			_form.initializeForm();
			addChild(_form);
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