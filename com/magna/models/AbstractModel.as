package com.magna.models
{
	/**
	 * Flash Imports
	 */
	 import flash.display.*;
	 import flash.events.Event;
	 import flash.events.EventDispatcher;
	 
	/**
	 * Framework Imports
	 */
	 import com.magna.models.IModel;
	 import com.magna.views.OverlayViews;
	 import com.magna.models.LanguageModel;
	
	/**
	 * Abstract Magna Model
	 * 	Dispaching Events:
	 *		changeSection (setPage)
	 *		changeOverlay (setOverlay)
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class AbstractModel extends EventDispatcher implements IModel
	{		 
		//-------------------------
		//	Variables
		//-------------------------
		
		public var isFirstTime:Boolean;
		public var isBeta:Boolean;
		public var errorMessage:String;
		public var queryString:String;
		
		private var _currentPage:String;
		private var _previousPage:String;
		private var _pageData:Object;
		
		private var _currentOverlay:String;
		private var _previousOverlay:String;
		private var _overlayData:Object;
		
		private var _alert:Object;
		private var _language:LanguageModel;
		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function AbstractModel()
		{
			this.isFirstTime 	= true;
			this.isBeta 	 	= true;
			this.errorMessage 	= "";
			this.queryString	= "";
			this._language 		= new LanguageModel();
		}
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Set Page
		 * 
		 * @param	page:String		Page Identifier
		 * @param	pageData:Object	Page Data
		 * @return	void
		 */
		 public function setPage( page:String, pageData:Object = null ) : void
		 {
			 this._previousPage 	= this._currentPage;
			 this._currentPage 		= page;
			 this._pageData 		= pageData;
			 
			 dispatchEvent( new Event("changeSection", false, true) );
		 }
		 
		/**
		 * Set Overlay
		 * 
		 * @param	overlay:String		Overlay Identifier
		 * @param	overlayData:Object	Overlay Data
		 * @return	void
		 */		 
		 public function setOverlay( overlay:String, overlayData:Object = null ) : void
		 {
			this._previousOverlay = this._currentOverlay;
			this._currentOverlay  = overlay;
			this._overlayData	  = overlayData;
			
			dispatchEvent(new Event("changeOverlay", false, true));
		 }
		 
		//-------------------------
		//	Getters & Setters
		//-------------------------
		
		 public function get data() : Object
		 {
			return  this._pageData;
		 }

		 public function get pageData() : Object
		 {
			return this._pageData; 
		 }
		 
		 public function set pageData(data:Object) : void
		 {
			this._pageData = data; 
		 }
		 
		 public function get currentPage() : String
		 {
			return this._currentPage; 
		 }
		 
		 public function set overlayData(data:Object) : void
		 {
			this._overlayData = data; 
		 }
		 
		 public function get overlayData() : Object
		 {
			return this._overlayData; 
		 }
		 
		 public function get currentOverlay() : String
		 {
			return this._currentOverlay; 
		 }
		 
		 public function set language(lang:String) : void {
			this._language.lang = lang;
		 }
		 
		 public function get language() : String {
			return this._language.lang; 
		 }
		 
		 public function get langModel():LanguageModel
		 {
			return _language; 
		 }
		 
		 public function get alertObject() : Object
		 {
			return this._alert; 
		 }
		 
		 public function alert(pAlert:Object) : void
		 {
			this._alert = pAlert;
			this._currentOverlay = OverlayViews.ALERT;
			dispatchEvent( new Event("changeOverlay", false, true) );
		 }
	}
}