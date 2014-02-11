package com.ecoles.services.requests {
	
	import com.magna.services.soap.Request;
	import com.ecoles.EcolesConfig;	
	
	public class ContactRequest extends Request {
		
		private static const SOAP_ACTION:String = "/contactRequest";
	
		// Initialization:
		public function ContactRequest(names:String, phone:String, email:String, message:String)
		{
			super( EcolesConfig.SOAP_URL, EcolesConfig.SOAP_URL + SOAP_ACTION );
			
			body = new XML(
						   		"<soap:contactRequest xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" + 
						   		"<name>"  + names + "</name>"  +
								"<phone>" + phone + "</phone>" +
								"<email>" + email + "</email>" +
								"<message>"+ message + "</message>" +
						   		"</soap:contactRequest>"
						   );				
		}
	}
}