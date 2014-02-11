package com.magna.controls.textinputs
{
    import caurina.transitions.*;
    import flash.events.*;
    import flash.text.*;

    dynamic public class EGGTextInput extends BaseTextInput implements ITextInput
    {
        public var labelTextField:TextField;

        public function EGGTextInput()
        {
            this.labelTextField.mouseEnabled = false;
            this.labelTextField.tabEnabled = false;
            addEventListener(FocusEvent.FOCUS_IN, this.focusIn);
            addEventListener(FocusEvent.FOCUS_OUT, this.focusOut);
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            if (param1 == "")
            {
                Tweener.addTween(this.labelTextField, {time:0.25, transition:"easeoutsine", alpha:1, x:0});
            }
            else
            {
                this.labelTextField.alpha = 0;
                this.labelTextField.x = 10;
            }
            super.text = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this.labelTextField.text;
        }// end function

        protected function focusOut(event:FocusEvent) : void
        {
            if (inputTextField.text == "")
            {
                Tweener.addTween(this.labelTextField, {time:0.25, transition:"easeoutsine", alpha:1, x:0});
            }
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this.labelTextField.text = param1;
            return;
        }// end function

        protected function focusIn(event:FocusEvent) : void
        {
            stage.focus = inputTextField;
            Tweener.addTween(this.labelTextField, {time:0.25, transition:"easeoutsine", alpha:0, x:10});
            return;
        }// end function

    }
}
