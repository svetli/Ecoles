package com.ecoles.views.background
{
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.events.MouseEvent;
	import com.ecoles.models.EcolesModel
	import com.ecoles.EcolesConfig;
	
	public class SndSwitch extends MovieClip
	{
		private var _model:EcolesModel;
		
		public function SndSwitch(pModel:EcolesModel)
		{
			_model = pModel;
			buttonMode = true;
			
			
			var fl:FrameLabel = null;
			
			for each ( fl in currentLabels)
			{
				if(fl.name == "sOn")
				{
					addFrameScript( fl.frame-1, frameON);
				}
				
				if(fl.name == "sOff")
				{
					addFrameScript( fl.frame-1, frameOFF );
				}
			}
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function frameON()
		{
			Ecoles.soundManager.fadeUpAndPlay(EcolesConfig.AMBIENT_SOUND, 1.5, "linear", 0, 5000);
			stop();
		}
		
		private function frameOFF()
		{
			Ecoles.soundManager.fadeDownAndStop(EcolesConfig.AMBIENT_SOUND, 1.5);
			stop();
		}
		
		private function onClick(e:MouseEvent)
		{
			play();
		}
	}
}