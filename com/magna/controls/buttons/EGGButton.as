/**
*	Magna Library: EGG Button
*
*	@package	com.magna.controls.buttons
*	@author		Svetli Nikolov
*/

package com.magna.controls.buttons
{
	import com.magna.controls.buttons.IButton;
	import com.magna.controls.buttons.BaseButton;
	
	import flash.events.*;
	
	dynamic public class EGGButton extends BaseButton implements IButton
	{
		private var _isMouseOver:Boolean;
		
		public static const OUTRO:String = "outro";
		public static const INTRO:String = "intro";
		
		public function EGGButton()
		{
			stop();
			var cLabels:int = 0;
			
			while( cLabels < currentLabels.length )
			{
				switch( currentLabels[cLabels].name.toLowerCase() )
				{
					case INTRO :
					{
						addFrameScript(currentLabels[cLabels].frame-1, introFrameScript);
						break;
					}
					
					case OUTRO :
					{
						addFrameScript(currentLabels[cLabels].frame-1, outroFrameScript);
						break;
					}
					
					default:
					{
						break;
					}
				}
				
				cLabels++;
			}
			
			addEventListener( MouseEvent.MOUSE_OVER	, mouseOver);
			addEventListener( MouseEvent.MOUSE_OUT	, mouseOut );
			addEventListener( FocusEvent.FOCUS_IN	, focusIn  );
			addEventListener( FocusEvent.FOCUS_OUT	, focusOut );
		}
	
		override protected function setSelected(p:Boolean) : void
		{
			if( p && currentLabel != OUTRO )
			{
				play();
			}
			
			if( ! p && currentLabel != INTRO )
			{
				play();
			}
			
			super.setSelected(p);
		}
		
		override protected function enable() : void
		{
			if ( selected || !_isMouseOver && currentLabel != INTRO )
			{
				play();
			}
			
			super.enable();
		}
		
		protected function mouseOver(e:MouseEvent) : void
		{
			_isMouseOver = true;
			
			if( currentLabel != OUTRO )
			{
				play();
			}
		}
		
		protected function mouseOut(e:MouseEvent) : void
		{
			_isMouseOver = false;
			
			if( stage == null )
			{
				if( !selected && currentLabel != INTRO )
				{
					play();
				}
			}
			
			if ( !selected && currentLabel != INTRO && stage.focus != this)
			{
				play();
			}
		}
		
		protected function focusOut(e:FocusEvent) : void
		{
			if ( currentLabel != INTRO && !selected )
			{
				play();
			}
		}
		
		protected function focusIn(e:FocusEvent) : void
		{
			if ( currentLabel != OUTRO )
			{
				play();
			}
		}

        protected function introFrameScript() : void
        {
            if (stage == null)
            {
                gotoAndStop(selected ? (OUTRO) : (INTRO));
                return;
            }
            if (!selected && !_isMouseOver && stage.focus != this)
            {
                stop();
            }
        }
		
		protected function outroFrameScript() : void
		{
			if( stage == null )
			{
				gotoAndStop( selected ? (OUTRO) : (INTRO) );
			}
			else if (selected || _isMouseOver || stage.focus == this)
			{
				stop();
			}
		}
	}
}