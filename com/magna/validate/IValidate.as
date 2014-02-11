package com.magna.validate
{
	public interface IValidate
	{
		public function IValidate();
		
		/**
		* Returns true if and only if $value meets the validation requirements
		*
		* If $value fails validation, then this method returns false, and
		* get message() will return an message that explain why the
		* validation failed.
		*
		* @param  mixed $value
		* @return Boolean
		*/
		function isValid(value) : Boolean;
		
		/**
		* Returns an message that explain why the most recent isValid()
		* call returned false.
		*
		* If isValid() was never called or if the most recent isValid() call
		* returned true, then this method returns an empty string.
		*
		* @return String
		*/
		function get message() : String;
	}
}