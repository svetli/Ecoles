package com.magna.events
{
	/**
	 * Flash Imports
	 */	
    import flash.events.*;

	/**
	 * View Controller Event
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */	
    public class ViewControllerEvent extends Event
    {
		//-------------------------
		//	Constants
		//-------------------------
		
		/**
		 *	Events
		 */ 		
        public static var READY:String = "com.magna.events.ViewControllerEvent.READY";

		//-------------------------
		//	Constructor
		//-------------------------		
		
        public function ViewControllerEvent(pType:String, pBubbles:Boolean = false, pCancelable:Boolean = false)
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
		 * @return	ViewControllerEvent
		 */		
        override public function clone() : Event
        {
            return new ViewControllerEvent(super.type, super.bubbles, super.cancelable);
        }
		
		/**
		 * override toString
		 * 
		 * @param	none
		 * @return	String
		 */			
        override public function toString() : String
        {
            return formatToString("ViewControllerEvent", "type", "bubbles", "cancelable");
        }


    }
}