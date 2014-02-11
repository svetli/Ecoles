package com.magna.events
{
	/**
	 * Flash Imports
	 */
	 import flash.events.Event;
	
	/**
	 * Transition Event
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class TransitionEvent extends Event
	{
		//-------------------------
		//	Constants
		//-------------------------
		
		/**
		 *	Events
		 */ 
        public static const UPDATE:String 			= "com.magna.events.TransitionEvent.UPDATE";
        public static const START:String 			= "com.magna.events.TransitionEvent.START";
        public static const COMPLETE:String 		= "com.magna.events.TransitionEvent.COMPLETE";
        public static const OUTRO_COMPELTE:String 	= "com.magna.events.TransitionEvent.OUTRO_COMPLETE";
        public static const INTRO_COMPLETE:String 	= "com.magna.events.TransitionEvent.INTRO_COMPLETE";
		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function TransitionEvent( pType:String, pBubbles:Boolean = false, pCancelable:Boolean = false )
		{
			super(pType, pBubbles, pCancelable);
		}		
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * override Clone
		 * 
		 * @param	none
		 * @return	TransitionEvent
		 */
		override public function clone() : Event
		{
			return new TransitionEvent( super.type, super.bubbles, super.cancelable );
		}
		
		/**
		 * override toString
		 * 
		 * @param	none
		 * @return	String
		 */		
		override public function toString() : String
		{
			return formatToString("TransitionEvent", "bubbles", "cancelable");
		}
	}
}