package com.magna.validate
{
	public class AValidate implements IValidate
	{
		protected var _message:String;
		protected var _value:String;
		
		/**
		* Returns validation failure message
		*
		* @return String
		*/
		public function get message() : String
		{
			return _message;
		}
		
		public function isValid(value) : Boolean
		{
			return true;
		}
		
		/**
		* Sets the value to be validated and clears the messages and errors arrays
		*
		* @param  mixed $value
		* @return void
		*/
		protected function _setValue(value) : void
		{
			_value    = value;
			_message  = "";
		}		
	}
}