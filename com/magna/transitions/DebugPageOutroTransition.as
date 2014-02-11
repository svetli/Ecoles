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
	public class DebugPageOutroTransition extends AbstractTransition
	{
		//-------------------------
		//	Variables
		//-------------------------
		private var _page:AbstractView;
		
		//-------------------------
		//	Constructor
		//-------------------------
		public function DebugPageOutroTransition(page:AbstractView)
		{
			this._page 		 = page;
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
			 tMaxVars.blurFilter 	= new BlurFilterVars(0, 0);
			 
			 if( this._page.width < 900 )
			 {
				 tMaxVars.alpha = 0;
			 }
			 
			 TweenMax.to( this._page, 0.5, tMaxVars );
		 }
	}
}