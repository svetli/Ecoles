package com.magna.events
{
	/**
	 * Flash Imports
	 */		
	import flash.events.*;
	
	/**
	 * Load Error Event
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */		
	public class LoadErrorEvent extends ErrorEvent
	{
		//-------------------------
		//	Constants
		//-------------------------
		
		/**
		 *	Events
		 */ 			
		public static var ERROR:String = "com.magna.events.LoadErrorEvent.ERROR";
		
		//-------------------------
		//	Constructor
		//-------------------------				
		
		public function LoadErrorEvent( mType:String, mText:String = "", mBubbles:Boolean = false, mCancelable:Boolean = false )
		{
			/** 
			*	ErrorEvent (
			*		type:String, 
			*		bubbles:Boolean = false, 
			*		cancelable:Boolean = false, 
			*		text:String = "", 
			*		id:int = 0
			*	);
			*/
			super(mType, mBubbles, mCancelable, mText);
		}
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * override Clone
		 * 
		 * @param	none
		 * @return	LoadErrorEvent
		 */			
		override public function clone() : Event
		{
			return new LoadErrorEvent(super.type, super.text, super.bubbles, super.cancelable);
		}
		
		/**
		 * override toString
		 * 
		 * @param	none
		 * @return	String
		 */					
		override public function toString() : String
		{
			return formatToString("LoadErrorEvent", "text", "type", "bubbles", "cancelable");
		}
	}
}