package com.magna.transitions
{
	/**
	 * Framework Imports
	 */
	import com.greensock.*;
	import com.greensock.data.*;
	import com.magna.transitions.AbstractTransition;
	import com.magna.views.AbstractView;
	 
	/**
	 * Page Intro Transition
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class DebugPageIntroTransition extends AbstractTransition
	{
		//-------------------------
		//	Variables
		//-------------------------
		private var _page:AbstractView;
		
		//-------------------------
		//	Constructor
		//-------------------------
		public function DebugPageIntroTransition(page:AbstractView)
		{
			this._page 		 = page;
			this._page.alpha = 0;
		}
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Start Transition
		 * 
		 * @param	none
		 * @return	void
		 */
		 override public function start() : void
		 {
			 var tMaxVars:TweenMaxVars;
			 tMaxVars 				= new TweenMaxVars();
			 tMaxVars.onComplete 	= super.complete;
			 tMaxVars.onUpdate 		= super.update;
			 tMaxVars.alpha 		= 1;
			 
			 this._page.alpha 		= 0;
			 this._page.visible 	= true;
			 
			 TweenMax.to( this._page, 0.5, tMaxVars );
		 }
	}
}