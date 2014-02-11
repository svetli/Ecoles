package com.magna.events
{
	/**
	 * Flash Imports
	 */
	import flash.events.*;
	
	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class AlertEvent extends Event
	{
		//-------------------------
		//	Constants
		//-------------------------
		
		public static const ALERT:String = "com.magna.events.AlertEvent.ALERT";
		
		//-------------------------
		//	Variables
		//-------------------------
		
		public var alert:Object;
		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function AlertEvent(pType:String, pAlert:Object) : void
		{
			alert = pAlert;
			super(pType, bubbles, cancelable);
		}
	}
}