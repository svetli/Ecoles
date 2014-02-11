package com.ecoles.controllers
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import com.magna.controllers.IViewController;
	import com.magna.transitions.AbstractTransition;
	import com.magna.events.*;
	import com.magna.views.AbstractView;
	
	public class EcolesViewController extends Sprite
	{
		public static const AUTO:String 	= "auto";
		public static const MANUAL:String 	= "manual";
		
		private var _model:Object;
		private var _mode:String;
		private var _controllers:Dictionary;
		private var _pendingControllerID:String;
		private var _currentPageID:String;
		private var _currentPageController:IViewController;
		private var _currentTransition:AbstractTransition;
		private var _isClearing:Boolean;
		private var _isPaused:Boolean;
		
		
		public function EcolesViewController(pModel, pMode:String = "auto")
		{
			_model = pModel;
			_mode  = pMode;
			_controllers = new Dictionary();
			_pendingControllerID = "";
		}
		
        public function hasViewController(cName:String) : Boolean
        {
			var res:Boolean = false;
			
			if( _controllers[cName] != null )
			{
				res = true;
			}
			
			return res;
        }		
		
		public function register( cName:String, cClass:Class) : void
		{			
			_controllers[cName] = cClass;
		}
		
        public function get controllerName() : String
        {
            return _currentPageID;
        }		
		
		public function set mode( pMode:String ) : void
		{
			_mode = pMode;
		}
		
		public function get mode() : String
		{
			return _mode;
		}
		
		public function get view() : AbstractView
		{
			if( _currentPageController != null )
			{
				return _currentPageController.view;
			}
			
			return null;
		}
		
		public function destroy() : void
		{
            if (contains(_currentPageController.view))
            {
                removeChild(_currentPageController.view);
            }
			
            _currentPageController.unload();
            _currentPageController.removeEventListener(ViewControllerEvent.READY, _controllerReady);
            _currentPageController = null;
            _currentPageID = "";
            _pendingControllerID = "";
		}
		
        public function clear() : void
        {
            if (_currentPageController != null)
            {
                if (_pendingControllerID != "")
                {
                    _pendingControllerID = "";
                }
                else
                {
                    _currentPageID = "";
                    _pendingControllerID = "";
                    _isClearing = true;
                    _currentTransition = _currentPageController.view.outro();
                    _currentTransition.addEventListener(TransitionEvent.COMPLETE, _controllerOutroComplete);
                }
            }
        }		
		
		public function get controller() : IViewController
		{
			return _currentPageController;
		}
		
		public function viewView(page:String) : void
		{
			if( _pendingControllerID != "" || _isClearing )
			{
				_pendingControllerID = page;
			}
			else if( _currentPageController != null )
			{
				_currentTransition = _currentPageController.view.outro();
				_currentTransition.addEventListener( TransitionEvent.COMPLETE , _controllerOutroComplete );
				_pendingControllerID = page;
			}
			else
			{
				/**
				*	Add Listeners
				*		addEventListener(
				*			type:String, 
				*			listener:Function, 
				*			useCapture:Boolean = false, 
				*			priority:int = 0, 
				*			useWeakReference:Boolean = false
				*		);
				*/
				_currentPageID = page;
				_currentPageController = getControllerByID(page);
				_currentPageController.addEventListener( ViewControllerEvent.READY, _controllerReady, false, 1, true );
				_currentPageController.addEventListener( LoadEvent.COMPLETE,		_controllerEvent, false, 0, true );
				_currentPageController.addEventListener( LoadEvent.PROGRESS,		_controllerEvent, false, 0, true );
				_currentPageController.addEventListener( LoadEvent.START,			_controllerEvent, false, 0, true );
				_currentPageController.addEventListener( LoadErrorEvent.ERROR,		_controllerEvent, false, 0, true );
				_currentPageController.init();
				dispatchEvent( new Event(Event.CHANGE) );
			}
		}
		
		private function _controllerReady(e:Event) : void
		{
			addChild(_currentPageController.view);
			_currentPageController.removeEventListener( ViewControllerEvent.READY,	_controllerReady );
			_currentPageController.removeEventListener( LoadEvent.COMPLETE,			_controllerEvent );
			_currentPageController.removeEventListener( LoadEvent.PROGRESS,			_controllerEvent );
			_currentPageController.removeEventListener( LoadEvent.START,			_controllerEvent );
			_currentPageController.removeEventListener( LoadErrorEvent.ERROR,		_controllerEvent );
			
			if( _mode == AUTO )
			{
				_currentTransition = _currentPageController.view.intro();
			}
			
			_controllerEvent( e.clone() );
		}
		
		private function _controllerEvent(e:Event) : void
		{
			dispatchEvent( e.clone() );
		}
		
		private function getControllerByID(cName:String) : IViewController
		{
			var controllerClass:*;
			
			if( _controllers[cName] == null )
			{
				return null;
			}
			
			controllerClass = _controllers[cName];
			
			return new controllerClass(_model) as IViewController;
		}
		
		private function _controllerOutroComplete(e:Event=null) : void
		{
            var pendingID:* = _pendingControllerID;
            _isClearing = false;
			
            if ( _currentPageController != null )
            {
                if ( contains(_currentPageController.view) )
                {
                    removeChild( _currentPageController.view );
                }
				
                _currentPageController.unload();
                _currentPageController.removeEventListener(ViewControllerEvent.READY, _controllerReady);
                _currentPageController = null;
            }
			
            if (pendingID != "")
            {
                _pendingControllerID = "";
                viewView(pendingID);
            }
		}
	}
}