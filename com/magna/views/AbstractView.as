package com.magna.views
{
	/**
	 * Flash Imports
	 */
	 import flash.display.Sprite;
	 
	/**
	 * Framework Imports
	 */
	 import com.magna.views.IView;
	 import com.magna.transitions.AbstractTransition;
	 import com.magna.transitions.DebugPageIntroTransition;
	 import com.magna.transitions.DebugPageOutroTransition;
	 
	/**
	 * Abstract View
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class AbstractView extends Sprite implements IView
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function AbstractView()
		{
			
		}
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Page View Intro
		 * 
		 * @param	none
		 * @return	AbstractTransition
		 */
		 public function intro() : AbstractTransition
		 {
			var dt:AbstractTransition = new DebugPageIntroTransition(this);
			dt.start();
			return dt;
		 }
		 
		/**
		 * Page View Outro
		 * 
		 * @param	none
		 * @return	AbstractTransition
		 */		 
		 public function outro() : AbstractTransition
		 {
			mouseChildren = false;
			var dt:AbstractTransition = new DebugPageOutroTransition(this);
			dt.start();
			return dt;
		 }
		 
		/**
		 * Page View Destroy
		 * 
		 * @param	none
		 * @return	void
		 */		 
		 public function destroy() : void
		 {
			 
		 }
	}
}