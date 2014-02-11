package com.magna.utils
{
	/**
	 * Flash Imports
	 */
	 import flash.system.*;
	
	/**
	 * Framework Imports
	 */
	 import com.google.analytics.*;
	 import nl.demonsters.debugger.*;
	
	/**
	 * Google Analytics Helper
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public class GoogleAnalytics extends Object
	{		 
		//-------------------------
		//	Variables
		//-------------------------
		
		/**
		 * Google Analytics Tracker
		 */
		 public static var tracker:GATracker;
		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function GoogleAnalytics()
		{
			
		}
		
		//-------------------------
		//	Public methods
		//-------------------------

		/**
		 * Track Page
		 * 
		 * @param	String	pageURL
		 * @return	void
		 */
		 public static function trackPage(pageURL:String) : void
		 {
			 if( tracker == null || Capabilities.playerType == "External" )
			 {
				 MonsterDebugger.trace("GoogleAnalytics:trackPage", pageURL);
			 }
			 else
			 {
				tracker.trackPageview(pageURL); 
			 }
		 }

		/**
		 * Track Event
		 * 
		 * @param	category:String
		 *			action:String
		 *			label:String = null
		 *			value:Number
		 * @return	void
		 */
		 public static function trackEvent(category:String, action:String = "", label:String = null, value:Number = 0) : void
		 {
			 if( tracker == null || Capabilities.playerType == "External" )
			 {
				 MonsterDebugger.trace("GoogleAnalytics:trackEvent", category + ", " + action + ", " + label);
			 }
			 else
			 {
				tracker.trackEvent(category, action, label, value); 
			 }
		 }
	}
}