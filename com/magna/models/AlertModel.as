package com.magna.models {
	
	import flash.events.EventDispatcher;
	
	public class AlertModel extends EventDispatcher {
		
        public var message:String;
        public var title:String;
        public var onCancel:Function;
        public var type:String;
        public var onOK:Function;
	
		// Initialization:
		public function AlertModel(pTitle:String = "", pMsg:String = "")
		{
            this.type = "ok";
            title = pTitle;
            message = pMsg;			
		}

	}
	
}