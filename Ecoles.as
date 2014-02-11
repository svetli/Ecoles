package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import com.magna.controls.sounds.SWFSoundManager;
	import com.magna.loading.LoaderQueue;
	import com.magna.events.*;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.loader.*;
	import com.ecoles.views.background.*;
	import com.ecoles.views.header.*;
	import com.ecoles.controllers.*;
	
	
	public class Ecoles extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private static var _soundMgr:SWFSoundManager;
		
		private var _model:EcolesModel;
		private var _sectionProgress:Number;
		private var _libraryProgress:Number;
		private var _languageProgress:Number;
		private var _loader:MainLoader;
		private var _library:Array;
		private var _section:EcolesPageController;
		private var _overlay:EcolesOverlayController;
		private var _language:EcolesLanguageController;
		private var _swfAddressController:SWFAddressController;
		private var _background:BackgroundView;
		private var _headerMenu:HeaderMenuView;
		private var debugger:MonsterDebugger;
		
		// Initialization:
		public function Ecoles() {
			// Init Google
			
			// Init Debugger
			debugger = new MonsterDebugger(this);
			stage.align 	= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener( Event.RESIZE, _onStageResize );
			this._init();
		}
	
		// Public Methods:

		// Protected Methods:
		
		// Protected Methods:
		private function _onStageResize(e:Event = null) : void {
			//trace("stageResizeEvent");
		}
		
		private function _init() : void {
			
			// Rebuild Base Url's
			if(Capabilities.playerType != "External") {
				//EcolesConfig.BASE_URL	= "";
				//EcolesConfig.ASSETS_URL	= "assets/";
			} else {
				//EcolesConfig.BASE_URL	= "";
				//EcolesConfig.ASSETS_URL	= "assets/";
			}

			// Hide Context Menu
			var contextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			
			// Init Model
			this._model = new EcolesModel();
			this._model.addEventListener("changeSection", this._modelChangeSection);
			this._model.addEventListener("changeOverlay", this._modelChangeOverlay);
			
			// Init Loader
			this._sectionProgress = 0;
			this._libraryProgress = 0;
			this._loader = new MainLoader();
			this._loader.addEventListener(Event.COMPLETE, this._landingComplete);
			addChild(this._loader);
			
			// Load Library
			this._loadLibrary();
		}
		
		private function _modelChangeSection(e:Event) : void {
			if( e.isDefaultPrevented() ) {
				return;
			}
			
			if( _section.hasPage(_model.currentPage) ) {
				_section.viewPage(_model.currentPage);
				_swfAddressController.setValueByPage(_model.currentPage);
				
				if( _background != null ) {
					_background.viewBackground(_model.currentPage);
				}
			}
		}
		
		private function _modelChangeOverlay(e:Event) : void {
			
			if (e.isDefaultPrevented())
            {
                return;
            }
			
            if (_overlay.hasOverlay(_model.currentOverlay))
            {
                _overlay.viewOverlay(_model.currentOverlay);
            }
		}
		
		private function _landingComplete(e:Event) : void {
			// Remove Loader
			removeChild(this._loader);
			this._loader = null;
			
			// Add Background
			addChild(this._background);
			
			// Add Overlay Controller
			_overlay = new EcolesOverlayController(_model);
			addChild(_overlay);	
			
			// Attach Header Menu
			setTimeout( _headerMenu.intro, 500 );
			
			// Start Section
			this._section.mode = EcolesViewController.AUTO;
            setTimeout( this._section.view.intro, 2000 );
			
			// Init Sound Manager
			_soundMgr = new SWFSoundManager(loaderInfo.applicationDomain, this, true, false);
			_soundMgr.addSound( EcolesConfig.AMBIENT_SOUND, 1, EcolesConfig.AUDIO_PATH + EcolesConfig.AMBIENT_SOUND_FILE, true);
			_soundMgr.fadeUpAndPlay(EcolesConfig.AMBIENT_SOUND, 2.5, "linear", 0, 5000);
		}
		
		public static function get soundManager() : SWFSoundManager
		{
			return _soundMgr;
		}
		
		/**
		*	Initialize and loading Library
		*
		*/
		
		private function _loadLibrary() : void
		{
			// Initialize ...
			var toLib:Loader;
			_library = new Array();
			var toLoad:Array = new Array();
			//toLoad.push(EcolesConfig.BASE_URL + _model.language + "/library.swf");
			toLoad.push("library.swf");
			
			// Initialize Loader Queue
			var loaderQueue:LoaderQueue = new LoaderQueue();
			loaderQueue.addEventListener(ProgressEvent.PROGRESS, _loadLibraryProgress);
			loaderQueue.addEventListener(Event.COMPLETE, _loadLibraryComplete);
			loaderQueue.addEventListener(IOErrorEvent.IO_ERROR, _loadLibraryError);
			loaderQueue.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _loadLibraryError);
			
			// Load ...
			for(var i:Number=0; i<toLoad.length; i++)
			{
				toLib = loaderQueue.addLoader( new Loader() , new URLRequest(toLoad[i]) );
				_library.push(toLib);
			}
			
			loaderQueue.start();
		}
		
		private function _loadLibraryProgress(e:ProgressEvent):void
		{
			_libraryProgress = e.target.progress;
			_updateProgress();
		}
		
		private function _loadLibraryComplete(e:Event):void
		{
			MonsterDebugger.trace(this, "Loading Library Complete ...")
			_libraryProgress = 1;
			_loadLanguage();
			//_loadSection();
		}
		
		private function _loadLibraryError(e:ErrorEvent):void
		{
			trace("Loading Library Error ...");
		}
		
		/**
		*	Update Progress
		*
		*/
		private function _updateProgress():void
		{
			if( _loader != null )
			{
				_loader.progress = (_libraryProgress * 0.5) + (_sectionProgress * 0.5);
			}
		}
		
		private function _loadLanguage() : void
		{
			MonsterDebugger.trace(this, "Start Loading Language ...");
			_language = new EcolesLanguageController(_model);
			_language.addEventListener(ProgressEvent.PROGRESS, _loadLanguageProgress);
			_language.addEventListener(IOErrorEvent.IO_ERROR, _loadLanguageError);
			_language.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _loadLanguageError);
			_language.addEventListener(Event.COMPLETE, _loadLanguageComplete);
		}
		
		private function _loadLanguageProgress(e:ProgressEvent) : void
		{
			_languageProgress = e.target.progress;
			_updateProgress();
		}
		
		private function _loadLanguageError(e:ErrorEvent) : void
		{
			MonsterDebugger.trace(this, "Loading Language Error: " + e);
			trace("load language error: " + e);
		}
		
		private function _loadLanguageComplete(e:Event) : void
		{
			MonsterDebugger.trace(this, "Loading Language Complete ...");
			_loadSection();
		}
		
		/**
		*	Load section
		*
		*/
		private function _loadSection():void
		{
			MonsterDebugger.trace(this, "Start Loading Section ...");
			// Add SWFAddressController setup
			_swfAddressController = new SWFAddressController(this._model);
			
			// Add Section
			_section = new EcolesPageController( _model, EcolesViewController.MANUAL );
			_section.addEventListener( LoadEvent.PROGRESS		, _loadSectionProgress	);
			_section.addEventListener( LoadErrorEvent.ERROR		, _loadSectionError		);
			_section.addEventListener( ViewControllerEvent.READY, _loadSectionComplete	);
			addChild(_section);
		}
		
		/**
		*	Load section progress event
		*
		*/
		private function _loadSectionProgress(e:LoadEvent):void
		{
			_sectionProgress = e.progress;
			_updateProgress();
		}
		
		/**
		*	Load section error
		*/
		private function _loadSectionError(e:ErrorEvent):void
		{
			MonsterDebugger.trace(this, "Load Section Error: " + e);
			trace("LoadSectionError " + e.text);
			
			// Reset loader
			_sectionProgress = 0;
			_updateProgress();
			_model.errorMessage = e.text;
			
			// Set default homepage to HOME
		}
		
		/**
		*	Load section complete
		*/
		private function _loadSectionComplete(e:Event):void
		{
			MonsterDebugger.trace(this, "Load Section Complete ...");
			_sectionProgress = 1;
			_section.removeEventListener( LoadEvent.PROGRESS , 		 _loadSectionProgress );
			_section.removeEventListener( ViewControllerEvent.READY, _loadSectionComplete );
			
			_updateProgress();
			
			// Add Background
			
			this._background = new BackgroundView(this._model);
			
			// Add Header Menu
			_headerMenu = new HeaderMenuView(_model);
			_headerMenu.addEventListener( ChangeViewEvent.CHANGE_VIEW, _changeView);
			addChild(_headerMenu);
			
			_model.isFirstTime = false;
			_onStageResize();
		}	
		
		private function _changeView(e:ChangeViewEvent) : void
		{
			if ( _overlay.hasOverlay(e.view) )
			{
				_model.setOverlay( e.view, e.data);
			}
			else
			if ( _section.hasPage(e.view) )
			{
				_model.setPage( e.view, e.data );
			}
		}		
		
		override public function addChild(pChild:DisplayObject) : DisplayObject
		{
			var index:Number = 0;
			
			super.addChild(pChild);
			
			if( this._background != null && contains(this._background) )
			{
				setChildIndex(this._background, index++);
			}
			
			if( _section != null && contains(_section) )
			{
				setChildIndex(_section, index++);
			}
			
			if( _headerMenu != null && contains(_headerMenu) )
			{
				setChildIndex(_headerMenu, index++);
			}		
			
			if( pChild != _background &&
			    pChild != _section &&
				pChild != _overlay &&
				pChild != _loader &&
				pChild != _headerMenu )
			{
				setChildIndex(pChild, index++);
			}
			
			if( _overlay != null && contains(_overlay) )
			{
				setChildIndex(_overlay, index++);
			}
			
			if( _loader != null && contains(_loader) )
			{
				setChildIndex(_loader, index++);
			}			
			
			return pChild;			
		}
	}
	
}