/**
*	Sound Manager
*
*	@package	com.magna.managers
*	@author		Svetli Nikolov
*/

package com.magna.managers
{
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.magna.IDescribable;
	
	public class SoundManager
	{
		private var _sounds:Object;
		
		private var _listeners:Dictionary;
		
		public static var sSoundManager:SoundManager;
		
		/**
		*	Class Constructor
		*	@access	public
		*/
		public function SoundManager()
		{
			init();
		}
		
		/**
		*	Initialize class
		*	@return	void
		*/
		private function init():void
		{
			_sounds = {};
			_listeners = new Dictionary();
		}
		/**
		*	Singleton Pattern
		*	@return	SoundManager
		*/
		public static function getInstance():SoundManager
		{
			if(sSoundManager == null)
			{
				sSoundManager = new SoundManager();
			}
			
			return sSoundManager;
		}
		
		/**
		*	IOError Handler
		*	@param	pEvent	IOErrorEvent
		*	@return	void
		*/
		private function onIOError(pEvent:IOErrorEvent):void
		{
			trace("error loading sound");
		}
		
		/**
		*	Register new sound
		*	@param	string	sound name
		*	@param 	string	path to sound
		*	@return	void
		*/
		public function addSound( pSoundName:String, pSoundPath:String ):void
		{
			_sounds[ pSoundName ] = pSoundPath;
		}
		
		/**
		*	Loading new sound
		*	@param	object	sound id
		*	@param	string	sound name
		*	@param	string	event
		*	@param 	string	volume
		*	@return	void
		*/
		public function registerForSound( pID:Object, pSoundName:String, pEvent:String, pVolume:Number=1):void
		{
			var pSound:Sound = new Sound();
			var pPath:String = _sounds[pSoundName] + ".mp3";
			try {
				pSound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				pSound.load(new URLRequest(pPath));
				
				if(_listeners[pID] == null)
				{
					_listeners[pID] = {};
				}
				
				_listeners[pID][pEvent] = new SoundObject(pSound, pVolume);
			} 
			catch(e:Error)
			{
				trace("ERROR");
			}
		}
		
		/**
		*	Play sound
		*	@param	SoundObject	Sound to play
		*	@return	void
		*/
		private function play(pSoundObject:SoundObject):void
		{
			Sound(pSoundObject.sound).play(0, 0, new SoundTransform(Number(pSoundObject.volume)));
		}
		
		public function playSound(pObject:IDescribable, pEvent:String):void
		{
			var pListener:Object = _listeners[pObject];
			var pSoundObject:SoundObject;
			
			if(pListener != null)
			{
				pSoundObject = pListener[pEvent] as SoundObject;
				
				if(pSoundObject != null)
				{
					play(pSoundObject);
					return;
				}
			}
			
			var pClasses:Array = pObject.getClassHierarchy();
			
			for(var i:int = pClasses.length-1; i > -1; i--)
			{
				pListener = _listeners[pClasses[i]];
				
				if(pListener != null)
				{
					pSoundObject = pListener[pEvent] as SoundObject;
					
					if(pSoundObject != null)
					{
						play(pSoundObject);
						return;
					}
				}
			}
		}
	}
}