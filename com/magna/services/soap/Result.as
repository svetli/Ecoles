/**
*	SOAP Result
*
*	@package	com.magna.services.soap
*	@author		Svetli Nikolov
*/
package com.magna.services.soap {
	
	import com.dynamicflash.util.Base64;
	
	public class Result extends Object {
	
		// Public Properties:
		public var success:Boolean;
		public var result:XML;
		public var message:String;		
		public var debug:Boolean;
	
		// Initialization:
		public function Result(pData:String, pName:String) {
			var xml:XML;
			var response:XMLList;
			var data:* = pData
			var name:* = pName;
			
			this.result 	= new XML();
			this.success 	= false;
			this.message 	= "Failed to parse.";
			
			try {
				xml 	 = new XML(data);
				var xNs:Namespace = xml.namespace("SOAP-ENV");
				if(this.debug)
				{
					trace("---------- RAW XML -----------------------------");
					trace(xml);
					trace("------------------------------------------------");
				}

				// Get server response
				response = xml.xNs::Body.xNs::[name + "Response"];
				if(this.debug)
				{
					trace("---------- XML RESPONSE --------------------------");
					trace(response);
					trace("--------------------------------------------------");
				}
				// Decode server response
				this.result 	 = new XML(Base64.decode(response["return"]));
				if(this.debug)
				{
					trace("---------- DECODED RESULT -------------------------");
					trace(result);
					trace("---------------------------------------------------");
				}
				
				success  = result.value != 0;
				message  = result.message;
			}
			catch (error:Error)
			{
				success = false;
				message = error.message;
				return;
			}
			catch (error:Error)
			{
				throw new Error("The XML returned is not propertly formatted: "+ data);
			}			
		}
	}
	
}