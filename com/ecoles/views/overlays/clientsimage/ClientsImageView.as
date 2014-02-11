package com.ecoles.views.overlays.clientsimage {
	
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.views.overlays.AbstractOverlayView;
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	
	public class ClientsImageView extends AbstractOverlayView {
		
		private var _model:EcolesModel;
		private var _image:Loader;
	
		// Initialization:
		public function ClientsImageView(pModel:EcolesModel)
		{
			_model = pModel;
			var imageToLoad:* = pModel.overlayData.url;
            this._image = new Loader();
            this._image.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.loadImageError);
            this._image.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loadImageError);
            this._image.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loadImageComplete);
            this._image.load(new URLRequest(EcolesConfig.ASSETS_URL + pModel.language + "/clients/" + imageToLoad));
            addChild(this._image);
		}
		
	    private function loadImageError(event:ErrorEvent) : void
        {
			trace("Load Image Error: "+event);
            return;
        }

        private function loadImageComplete(event:Event) : void
        {
			_image.y = 25;
            TweenMax.from(this._image, 0.75, {ease:Expo.easeOut, alpha:0, blurFilter:{blurX:10, blurY:10}});
        }
	}
	
}