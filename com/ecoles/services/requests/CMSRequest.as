package com.ecoles.services.requests {
	
	import com.magna.services.soap.Request;
	import com.ecoles.EcolesConfig;
	
	public class CMSRequest extends Request {
		
		// Constants:
		private static const SOAP_ACTION:String = "/cmsRequest";
	
		// Initialization:
		public function CMSRequest(id:String, lang:String) {
			
			super( EcolesConfig.SOAP_URL, EcolesConfig.SOAP_URL + SOAP_ACTION );
			
			body = new XML(
						   		"<soap:cmsRequest xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" + 
						   		"<page>" + id + "</page>" +
								"<lang>" + lang + "</lang>" + 
						   		"</soap:cmsRequest>"
						   );			
		}
	}
	
}