package com.ecoles.views.pages.gallery.controls {
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.events.Event;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.ecoles.models.EcolesModel;
	import com.ecoles.vo.ImageVO;
	import com.ecoles.views.pages.gallery.controls.ImageGridItem;
	
	public class ImagesGrid extends Sprite {
		
		// Constants:
		public static const MAX_COLS:Number = 4;
        private static const ITEM_H_SPACING:Number = 10;
        private static const ITEM_V_SPACING:Number = 5;
        private static const ITEMS_PER_PAGE:Number = 12;
        private static const ITEM_HEIGHT:Number = 89;		
		private static const ITEM_WIDTH:Number = 125;		
		// Public Properties:
		// Private Properties:
		private var gridItems:Dictionary;
		private var images:Array;
		private var _container:Sprite;
		private var autoload:Boolean;
		private var pendingImage:ImageVO;
		private var _model:EcolesModel;
		private var selectedItem:ImageGridItem;
		// Initialization:
		public function ImagesGrid()
		{
			images 		= new Array();
			gridItems 	= new Dictionary();
		}
	
		// Public Methods:
		public function setItems(items:Array) : void
		{
			images = items;
			viewGrid();
		}
		
		public function set model(pModel:EcolesModel) : void
		{
			_model = pModel;
		}
		
		public function viewGrid() : void
		{
			var i:Number = 0;
			var j:Number = 0;
			var k:Number = 0;
			
			var item:ImageGridItem;
			var prevItem:ImageGridItem;
			_container = new Sprite();
			addChild(_container);
			
			var ROWS:Number = Math.round( (images.length/MAX_COLS)+0.5 );
			
			while( i < ROWS )
			{
				j = 0;
				
				while( j < MAX_COLS )
				{
					if( k > (images.length-1) ) {
						break;
					}
					gridItems[k] = new ImageGridItem(images[k], prevItem);
					item = gridItems[k] as ImageGridItem;
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
				ImageGridItem(_container.getChildAt(0)).load();
			}
			
			dispatchEvent(new Event(Event.CHANGE));			
		}
		
		// Protected Methods:
		private function itemSelectEvent(e:Event) : void
		{
            selectedItem = e.target as ImageGridItem;
            dispatchEvent(new Event(Event.SELECT))			
		}		
		
        public function startLoading() : void
        {
            autoload = true;
            ImageGridItem( _container.getChildAt(0) ).load();
        }		
		
	}
	
}