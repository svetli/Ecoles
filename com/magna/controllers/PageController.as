package com.magna.controllers
{
	/**
	 * Flash Imports
	 */
	 import flash.display.Sprite;
	 import flash.events.Event;
	/**
	 * Framework Imports
	 */
	 import com.magna.controllers.IController;
	 import com.magna.controllers.IViewController;
	 import com.magna.controllers.IPageViewController;
	 import com.magna.controllers.ViewController;
	 import com.magna.models.AbstractModel;
	 import com.magna.views.AbstractView;
	 import com.magna.events.LoadEvent;
	 import com.magna.events.LoadErrorEvent;
	 import com.magna.events.ViewControllerEvent;
	 import com.magna.events.ChangeViewEvent;
	 import com.magna.events.AlertEvent;
	 import com.magna.controls.progress.SectionProgressDisplay;
	/**
	 * Project Imports
	 */	
	
	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class PageController extends Sprite implements IController
	{		 
		//-------------------------
		//	Variables
		//-------------------------
		private var _viewController:ViewController;
		protected var model:AbstractModel;
		private var _isPreloading:Boolean;
		private var _pendingPage:String;
		private var _preloader:SectionProgressDisplay;
		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function PageController(pModel:AbstractModel, pMode:String = "auto")
		{
			this.model = pModel;
			
			this._viewController = new ViewController(pModel, pMode);
			this._viewController.addEventListener(LoadEvent.COMPLETE, 		this.controllerLoadComplete);
			this._viewController.addEventListener(LoadEvent.PROGRESS, 		this.controllerLoadProgress);
			this._viewController.addEventListener(LoadEvent.START,			this.controllerLoadStart);
			this._viewController.addEventListener(LoadErrorEvent.ERROR,		this.controllerLoadError);
			this._viewController.addEventListener(ViewControllerEvent.READY,this.controllerLoadReady);
			
			addChild(this._viewController);
		}
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * View Page
		 * 
		 * @param	String		Page Id
		 * @return	void
		 */
		public function viewPage(page:String) : void
		{
			if( this._viewController.view != null )
			{
				this._viewController.view.mouseEnabled = false;
				this._viewController.view.mouseChildren = false;
			}
			
			this._viewController.viewView(page);
		}
		 
		/**
		 * Have a page controller?
		 * 
		 * @param	String		Page Id
		 * @return	Boolean
		 */
		public function hasPage(page:String) : Boolean
		{
			return this._viewController.hasViewController(page);
		}
		
		//-------------------------
		//	Getters & Setters
		//-------------------------
		
		public function set mode(pMode:String) : void
		{
			this._viewController.mode = pMode;
		}
		
		public function get mode() :  String
		{
			return this._viewController.mode;
		}
		
		public function get view() : AbstractView
		{
			return this._viewController.view;
		}
		
		//-------------------------
		//	Private methods
		//-------------------------
		
		/**
		 * Load Controller Complete
		 * 
		 * @param	LoadEvent
		 * @return	void
		 */		
		private function controllerLoadComplete(event:LoadEvent) : void
		{
			if ( this._isPreloading )
			{
				this._preloader.outro();
			}
			else
			{
				dispatchEvent(event);
			}
		}
		
		/**
		 * Load Controller Progress
		 * 
		 * @param	LoadEvent
		 * @return	void
		 */		
		private function controllerLoadProgress(event:LoadEvent) : void
		{
			if ( this._isPreloading )
			{
				this._preloader.progress = event.progress;
			}
			
			dispatchEvent(event);
		}
		
		/**
		 * Load Controller Start
		 * 
		 * @param	LoadEvent
		 * @return	void
		 */		
		private function controllerLoadStart(event:LoadEvent) : void
		{
			if ( this._viewController.mode == ViewController.AUTO )
			{
                this._isPreloading = true;
                this._viewController.mode = ViewController.MANUAL;
                this._preloader = new SectionProgressDisplay();
                this._preloader.addEventListener(Event.COMPLETE, this.preloaderCompleteEvent);
                this._preloader.progress = event.progress;
                stage.addChild(this._preloader);
			}
			
			dispatchEvent(event);
		}
		
		/**
		 * Load Controller Error
		 * 
		 * @param	LoadErrorEvent
		 * @return	void
		 */			
		private function controllerLoadError(event:LoadErrorEvent) : void
		{
			dispatchEvent(event);
		}
		
		/**
		 * Load Controller Ready
		 * 
		 * @param	ViewControllerEvent
		 * @return	void
		 */				
		private function controllerLoadReady(event:ViewControllerEvent) : void
		{
			if ( this._isPreloading )
			{
				this._preloader.outro();
			}
			else
			{
				var pView:IPageViewController;
				pView = this._viewController.controller as IPageViewController;
				pView.addEventListener(ChangeViewEvent.OVERLAY, 	this.controllerChangeViewEvent, false, 0, true);
				pView.addEventListener(ChangeViewEvent.PAGE, 		this.controllerChangeViewEvent, false, 0, true);
				pView.addEventListener(ChangeViewEvent.CHANGE_VIEW, this.controllerChangeViewEvent, false, 0, true);
				pView.addEventListener(AlertEvent.ALERT, 			this.controllerAlertEvent, 		false, 0, true);
				
				//Browser.setTitle( this.model.getConfig("SITE_NAME") + pView.title.toUpperCase());

				dispatchEvent(event);
			}
		}

		/**
		 * Load Controller Change View Event
		 * 
		 * @param	ChangeViewEvent
		 * @return	void
		 */
		private function controllerChangeViewEvent(event:ChangeViewEvent) : void
		{
			if ( event.type == ChangeViewEvent.OVERLAY )
			{
				this.model.setOverlay(event.view, event.data);
			}
			else
			{
				this.model.setPage(event.view, event.data);
			}
		}
		
		/**
		 * Load Controller Alert Event
		 * 
		 * @param	AlertEvent
		 * @return	void
		 */		
		private function controllerAlertEvent(event:AlertEvent) : void
		{
			this.model.alert(event.alert);
		}
		
		/**
		 * Preloader Complete Event
		 * 
		 * @param	Event
		 * @return	void
		 */			
        private function preloaderCompleteEvent(event:Event) : void
        {
            stage.removeChild(this._preloader);
            this._preloader = null;
            this._isPreloading = false;
            this._viewController.mode = ViewController.AUTO;
            dispatchEvent(new LoadEvent(LoadEvent.COMPLETE, 1));
            this.controllerLoadReady(new ViewControllerEvent(ViewControllerEvent.READY));
            this._viewController.view.intro();
        }
	}
}