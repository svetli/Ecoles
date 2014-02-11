package com.magna.controls.textinputs
{
    import com.magna.controls.textinputs.*;
    import flash.display.*;
    import flash.events.*;
    import com.greensock.*;

    public class InputTextField extends Sprite
    {
        private var _text:String;
        public var invalidStroke:MovieClip;
        public var inputField:EGGTextInput;
        public var background:MovieClip;
        private var _displayUpperCase:Boolean;
        private var _isValid:Boolean;
        public var stroke:MovieClip;
        private static const DEFAULT_WIDTH:Number = 250;
        private static const DEFAULT_HEIGHT:Number = 22;

        public function InputTextField()
        {
            this.initializeSize();
            this.invalidStroke.visible = false;
            this._displayUpperCase = false;
            this.inputField.inputTextField.addEventListener(Event.CHANGE, this.textChangeEvent);
            this.inputField.inputTextField.addEventListener(FocusEvent.FOCUS_IN, this.textFocusEvent);
            this.inputField.inputTextField.addEventListener(FocusEvent.FOCUS_OUT, this.textFocusEvent);
            this._isValid = true;
            this._text = this.inputField.inputTextField.text;
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this.inputField.enabled;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            this.inputField.enabled = param1;
            return;
        }// end function

        public function get restrict() : String
        {
            return this.inputField.inputTextField.restrict;
        }// end function

        public function set restrict(param1:String) : void
        {
            this.inputField.inputTextField.restrict = param1 == "" ? (null) : (param1);
            return;
        }// end function

        public function reset() : void
        {
            this.text = "";
            this.valid = true;
            return;
        }// end function

        private function setValid(param1:Boolean) : void
        {
            this._isValid = param1;
            this.invalidStroke.visible = !param1;
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this.stroke.width = param1;
            this.stroke.height = param2;
            this.invalidStroke.width = param1;
            this.invalidStroke.height = param2;
            this.background.width = param1;
            this.background.height = param2;
            this.inputField.inputTextField.width = param1 - this.inputField.x;
            this.inputField.inputTextField.height = param2;
            this.inputField.labelTextField.width = param1 - this.inputField.x;
            this.inputField.labelTextField.height = param2;
            this.inputField.inputTextField.multiline = param2 > DEFAULT_HEIGHT;
            return;
        }// end function

        public function get displayAsPassword() : Boolean
        {
            return this.inputField.inputTextField.displayAsPassword;
        }// end function

        public function get displayUpperCase() : Boolean
        {
            return this._displayUpperCase;
        }// end function

        public function get maxChars() : Number
        {
            return this.inputField.inputTextField.maxChars;
        }// end function

        public function set text(param1:String) : void
        {
            this.inputField.text = param1;
            this.textChangeEvent();
            return;
        }// end function

        private function textChangeEvent(event:Event = null) : void
        {
            this._text = this.inputField.inputTextField.text;
            if (this._displayUpperCase)
            {
                this.inputField.inputTextField.text = this._text.toUpperCase();
            }
            return;
        }// end function

        public function set displayUpperCase(param1:Boolean) : void
        {
            this._displayUpperCase = param1;
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this.inputField.label = param1.toUpperCase();
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        private function initializeSize() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            if (super.width != DEFAULT_WIDTH || super.height != DEFAULT_HEIGHT)
            {
                _loc_1 = super.width;
                _loc_2 = super.height;
                super.width = DEFAULT_WIDTH;
                super.height = DEFAULT_HEIGHT;
                this.setSize(_loc_1, _loc_2);
            }
            return;
        }// end function

        public function set maxChars(param1:Number) : void
        {
            this.inputField.inputTextField.maxChars = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this.inputField.label;
        }// end function

        public function set displayAsPassword(param1:Boolean) : void
        {
            this.inputField.inputTextField.displayAsPassword = param1;
            return;
        }// end function

        public function set valid(param1:Boolean) : void
        {
            this.setValid(param1);
            return;
        }// end function

        override public function set tabIndex(param1:int) : void
        {
            this.inputField.inputTextField.tabIndex = param1;
            return;
        }// end function

        public function get valid() : Boolean
        {
            return this._isValid;
        }// end function

        override public function get tabIndex() : int
        {
            return this.inputField.inputTextField.tabIndex;
        }// end function

        private function textFocusEvent(event:FocusEvent) : void
        {
            if (event.type == FocusEvent.FOCUS_IN)
            {
                TweenMax.to(this.background, 0.25, {colorMatrixFilter:{colorize:0, amount:0.25}});
            }
            else
            {
                TweenMax.to(this.background, 0.25, {colorMatrixFilter:{colorize:0, amount:0}});
            }
            return;
        }// end function

    }
}
