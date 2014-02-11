package com.magna.controls.sounds
{
    import caurina.transitions.*;
    import caurina.transitions.properties.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class SWFSoundManager extends Object
    {
        protected var _usePercentage:Boolean;
        protected var _swf:Sprite;
        protected var _fadeTime:Number = 1;
        protected var _easing:String = "linear";
        protected var _soundLibrary:Array;
        public var panTween:Number;
        protected var _domain:ApplicationDomain;
        protected var _soundDict:Dictionary;
        protected var _useBoth:Boolean;
        protected var _muted:Boolean;
        protected var _playHeadPercent:Number;
        protected var _enterFrameSprite:Sprite;
        protected var _library:Object;

        public function SWFSoundManager(param1:ApplicationDomain, param2:Sprite = null, param3:Boolean = false, param4:Boolean = true)
        {
            if (!param4)
            {
                _enterFrameSprite = new Sprite();
            }
            SoundShortcuts.init();
            _useBoth = param3;
            _swf = param2;
            if (_muted && _swf)
            {
                _swf.soundTransform = new SoundTransform(0);
            }
            _domain = param1;
            _soundLibrary = new Array();
            _library = new Object();
            _soundDict = new Dictionary();
            return;
        }// end function

        public function set usePercentage(param1:Boolean) : void
        {
            _usePercentage = param1;
            return;
        }// end function

        protected function soundIsComplete(event:Event = null) : void
        {
            var e:* = event;
            try
            {
                if (_library[_soundDict[e.target]].repeat)
                {
                    _library[_soundDict[e.target]].position = 0;
                    fadeUpAndPlay(_soundDict[e.target], 0.5, "linear", 0, 0, 0, true);
                }
                else
                {
                    _soundDict[e.target].playing = false;
                    e.target.removeEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function



        public function turnVolumeTo(param1:String, param2:Number, param3:Number = 1, param4:String = "linear") : void
        {
            var sc:SoundChannel;
            var soundName:* = param1;
            var tempVol:* = param2;
            var fadeTime:* = param3;
            var easing:* = param4;
            try
            {
                sc = _library[soundName].sc;
                Tweener.addTween(sc, {_sound_volume:tempVol, time:fadeTime, transition:easing});
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function fadeDownAndStop(param1:String, param2:Number, param3:String = "linear", param4:Boolean = false) : void
        {
            var sc:SoundChannel;
            var func:Function;
            var soundName:* = param1;
            var fadeTimeInSec:* = param2;
            var ease:* = param3;
            var playAgain:* = param4;
            try
            {
                if (_library[soundName].playing && _library[soundName].sc != undefined)
                {
                    sc = _library[soundName].sc;
                    func = function () : void
            {
                _library[soundName].position = sc.position;
                sc.stop();
                _library[soundName].playing = false;
                if (sc.hasEventListener(Event.SOUND_COMPLETE))
                {
                    sc.removeEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                }
                return;
            }// end function
            ;
                    Tweener.addTween(sc, {_sound_volume:0, time:fadeTimeInSec, transition:ease, onComplete:func});
                }
            }
            catch (err:Error)
            {
            }
            return;
        }// end function


        public function panSound(param1:String, param2:Number, param3:Number = 1, param4:String = "linear") : void
        {
            var sc:SoundChannel;
            var panFunc:Function;
            var soundName:* = param1;
            var p:* = param2;
            var panTimeInSec:* = param3;
            var ease:* = param4;
            if (_library[soundName].playing && _library[soundName].sc != undefined)
            {
                sc = _library[soundName].sc;
                panTween = sc.soundTransform.pan;
                panFunc = function () : void
            {
                var _loc_1:* = sc.soundTransform;
                _loc_1.pan = panTween;
                sc.soundTransform = _loc_1;
                return;
            }// end function
            ;
                Tweener.addTween(this, {panTween:p, time:panTimeInSec, onUpdate:panFunc, transition:ease});
            }
            return;
        }// end function

        protected function createNewSoundObject(param1:Sound, param2:int, param3:String, param4:Boolean, param5:Boolean) : void
        {
            _soundLibrary[param2].id = param1;
            _library[param3] = _soundLibrary[param2];
            _library[param3].id = _soundLibrary[param2].id;
            _library[param3].repeat = param4;
            _library[param3].sc = undefined;
            _library[param3].position = 0;
            _library[param3].playing = false;
            _library[param3].error = param5;
            _library[param3].initVolume = _soundLibrary[param2].vol;
            return;
        }// end function

        public function changeDefaultVolumeOfSound(param1:String, param2:Number) : void
        {
            _library[param1].vol = param2;
            return;
        }// end function

        public function set playHeadPercentage(param1:Number) : void
        {
            _playHeadPercent = param1;
            return;
        }// end function

        public function stopSound(param1:String) : void
        {
            var soundName:* = param1;
            try
            {
                if (_library[soundName].sc != undefined)
                {
                    _library[soundName].sc.stop();
                    _library[soundName].playing = false;
                    if (_library[soundName].sc.hasEventListener(Event.SOUND_COMPLETE))
                    {
                        _library[soundName].sc.removeEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                    }
                }
            }
            catch (err:Error)
            {
            }
            return;
        }// end function

        public function addSound(param1:String, param2:Number, param3:String = "", param4:Boolean = false) : void
        {
            var sound:Sound;
            var soundClass:Class;
            var soundID:* = param1;
            var soundVolume:* = param2;
            var path:* = param3;
            var repeat:* = param4;
            _soundLibrary.push({id:soundID, vol:soundVolume});
            var c:* = (_soundLibrary.length - 1);
            var soundName:* = _soundLibrary[c].id;
            var soundError:Boolean;
            try
            {
                if (path == "")
                {
                    soundClass = _domain.getDefinition(soundName) as Class;
                    sound = new soundClass;
                }
                else
                {
                    sound = new Sound();
                    sound.load(new URLRequest(path), new SoundLoaderContext(3000));
                }
            }
            catch (e:Error)
            {
                trace("addSound Error: " + e);
            }
            createNewSoundObject(sound, c, soundName, repeat, soundError);
            return;
        }// end function

        public function getLastSoundPos(param1:String) : Number
        {
            return _library[param1].position;
        }// end function

        public function fadeUpAndPlay(param1:String, param2:Number, param3:String = "linear", param4:Number = 0, param5:int = 0, param6:Number = 0, param7:Boolean = false) : void
        {
            var soundObj:Object;
            var sound:Sound;
            var sc:SoundChannel;
            var st:Number;
            var soundName:* = param1;
            var fadeTimeInSec:* = param2;
            var ease:* = param3;
            var startTime:* = param4;
            var loops:* = param5;
            var p:* = param6;
            var playIfPlaying:* = param7;
            try
            {
                if (!_library[soundName].playing || playIfPlaying)
                {
                    soundObj = _library[soundName];
                    sound = soundObj.id;
                    if (_usePercentage && _playHeadPercent != 0)
                    {
                        st = _playHeadPercent * 0.01 * sound.length;
                        _library[soundName].sc = sound.play(st, loops, new SoundTransform(0, p));
                    }
                    else
                    {
                        _library[soundName].sc = sound.play(startTime, loops, new SoundTransform(0, p));
                    }
                    sc = _library[soundName].sc;
                    _soundDict[sc] = soundName;
                    _library[soundName].playing = true;
                    if (playIfPlaying && sc.hasEventListener(Event.SOUND_COMPLETE))
                    {
                        sc.removeEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                    }
                    else
                    {
                        sc.addEventListener(Event.SOUND_COMPLETE, soundIsComplete, false, 0, true);
                    }
                    if (!_muted)
                    {
                        Tweener.addTween(_library[soundName].sc, {_sound_volume:_library[soundName].vol, time:fadeTimeInSec, transition:ease});
                    }
                }
            }
            catch (err:Error)
            {
            }
            return;
        }// end function

        public function playSound(param1:String, param2:Number = 0, param3:Number = 0, param4:int = 0, param5:Boolean = false) : void
        {
            var soundObj:Object;
            var sound:Sound;
            var vol:SoundTransform;
            var sc:SoundChannel;
            var st:Number;
            var soundName:* = param1;
            var p:* = param2;
            var startTime:* = param3;
            var loops:* = param4;
            var playIfPlaying:* = param5;
            try
            {
                if (!_library[soundName].playing || playIfPlaying)
                {
                    if (playIfPlaying && _library[soundName].sc != undefined && !_library[soundName].repeat)
                    {
                        _library[soundName].playing = false;
                        _library[soundName].sc.removeEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                    }
                    soundObj = _library[soundName];
                    sound = soundObj.id;
                    if (!_muted)
                    {
                        vol = new SoundTransform(soundObj.vol, p);
                    }
                    else
                    {
                        vol = new SoundTransform(0, p);
                    }
                    if (_usePercentage && _playHeadPercent != 0)
                    {
                        st = _playHeadPercent * 0.01 * sound.length;
                        _library[soundName].sc = sound.play(st, loops, vol);
                    }
                    else
                    {
                        _library[soundName].sc = sound.play(startTime, loops, vol);
                    }
                    _library[soundName].playing = true;
                    _soundDict[_library[soundName].sc] = soundName;
                    sc = _library[soundName].sc;
                    if (sc && !sc.hasEventListener(Event.SOUND_COMPLETE))
                    {
                        sc.addEventListener(Event.SOUND_COMPLETE, soundIsComplete);
                    }
                    _playHeadPercent = 0;
                }
            }
            catch (err:Error)
            {
				trace("Error Sound Playing: " + err);
            }
            return;
        }// end function
	}
}
