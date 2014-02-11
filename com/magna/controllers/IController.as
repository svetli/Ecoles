package com.magna.controllers
{
	/**
	 * Flash Imports
	 */
	 import flash.events.IEventDispatcher;

	/**
	 * Framework Imports
	 */	 
	 import com.magna.views.AbstractView;
	 
	/**
	 * Page Controller Interface
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public interface IController extends IEventDispatcher
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function IController();
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Set View Controller Mode
		 *		
		 * @param	pMode:String	Auto or Manual
		 * @return	void
		 */
		 function set mode(pMode:String) : void;
		 
		/**
		 * Get View Controller Mode
		 *		
		 * @param	none
		 * @return	String	Auto or Manual
		 */		 
		 function get mode() : String
		 
		/**
		 * Get View Controller
		 *		
		 * @param	none
		 * @return	AbstractView
		 */				 
		 function get view() : AbstractView;
		 
		/**
		 * Check page exists
		 *		
		 * @param	String	Page Identifier
		 * @return	Boolean
		 */			 
		 function hasPage(pPage:String) : Boolean;
		 
		/**
		 * Display Page by Id
		 *		
		 * @param	String	Page Identifier
		 * @return	void
		 */			 
		 function viewPage(pPage:String) : void;
	}
}