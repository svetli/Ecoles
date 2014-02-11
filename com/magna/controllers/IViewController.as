package com.magna.controllers
{
	/**
	 * Flash Imports
	 */
	import flash.events.IEventDispatcher;
	
	/**
	 * Framework Imports
	 */
	import com.magna.views.AbstractView;
	
	/**
	 * Class Description
	 * 
	 * @author		Svetli Nikolov
	 * @version		1.0
	 */
	public interface IViewController extends IEventDispatcher
	{		
		//-------------------------
		//	Constructor
		//-------------------------
		
		public function IViewController();
		
		function init() : void;
		
		function get view() : AbstractView;
		
		function unload() : void;
	}
}