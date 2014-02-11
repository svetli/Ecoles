package com.magna.loading
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
	import com.magna.loading.Job;
	
    public class LoaderQueue extends EventDispatcher
    {
        private var _itemsTotal:uint;
        private var _curJob:Job;
        private var _addCount:Number;
        private var _weightLoaded:Number;
        private var _queue:Array;
        private var _itesms:Dictionary;
        private var _itemsComplete:uint;
        private var _weightTotal:Number;

        public function LoaderQueue()
        {
            this._queue = new Array();
            this._itemsTotal = 0;
            this._itemsComplete = 0;
            this._addCount = 0;
            this._weightLoaded = 0;
            this._weightTotal = 0;
            return;
        }// end function

        private function removeCurJob() : void
        {
            this._queue.shift();
            this._curJob.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.loadProgressEvent);
            this._curJob.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.loadComplete);
            this._curJob.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.loadError);
            this._curJob.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadError);
            this._curJob = null;
            return;
        }// end function

        private function loadError(param1:ErrorEvent) : void
        {
			trace("LoaderQueue Error"+param1);
            this.removeCurJob();
            dispatchEvent(param1.clone());
            return;
        }// end function

        public function get total() : uint
        {
            return this._itemsTotal;
        }// end function

        public function stop() : void
        {
            if (this._curJob != null)
            {
                try
                {
                    this._curJob.loader.close();
                }// end try
                catch (error:Error)
                {
                }// end if
            }// end catch
            return;
        }// end function

        public function get completed() : uint
        {
            return this._itemsComplete;
        }// end function

        private function sortQueue(param1:Object, param2:Object) : Number
        {
            if (param1.priority > param2.priority)
            {
                return -1;
            }// end if
            if (param1.priority < param2.priority)
            {
                return 1;
            }// end if
            if (param1.added < param2.added)
            {
                return -1;
            }// end if
            if (param1.added > param2.added)
            {
                return 1;
            }// end if
            return 0;
        }// end function

        public function addLoader(param1:Loader, param2:URLRequest, param3:uint = 0, param4:uint = 0) : Loader
        {
            var _job:Job;
            var _isLoader:* = this.hasLoader(param1);
            if (this.hasLoader(param1) != -1)
            {
                _job = this._queue[_isLoader];
                this._weightTotal = this._weightTotal - _job.weight;
                _job.request = param2;
                _job.priority = 0;
                _job.weight = 0;
            }
            else
            {
                _job = new Job();
                _job.loader = param1;
                _job.request = param2;
                _job.priority = param3;
				
                this._itemsTotal = this._itemsTotal++;
                this._queue.push(_job);
            }// end else if
            _job.weight = 1 + param4;
            this._weightTotal = this._weightTotal + _job.weight;
            this._addCount = this._addCount++;
            _job.added = this._addCount++;
            this._queue.sort(this.sortQueue);
            return param1;
        }// end function

        public function clear() : void
        {
            this.stop();
            this._queue = [];
            this._weightLoaded = 0;
            this._weightTotal = 0;
            this._itemsTotal = 0;
            this._itemsComplete = 0;
            this._addCount = 0;
            return;
        }// end function

        public function start() : void
        {
            if (this._queue.length > 0)
            {
                this.next();
            }// end if
            return;
        }// end function

        public function hasLoader(param1:Loader) : Number
        {
            var _loc_3:Job;
            var _loc_2:Number;
            while (_loc_2++ < this._queue.length)
            {
                // label
                _loc_3 = this._queue[_loc_2] as Job;
                if (_loc_3.loader == param1)
                {
                    return _loc_2;
                }// end if
            }// end while
            return -1;
        }// end function

        private function loadProgressEvent(param1:ProgressEvent) : void
        {
            var _loc_2:* = param1.bytesLoaded / param1.bytesTotal;
            if (isFinite(_loc_2) && _loc_2 > 0)
            {
                this._curJob.weightLoaded = _loc_2 * this._curJob.weight;
            }
            else
            {
                this._curJob.weightLoaded = 0;
            }// end else if
            dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, this._weightLoaded + this._curJob.weightLoaded, this._weightTotal));
            return;
        }// end function

        public function get progress() : Number
        {
            var _loc_1:* = this._curJob != null ? (this._curJob.weightLoaded) : (0);
            return (this._weightLoaded + _loc_1) / this._weightTotal;
        }// end function

        private function next() : void
        {
            if (this._curJob != null)
            {
                this._curJob = null;
            }// end if
            if (this._queue.length == 0)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            else
            {
                this._curJob = this._queue[0] as Job;
                this._curJob.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.loadProgressEvent);
                this._curJob.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadComplete);
                this._curJob.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadError);
                this._curJob.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadError);
                this._curJob.loader.load(this._curJob.request);
            }// end else if
            return;
        }// end function

        private function loadComplete(param1:Event) : void
        {
            this._itemsComplete = this._itemsComplete++;
            this._weightLoaded = this._weightLoaded + this._curJob.weightLoaded;
            this.removeCurJob();
            this.next();
            dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, this._weightLoaded, this._weightTotal));
            return;
        }// end function

    }
}
