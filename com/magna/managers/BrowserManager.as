package com.magna.managers
{
    import flash.external.*;
    import flash.system.*;

    public class BrowserManager extends Object
    {
        public static const SCROLL:String = "onScroll";
        public static const RESIZE:String = "onResize";
        public static const UNLOAD:String = "onUnload";

        public function BrowserManager()
        {
            return;
        }// end function

        public static function eval(param1:String) : void
        {
            call("eval", param1);
            return;
        }// end function

        public static function setWidth(param1:Number) : void
        {
            call("magna.BrowserManager.setWidth", param1);
            return;
        }// end function

        public static function addCallBack(param1:String, param2:Function) : void
        {
            if (ExternalInterface.available == false)
            {
                return;
            }// end if
            if (Capabilities.playerType == "external")
            {
                return;
            }// end if
            ExternalInterface.addCallback(param1, param2);
            return;
        }// end function

        public static function getDocumentY() : Number
        {
            return call("magna.BrowserManager.getScroll");
        }// end function

        public static function getTitle() : String
        {
            return call("magna.BrowserManager.getTitle");
        }// end function

        public static function getWidth() : String
        {
            return call("magna.BrowserManager.getWidth");
        }// end function

        public static function setTitle(param1:String) : void
        {
            call("magna.BrowserManager.setTitle", param1);
            return;
        }// end function

        public static function setHeight(param1) : void
        {
            call("magna.BrowserManager.setHeight", param1);
            return;
        }// end function

        public static function alert(param1:String) : void
        {
            call("alert", param1);
            return;
        }// end function

        public static function getHeight() : Number
        {
            return call("magna.BrowserManager.getHeight");
        }// end function

        public static function call(param1:String, ... args)
        {
            if (ExternalInterface.available == false)
            {
                return;
            }// end if
            if (Capabilities.playerType == "external")
            {
                return;
            }// end if
            return ExternalInterface.call(param1, args);
        }// end function

    }
}
