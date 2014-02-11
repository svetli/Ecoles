package com.magna.loading
{
    import flash.display.*;
    import flash.net.*;

    public class Job extends Object
    {
        public var added:uint;
        public var priority:uint;
        public var request:URLRequest;
        public var loader:Loader;
        public var weight:Number;
        public var weightLoaded:Number;

        public function Job()
        {
            this.weight = 0;
            this.weightLoaded = 0;
            return;
        }
    }
}
