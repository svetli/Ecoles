package com.ecoles.views.pages.clients.controls {
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.events.Event;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.clients.controls.ClientsGridItem;
	import com.ecoles.vo.ImageVO;
	
    import com.greensock.*;
    import com.greensock.easing.*;		
	
	public class ClientsGrid extends Sprite {
		
		// Constants:
		public static const MAX_COLS:Number = 4;
        private static const ITEM_H_SPACING:Number = 10;
        private static const ITEM_V_SPACING:Number = 5;
        private static const ITEMS_PER_PAGE:Number = 12;
        private static const ITEM_HEIGHT:Number = 100;		
		private static const ITEM_WIDTH:Number = 140;	
		
		// Public Properties:
		// Private Properties:
		private var items:Dictionary;
		private var logos:Array;
		private var _container:Sprite;
		private var _model:EcolesModel;
		private var autoload:Boolean;
		private var pendingImage:ImageVO;
		public var selectedItem:ClientsGridItem;
		// Initialization:
		public function ClientsGrid()
		{
			logos = new Array();
			items = new Dictionary();
		}
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}		
		
		public function setItems(items:Array) : void
		{
			logos = items;
			viewGrid();
		}		
	
        public function startLoading() : void
        {
            autoload = true;
            ClientsGridItem( _container.getChildAt(0) ).load();
        }	
		
		public function viewGrid() : void
		{
			var i:Number = 0;
			var j:Number = 0;
			var k:Number = 0;
			
			var item:ClientsGridItem;
			var prevItem:ClientsGridItem;
			_container = new Sprite();
			addChild(_container);

			var ROWS:Number = Math.round( (logos.length/MAX_COLS)+0.5 );

			while( i < ROWS )
			{
				j = 0;
				
				while( j < MAX_COLS )
				{
					if( k > (logos.length-1) ) {
						break;
					}
					items[k] = new ClientsGridItem(logos[k], prevItem);
					item = items[k] as ClientsGridItem;
					item.model = _model;
					item.x = j * (ITEM_WIDTH + ITEM_H_SPACING);
					item.y = i * (ITEM_HEIGHT + ITEM_V_SPACING);
					item.addEventListener(Event.SELECT, itemSelectEvent, false, 0, true);
					item.startLoad();
					item.alpha = 1;
					_container.addChild(item);
					prevItem = item;
					TweenMax.to(item, 0.5, {ease:Sine.easeOut, blurFilter:{blurX:0, blurY:0}});
					k++; j++;
				}
				i++;
			}
			
			TweenMax.from(_container, 0.4, {ease:Sine.easeOut, alpha:0});
	
			if (autoload)
			{
				ClientsGridItem(_container.getChildAt(0)).load();
			}
			
			dispatchEvent(new Event(Event.CHANGE));				
		}
		
		private function itemSelectEvent(e:Event) : void
		{
            selectedItem = e.target as ClientsGridItem;
            dispatchEvent(new Event(Event.SELECT));	
		}			
	}
	
}