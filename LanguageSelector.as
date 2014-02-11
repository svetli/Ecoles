package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.ui.*;
	
	import com.ecoles.EcolesConfig;
	
	public class LanguageSelector extends Sprite
	{
		public var bg:MovieClip;
		public var en:MovieClip;
		public var it:MovieClip;
		
		private const DEFAULT_WIDTH:Number = 400;
		private const DEFAULT_HEIGHT:Number = 600;
		private const PADDING_TOP:Number = 0;
		
		public function LanguageSelector()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			tracker = new GATracker(this, PierlucciConfig.GOOGLE_KEY, "AS3", PierlucciConfig.GOOGLE_DEBUG);
//			tracker.trackPageview("/");
			
			_initContextMenu();
			_addListeners();
			_stageResizeEvent();
		}
		
		private function _initContextMenu() : void
		{
			contextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			var ecoles:ContextMenuItem = new ContextMenuItem("© Ecolesproject Ltd.");
			var svetli:ContextMenuItem = new ContextMenuItem("by Svetli Nikolov");
			svetli.separatorBefore = true;
			svetli.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, _onClickSvetli);
			contextMenu.customItems.push(ecoles, svetli);			
		}
		
		private function _addListeners() : void
		{
			stage.addEventListener( Event.RESIZE, _stageResizeEvent );
			bg.addEventListener(MouseEvent.CLICK, _bgClickEvent);
			en.addEventListener(MouseEvent.CLICK, _enClickEvent);
			it.addEventListener(MouseEvent.CLICK, _itClickEvent);
		}
		
		private function _stageResizeEvent(e:Event=null) : void
		{
			x = Math.round(stage.stageWidth  * 0.5 - DEFAULT_WIDTH  * 0.5);
			y = Math.round( (stage.stageHeight * 0.5 - DEFAULT_HEIGHT * 0.5) + PADDING_TOP);
			var t:* = globalToLocal( new Point() );
			var pageFill:Sprite;
			pageFill = new Sprite();
			pageFill.x = t.x;
			pageFill.y = t.y;
			pageFill.graphics.beginFill(0xffffff);
			pageFill.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			pageFill.graphics.endFill();
			addChildAt(pageFill,0);			
		}
		
		private function _bgClickEvent(e:MouseEvent) : void
		{
			navigateToURL( new URLRequest(EcolesConfig.URL + "/bg/"), "_self" );
		}
		
		private function _enClickEvent(e:MouseEvent) : void
		{
			navigateToURL( new URLRequest(EcolesConfig.URL + "/en/"), "_self" );
		}
		
		private function _itClickEvent(e:MouseEvent) : void
		{
			navigateToURL( new URLRequest(EcolesConfig.URL + "/it/"), "_self" );
		}
		
		private function _onClickSvetli(e:ContextMenuEvent) : void
		{
			navigateToURL( new URLRequest("http://svetli.name/"), "_blank" );
		}
	}
}