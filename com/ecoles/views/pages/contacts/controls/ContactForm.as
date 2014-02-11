package com.ecoles.views.pages.contacts.controls {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.*;
	import flash.net.URLLoader;
	
	import com.magna.controls.buttons.BaseButton;
	import com.magna.controls.textinputs.InputTextField;
	import com.magna.validate.VEmail;
	
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.contacts.controls.ContactsFormErrors;
	import com.ecoles.views.pages.contacts.alerts.ContactsFormAlert;
	import com.ecoles.services.requests.ContactRequest;
	import com.ecoles.services.results.ContactResult;
	
	public class ContactForm extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var _model:EcolesModel;
		private var _data:XML;
		
		// UI Elements:
		public var lastName:InputTextField;
		public var firstName:InputTextField;
		public var phone:InputTextField;
		public var email:InputTextField;
		public var message:InputTextField;
		public var status_txt:TextField;
		public var submitButton:BaseButton;
		
		// Initialization:
		public function ContactForm(pModel:EcolesModel) {
			_model = pModel;
		}

		public function setXMLData(pData:XML) : void
		{
			_data = pData;
		}

		public function initializeForm() : void 
		{
			firstName.label 			= _data.firstName;
			firstName.maxChars			= 50;
			firstName.displayUpperCase	= true;
			firstName.restrict			= "a-zA-Z";
			firstName.tabIndex			= 1;
			
			lastName.label				= _data.lastName;
			lastName.maxChars			= 50;
			lastName.displayUpperCase	= true;
			lastName.restrict			= "a-zA-Z";
			lastName.tabIndex			= 2;
			
			phone.label					= _data.phone;
			phone.maxChars				= 50;
			phone.restrict				= "0-9";
			phone.tabIndex				= 3;
			
			email.label					= _data.email;
			email.maxChars				= 320;
			email.tabIndex				= 4;
			
			message.label 				= _data.message;
			message.tabIndex			= 5;
			message.setSize(420,66);
			
			status_txt.text 			= "";
			
			submitButton.bLabel.text	= _data.submit;
			submitButton.addEventListener(MouseEvent.CLICK, _onSubmit);
		}
		
		private function _onSubmit(e:MouseEvent) : void
		{
			if( _validateForm() && submitButton.enabled )
			{
				var names:String = firstName.text.toLowerCase() + " " + lastName.text.toLowerCase();
				
				var contactRequest:ContactRequest = new ContactRequest( names, phone.text, email.text.toLowerCase(), message.text);
				var urlLoader:URLLoader = new URLLoader(contactRequest.request);
				urlLoader.addEventListener(Event.COMPLETE, _submitFormComplete);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _submitError);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _submitError);
				
				submitButton.enabled = false;				
			}
		}
		
		private function _resetForm() : void
		{
			firstName.reset();
			lastName.reset();
			phone.reset();
			email.reset();
			message.reset();
			status_txt.text = "";
			submitButton.enabled = true;			
		}
		
		private function _validateForm() : Boolean
		{
			var ev:VEmail = new VEmail();
			
			var isValid:Boolean = true;
			var errorMsg:String = "";
			
			// Validate first name
			if(firstName.text.length < 1)
			{
				isValid = false;
				firstName.valid = false;
				errorMsg = ContactsFormErrors.INVALID_NAME;
			}
			else
			{
				firstName.valid = true;
			}
			
			// Validate last name
			if( lastName.text.length < 1 )
			{
				isValid = false;
				lastName.valid = false;
				errorMsg = ContactsFormErrors.INVALID_NAME;
			}
			else
			{
				lastName.valid = true;
			}
			
			// Validate phone
			if( phone.text.length < 1 )
			{
				isValid = false;
				phone.valid = false;
				errorMsg = ContactsFormErrors.INVALID_PHONE;
			}
			else
			{
				phone.valid = true;
			}
			
			// Validate email
			if( !ev.isValid(email.text) )
			{
				isValid = false;
				email.valid = false;
				errorMsg = ContactsFormErrors.INVALID_EMAIL;
			}
			else
			{
				email.valid = true;
			}
			
			// Validate message
			if(message.text.length < 1)
			{
				isValid = false;
				message.valid = false;
				errorMsg = ContactsFormErrors.INVALID_MESSAGE;
			}
			else
			{
				message.valid = true;
			}
			
			return isValid;			
		}
		
        private function _submitError(event:ErrorEvent) : void
        {
            submitButton.enabled = true;
            status_txt.text = "System error!";
        }		
		
        private function _submitFormComplete(event:Event=null) : void
        {			
            var pResponse:* = new ContactResult(event.target.data);
            
			if (!pResponse.success)
            {
                status_txt.text = "System error!";
            }
            else
            {
                _resetForm();
                _model.alert(new ContactsFormAlert(_model));
            }
			
            submitButton.enabled = true;
        }		
	}	
}