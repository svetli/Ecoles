package com.magna.events
{
	/**
	 * Flash Imports
	 */
	import flash.events.Event;

	/**
	 * Change View Event
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class ChangeViewEvent extends Event
	{
		//-------------------------
		//	Constants
		//-------------------------
		
		public static const OVERLAY:String 		= "overlay";
		public static const CHANGE_VIEW:String	= "com.magna.events.ChangeViewEvent.CHANGE_VIEW";
		public static const EXTERNAL:String		= "external";
		public static const PAGE:String			= "internal";
		
		//-------------------------
		//	Variables
		//-------------------------
		
		public var view:String;
		public var data:Object;

		//-------------------------
		//	Constructor
		//-------------------------
		
		public function ChangeViewEvent( pType:String, pView:String, pData:Object = null, pBubbles:Boolean = false, pCancelable:Boolean = false )
		{
			this.view = pView;
			this.data = pData;
			super(pType, pBubbles, pCancelable);
		}		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * override Clone
		 * 
		 * @param	none
		 * @return	ChangeViewEvent
		 */
		override public function clone() : Event
		{
			return new ChangeViewEvent( super.type, view, data, super.bubbles, super.cancelable );
		}
		
		/**
		 * override toString
		 * 
		 * @param	none
		 * @return	String
		 */
		override public function toString() : String
		{
			return formatToString("ChangeViewEvent", "view", "data", "type");
		}		 
	}
}