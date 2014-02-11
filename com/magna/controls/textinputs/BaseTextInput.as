package com.magna.controls.textinputs
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class BaseTextInput extends MovieClip implements ITextInput
    {
        public var inputTextField:TextField;
        private var _autoSelect:Boolean;
        private var _isEnabled:Boolean;

        public function BaseTextInput()
        {
            this.inputTextField.text = "";
            this._autoSelect = false;
            this.enable();
            return;
        }// end function

        protected function mouseClick(event:MouseEvent) : void
        {
            if (this._autoSelect)
            {
                this.selectText();
            }
            this.inputTextField.removeEventListener(MouseEvent.CLICK, this.selectText);
            return;
        }// end function

        override public function get enabled() : Boolean
        {
            return this._isEnabled;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (param1)
            {
                this.enable();
            }
            else
            {
                this.disable();
            }
            return;
        }// end function

        public function get autoSelect() : Boolean
        {
            return this._autoSelect;
        }// end function

        public function get text() : String
        {
            return this.inputTextField.text;
        }// end function

        protected function disable() : void
        {
            this._isEnabled = false;
            mouseEnabled = false;
            this.inputTextField.type = TextFieldType.DYNAMIC;
            return;
        }// end function

        private function onfocusOut(event:FocusEvent) : void
        {
            if (this._autoSelect)
            {
                this.inputTextField.addEventListener(MouseEvent.CLICK, this.mouseClick);
            }
            return;
        }// end function

        public function set autoSelect(param1:Boolean) : void
        {
            this._autoSelect = param1;
            if (this._autoSelect)
            {
                this.inputTextField.addEventListener(FocusEvent.FOCUS_OUT, this.onfocusOut);
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.inputTextField.text = param1;
            return;
        }// end function

        protected function enable() : void
        {
            this._isEnabled = true;
            mouseEnabled = true;
            this.inputTextField.type = TextFieldType.INPUT;
            return;
        }// end function

        public function selectText() : void
        {
            if (this._isEnabled)
            {
                this.inputTextField.setSelection(0, this.inputTextField.length);
            }
            return;
        }// end function

    }
}
