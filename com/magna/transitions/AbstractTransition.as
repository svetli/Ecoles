package com.magna.transitions
{
	/**
	 * Flash Imports
	 */
	 import flash.events.EventDispatcher;
	 
	/**
	 * Framework Imports
	 */
	 import com.magna.events.TransitionEvent;
	 
	/**
	 * Abstract Transition
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class AbstractTransition extends EventDispatcher
	{
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function AbstractTransition()
		{
			
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
		 public function start() : void
		 {
			 dispatchEvent(new TransitionEvent(TransitionEvent.START));
		 }
		 
		/**
		 * Update Transition
		 * 
		 * @param	none
		 * @return	void
		 */
		 public function update() : void
		 {
			 dispatchEvent(new TransitionEvent(TransitionEvent.UPDATE));
		 }		 
		 
		/**
		 * Complete Transition
		 * 
		 * @param	none
		 * @return	void
		 */
		 public function complete() : void
		 {
			 dispatchEvent(new TransitionEvent(TransitionEvent.COMPLETE));
		 }
	}
}