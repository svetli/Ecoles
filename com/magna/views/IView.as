package com.magna.views
{
	/**
	 * Flash Imports
	 */
	 import com.magna.transitions.AbstractTransition;
	 
	/**
	 * Page View Interface
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public interface IView
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function IView();
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Page View Intro
		 * 
		 * @param	none
		 * @return	AbstractTransition
		 */
		 function intro() : AbstractTransition;
		 
		/**
		 * Page View Outro
		 * 
		 * @param	none
		 * @return	AbstractTransition
		 */		 
		 function outro() : AbstractTransition;
		 
		/**
		 * Page View Destroy
		 * 
		 * @param	none
		 * @return	void
		 */		 
		 function destroy() : void;
	}
}