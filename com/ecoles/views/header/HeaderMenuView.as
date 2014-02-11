package com.ecoles.views.header {
	
	import flash.display.*;
	import flash.events.*;
	
	import caurina.transitions.*;
	
	import com.magna.events.ChangeViewEvent;
	import com.magna.controls.buttons.ButtonGroup;
	import com.magna.controls.buttons.BaseButton;
	import com.magna.controls.buttons.EGGButton;
	
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.EcolesPageViews;
	import com.ecoles.views.pages.EcolesPageView;
	import com.ecoles.views.header.HeaderBackground;
	
	public class HeaderMenuView extends Sprite 
	{
		
		// Constants:
		public static const MARGIN_TOP:Number = 198;
		public static const MARGIN_LEFT:Number = 20;
		public static const BUTTON_WIDTH:Number = 140;
		
		// Public Properties:
		
		// Private Properties:
		private var _model:EcolesModel;
		private var _mainButtonsGroup:ButtonGroup;
		private var _headerBackground:HeaderBackground;
		
		// UI Elements:
		public var companyButton:EGGButton;
		public var productsButton:EGGButton;
		public var galleryButton:EGGButton;
		public var clientsButton:EGGButton;
		public var contactsButton:EGGButton;
		public var background:MovieClip;
	
		// Initialization:
		public function HeaderMenuView(pModel:EcolesModel)
		{
			this.background.visible = false;
			
			// Initialize Model
			this._model = pModel;
			this._model.addEventListener("changeSection", this.modelChangeSection);
			this._model.addEventListener("changeOverlay", this.modelChangeOverlay);
			
			// Initialize Buttons
			this._mainButtonsGroup = new ButtonGroup();
			this._mainButtonsGroup.addButton(this.companyButton, EcolesPageViews.HOME);
			this._mainButtonsGroup.addButton(this.productsButton,EcolesPageViews.CATALOG);
			this._mainButtonsGroup.addButton(this.galleryButton, EcolesPageViews.GALLERY);
			this._mainButtonsGroup.addButton(this.clientsButton, EcolesPageViews.CLIENTS);
			this._mainButtonsGroup.addButton(this.contactsButton,EcolesPageViews.CONTACTS);
			
			var b:BaseButton;
			for each ( b in this._mainButtonsGroup.buttons )
			{
				b.alpha = 0;
				b.bLabel.text = _model.langModel[b.name.substring(-1,7)].toUpperCase();
				b.addEventListener(MouseEvent.CLICK, this.onMainButtonsClick);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStage);
		}

		// Public Methods:
		public function intro() : void
		{
			var page:String;
			var bt:DisplayObject;
			
			if( this._model.currentPage == EcolesPageViews.CATALOG_ITEM ) {
				page = EcolesPageViews.CATALOG; 
			} else {
				page = this._model.currentPage;
			}
			
			var selectedButton:* = this._mainButtonsGroup.getButtonByID(page);
			if( selectedButton != null ) {
				selectedButton.selected = true;
			}
			
			var buttons:Array = new Array();
			var itButtons:Number = 0;
			buttons.push(
						 this.companyButton, 
						 this.productsButton, 
						 this.galleryButton, 
						 this.clientsButton, 
						 this.contactsButton);
			
			var sh:Number = ( (stage.stageWidth * 0.5) - (EcolesPageView.DEFAULT_WIDTH * 0.5) ) + MARGIN_LEFT;
			
			while(itButtons < buttons.length)
			{
				bt = buttons[itButtons];
				bt.alpha = 0;
				bt.x = sh + (itButtons * BUTTON_WIDTH);
				Tweener.addTween(
								 bt,
								 {
									 time:0.5, 
									 delay:1 + itButtons * 0.08, 
									 transition:"easeoutsine", 
									 alpha:1, 
									 onStart:function():void
									 {
										 _headerBackground.visible = false; 
										 background.visible = true;
									 }
								 }
								 );
				itButtons++;
			}
			
			// Setup Background
			this._headerBackground = new HeaderBackground();
			addChildAt(this._headerBackground, 0);
			this._headerBackground.intro();
		}
		
		public function set enabled(gStatus:Boolean) : void 
		{
			this._mainButtonsGroup.enabled = gStatus;
		}
		
		public function get enabled() : Boolean
		{
			return this._mainButtonsGroup.enabled;
		}
		
		// Private Methods:
		private function addedToStage(e:Event) : void
		{
			stage.addEventListener(Event.RESIZE, this.onStageResize);
			this.onStageResize();
		}
		
		private function removedFromStage(e:Event) : void
		{
			stage.removeEventListener(Event.RESIZE, this.onStageResize);
		}
		
		private function onStageResize(e:Event = null) : void
		{
			y = (stage.stageHeight/2) + MARGIN_TOP;
			background.width = stage.stageWidth;
			_resizeButtons();
		}
		
		private function _resizeButtons()
		{
			var sh:Number = ( (stage.stageWidth * 0.5) - (EcolesPageView.DEFAULT_WIDTH * 0.5) ) + MARGIN_LEFT;
			var b:BaseButton;
			var it:Number = 0;
			for each ( b in this._mainButtonsGroup.buttons )
			{
				b.x = sh + (it * BUTTON_WIDTH);				
				it++;
			}			
		}
		
		private function onMainButtonsClick(e:MouseEvent) : void
		{
			var changeView:String;

			switch( e.target )
			{
				case companyButton:
				{
					changeView = EcolesPageViews.HOME;
					break;
				}
				case productsButton:
				{
					changeView = EcolesPageViews.CATALOG;
					break;
				}
				case galleryButton:
				{
					changeView = EcolesPageViews.GALLERY;
					break;
				}
				case clientsButton:
				{
					changeView = EcolesPageViews.CLIENTS;
					break;
				}
				case contactsButton:
				{
					changeView = EcolesPageViews.CONTACTS;
					break;
				}
				default:
				{
					break;
				}
			}
				
			if( changeView != "" )
			{
				dispatchEvent(new ChangeViewEvent(ChangeViewEvent.CHANGE_VIEW, changeView));
			}
		}
			
		private function modelChangeSection(e:Event) : void
		{
			var page:String;
			
			if( e.isDefaultPrevented() ) {
				return;
			}

			if( this._model.currentPage == EcolesPageViews.CATALOG_ITEM ) {
				page = EcolesPageViews.CATALOG;
			} else {
				page = this._model.currentPage;
			}
			
			var b:BaseButton = this._mainButtonsGroup.getButtonByID(page);
			
			if( b != null ) {
				b.selected = true;
			}
		}
		
		private function modelChangeOverlay(e:Event) : void {
			return;
		}
	}
}