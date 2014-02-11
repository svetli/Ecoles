/**
*	Magna Library: Button Group
*
*	@package	com.magna.controls.buttons
*	@author		Svetli Nikolov
*/
package com.magna.controls.buttons
{
	import flash.events.*;
	import flash.utils.*;
	
	import com.magna.controls.buttons.IButton;
	import com.magna.controls.buttons.BaseButton;
	
	public class ButtonGroup extends EventDispatcher
	{
		private var _buttons:Dictionary;
		private var _buttonIDS:Dictionary;
		private var _selectedButton:BaseButton;
		private var _isEnabled:Boolean;		
		
		public function ButtonGroup()
		{
			_buttons 	= new Dictionary(true);
			_buttonIDS 	= new Dictionary(true);
		}
		
		public function get buttons() : Array
		{
			var b:IButton;
			var a:Array = new Array();
			
			for each ( b in _buttons )
			{
				a.push(b);
			}
			
			return a;
		}
		
		public function set buttons(a:Array) : void
		{
			var b:BaseButton;
			
			for each ( b in a )
			{
				addButton(b);
			}
		}
		
		public function set enabled(s:Boolean) : void
		{
			var b:BaseButton;
			
			_isEnabled = s;
			
			for each ( b in _buttons )
			{
				if( b != _selectedButton )
				{
					b.enabled = s;
				}
			}
		}
		
		public function get enabled() : Boolean
		{
			return _isEnabled;
		}
		
		public function set selectedButton(b:BaseButton) : void
		{
			if ( b == null && _selectedButton != null )
			{
				_selectedButton.selected = false;
				_selectedButton.enabled	 = true;
				_selectedButton = null;
			}
			
			if ( _buttons[b] != null )
			{
				_buttons[b].selected = true;
			}
		}
		
		public function get selectedButton() : BaseButton
		{
			return _selectedButton;
		}
		
		public function getButtonByID(id) : BaseButton
		{
			return _buttonIDS[id];
		}
		
		public function removeButtonByID(id) : BaseButton
		{
			if ( _buttonIDS[id] )
			{
				return removeButton( _buttonIDS[id] );
			}
			
			return null;
		}
		
		public function addButton( button:BaseButton, index = null ) : BaseButton
		{
			button.addEventListener( Event.SELECT, selectButtonEvent, false, 0, true );
			_buttons[button] = button;
			
			if( index != null )
			{
				_buttonIDS[index] = button;
			}
			
			return button;
		}
		
		public function removeButton( button:BaseButton ) : BaseButton
		{
			button.removeEventListener( Event.SELECT, selectButtonEvent );
			delete _buttons[button];
			return button;
		}
		
		private function selectButtonEvent(e:Event) : void
		{
			var b:BaseButton;
			
			_selectedButton = e.target as BaseButton;
			
			for each ( b in _buttons )
			{
				b.selected 	= _selectedButton == b;
				b.enabled	= _selectedButton != b;
			}
			
			dispatchEvent(new Event(Event.SELECT));
		}
	}
}