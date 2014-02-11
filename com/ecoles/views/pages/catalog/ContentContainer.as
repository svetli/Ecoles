package com.ecoles.views.pages.catalog {
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.magna.controls.buttons.ButtonGroup;
	import com.magna.controls.buttons.BaseButton;
	import com.magna.controls.progress.ImageLoader;
	
	import com.ecoles.EcolesConfig;
	import com.ecoles.models.EcolesModel;
	import com.ecoles.views.pages.catalog.AbstractCatalogPage;
	import com.ecoles.views.pages.catalog.pellets.PelletsPage;
	import com.ecoles.views.pages.catalog.woods.WoodsPage;
	import com.ecoles.views.pages.catalog.conifers.ConifersPage;
	import com.ecoles.views.pages.catalog.decidious.DecidiousPage
	import com.ecoles.views.pages.catalog.dried.DriedPage;
	import com.ecoles.views.pages.catalog.logs.LogsPage;
	import com.ecoles.views.pages.catalog.firewood.FirewoodPage;
	import com.ecoles.views.pages.catalog.woodpulp.WoodpulpPage;
	
	public class ContentContainer extends Sprite {
		
		// Constants:
        private static const CONTENT_X:uint = 205;
        private static const CONTENT_Y:uint = 140;		
		
		// Public Properties:
		public var pelletsButton:BaseButton;
		public var woodsButton:BaseButton;
		public var conifersWoodButton:BaseButton;
		public var deciduousWoodButton:BaseButton;
		public var driedWoodButton:BaseButton;
		public var logsButton:BaseButton;
		public var fireWoodButton:BaseButton;
		public var woodpulpButton:BaseButton
		
		public var imageLoader:ImageLoader;
		public var _model:EcolesModel;
		
		// Private Properties:
		private var buttons:ButtonGroup;
		private var _content:AbstractCatalogPage;
		private var _pendingSection:String;
		private var _xml:XML;
		
		// Initialization:
		public function ContentContainer()
		{
			buttons = new ButtonGroup();
			buttons.addButton(pelletsButton, 	  	"PELLETS");
			buttons.addButton(woodsButton,		  	"WOODS");
			buttons.addButton(conifersWoodButton, 	"CONIFERS");
			buttons.addButton(deciduousWoodButton,	"DECIDIOUS");
			buttons.addButton(driedWoodButton,		"DRIED");
			buttons.addButton(logsButton,			"LOGS");
			buttons.addButton(fireWoodButton,		"FIREWOOD");
			buttons.addButton(woodpulpButton,		"WOODPULP")
			
			var b:BaseButton;
			for each (b in buttons.buttons)
			{
				b.addEventListener(MouseEvent.CLICK, navClickEvent);
			}
		}
		
		public function init(data:XML) : void
		{
			// Set data
			_xml = data;
			
			var b:BaseButton;
			for each (b in buttons.buttons)
			{
				b.bLabel.text = _model.langModel[b.name.slice(0,-6)].toUpperCase();
			}
			
			if(data.defaultSection != null)
			{
				this.changeSection(data.defaultSection.toUpperCase());
			}
		}
		
		private function navClickEvent(e:MouseEvent) : void
		{
            if (e.target == pelletsButton)
            {
                this.changeSection("PELLETS");
            }
            else if (e.target == woodsButton)
            {
                this.changeSection("WOODS");
            }
            else if (e.target == conifersWoodButton)
            {
                this.changeSection("CONIFERS");
            }
            else if (e.target == deciduousWoodButton)
            {
                this.changeSection("DECIDIOUS");
            }
			else if (e.target == driedWoodButton)
			{
				this.changeSection("DRIED");
			}
			else if (e.target == logsButton)
			{
				this.changeSection("LOGS");
			}
			else if (e.target == fireWoodButton)
			{
				this.changeSection("FIREWOOD");
			}
			else if(e.target == woodpulpButton)
			{
				this.changeSection("WOODPULP");
			}
		}
	
		public function changeSection(section:String) : void
		{
			var path:String  = EcolesConfig.ASSETS_URL + _model.language + "/catalog/"; 
			var b:BaseButton = buttons.getButtonByID(section);
			
			if( b != null)
			{
				b.selected = true;
			}
			
			if(_content != null)
			{
				if(_pendingSection == null)
				{
					outroOldContent();
				}
				
				_pendingSection = section;
			}
			else
			{
				if (section == "PELLETS")
				{
					_content = new PelletsPage(_xml.pellets);
					imageLoader.load( new URLRequest( path + _xml.pellets.image) );
				}
				else if (section == "WOODS")
				{
					_content = new WoodsPage(_xml.woods);
					imageLoader.load( new URLRequest( path + _xml.woods.image) );
				}
				else if (section == "CONIFERS")
				{
					_content = new ConifersPage(_xml.conifers);
					imageLoader.load( new URLRequest( path + _xml.conifers.image) );
				}
				else if (section == "DECIDIOUS")
				{
					_content = new DecidiousPage(_xml.decidious);
					imageLoader.load( new URLRequest( path + _xml.decidious.image) );
				}
				else if (section == "DRIED")
				{
					_content = new DriedPage(_xml.dried);
					imageLoader.load( new URLRequest( path + _xml.dried.image) );
				}
				else if (section == "LOGS")
				{
					_content = new LogsPage(_xml.logs);
					imageLoader.load( new URLRequest( path + _xml.logs.image) );
				}
				else if (section == "FIREWOOD")
				{
					_content = new FirewoodPage(_xml.firewood);
					imageLoader.load( new URLRequest( path + _xml.firewood.image) );
				}
				else if (section == "WOODPULP")
				{
					_content = new WoodpulpPage(_xml.woodpulp);
					imageLoader.load( new URLRequest( path + _xml.woodpulp.image) );					
				}
				
                _content.x = CONTENT_X;
                _content.y = CONTENT_Y;
                addChild(_content);
                TweenMax.from(_content, 0.25, {ease:Sine.easeOut, alpha:0});				
			}
		}
	
        private function outroOldContent() : void
        {
            TweenMax.to(
							_content, 
							0.25, 
							{
								ease:Sine.easeOut, 
								alpha:0, 
								onComplete:function () : void
								{
									removeChild(_content);
									_content = null;
									var _loc_1:* = _pendingSection;
									_pendingSection = null;
									if (_loc_1 != null)
    								{
										changeSection(_loc_1);
									}// end if
									return;
								}// end function
							}
						);
        }
	}
	
}