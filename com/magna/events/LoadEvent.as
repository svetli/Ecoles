package com.magna.events
{
	/**
	 * Flash Imports
	 */	
	import flash.events.*;
	
	/**
	 * Load Event
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */	
    public class LoadEvent extends Event
    {
		//-------------------------
		//	Constants
		//-------------------------
		
		/**
		 *	Events
		 */ 		
        public var progress:Number;
        public static var START:String 		= "com.magna.events.LoadEvent.START";
        public static var COMPLETE:String 	= "com.magna.events.LoadEvent.COMPLETE";
        public static var PROGRESS:String 	= "com.magna.events.LoadEvent.PROGRESS";

		//-------------------------
		//	Constructor
		//-------------------------		
		
        public function LoadEvent(pType:String, pProgress:Number = 0, pBubbles:Boolean = false, pCancelable:Boolean = false)
        {
            this.progress = pType == COMPLETE ? (1) : (pProgress);
            super(pType, pBubbles, pCancelable);
        }

		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * override Clone
		 * 
		 * @param	none
		 * @return	LoadEvent
		 */		
        override public function clone() : Event
        {
            return new LoadEvent(super.type, this.progress, super.bubbles, super.cancelable);
        }

		/**
		 * override toString
		 * 
		 * @param	none
		 * @return	String
		 */				
        override public function toString() : String
        {
            return formatToString("ViewControllerLoadEvent", "type", "progress", "bubbles", "cancelable");
        }
    }
}