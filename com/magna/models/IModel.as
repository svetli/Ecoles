package com.magna.models
{
	/**
	 * Flash Imports
	 */
	 import flash.events.IEventDispatcher;
	
	/**
	 * Magna Model Interface
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public interface IModel extends IEventDispatcher
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function IModel();
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Set Page
		 * 
		 * @param	page:String		Page Identyfier
		 * @param	pageData:Object	Page Data
		 * @return	void
		 */

		 function setPage( page:String, pageData:Object = null ) : void;
		 
		/**
		 * Set Overlay
		 * 
		 * @param	overlay:String		Overlay Identyfier
		 * @param	overlayData:Object	Overlay Data
		 * @return	void
		 */		 
		 
		 function setOverlay( overlay:String, overlayData:Object=null ) : void;
		 
		//-------------------------
		//	Getters & Setters
		//-------------------------		 
		 
		 function get data() : Object;
		 
		 function get pageData() : Object;
		 
		 function set pageData(data:Object) : void
		 
		 function get overlayData() : Object;
		 
		 function set overlayData(data:Object) : void;
		 
		 function get currentPage() : String;
		 
		 function get currentOverlay() : String;
	}
}