package com.magna.controllers
{
	/**
	 * Framework Imports
	 */
	import com.magna.controllers.IViewController;

	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public interface IPageViewController extends IViewController
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function IPageViewController();
	
		/**
		 * Get Page Title
		 * 
		 * @param	none
		 * @return	String	Page Title
		 */
		function get title() : String;
	}
}