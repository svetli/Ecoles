/**
*	SOAP Request
*
*	@package	com.magna.services.soap
*	@author		Svetli Nikolov
*/
package com.magna.services.soap {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	
	public class Request extends Object {
		
		// Public Properties:
		public var soapAction:String;
		public var method:String;
		public var url:String;
		public var body:XML;
		public var contentType:String;
		public var requestHeaders:Array;
		
		// Private Properties:
	
		// Initialization:
		public function Request(	pUrl:String = null, 
									pAction:String = null,
									pContentType:String = "text/xml; charset=utf-8") {
			this.url 			= pUrl;
			this.soapAction 	= pAction;
			this.contentType	= pContentType;
			this.method			= URLRequestMethod.POST;			
		}
	
		// Public Methods:
		public function toXMLString() : String {
			var xmlObj:* = new XML(
								   		"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" + 
										"<soap:Body>" + body + "</soap:Body>" + 
										"</soap:Envelope>"
								   );

			return xmlObj.toXMLString();
		}		
		
		public function get request() : URLRequest
		{
			this.requestHeaders = (this.requestHeaders != null) ? (this.requestHeaders) : (new Array());
			this.requestHeaders.push( new URLRequestHeader( "SOAPAction" , this.soapAction ) );
			
			var r:URLRequest = new URLRequest(url);
			r.requestHeaders = this.requestHeaders;
			r.data 			 = this.toXMLString();
			r.method 		 = this.method;
			r.contentType 	 = this.contentType ;

			return r;
		}		
	}
	
}