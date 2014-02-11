if(typeof magna == "undefined") var magna = new Object();

magna.BrowserManager = {
	
	_flashDivId: 'index',
	_flashSWFId: 'index',
	_flashHeight: 0,
	_flashWidth: 0,
	
	getFlash: function(){
		return document.getElementById(this._flashDivId);
	},
	
	getHeight: function(){
		
		if (typeof(window.innerHeight) == "number")
			
			return Number(window.innerHeight);
			
		else if (document.documentElement && document.documentElement.clientHeight)
				
			return Number(document.documentElement.clientHeight);
			
		else if (document.body && document.body.clientHeight)
				
			return Number(document.body.clientHeight)
	},
	
	setHeight: function(value){
		
		this._flashHeight = value;
		this.getFlash().style.height = (this._flashHeight > magna.BrowserManager.getHeight()) ? value + 'px' : '100%';
	},
	
	getWidth: function(){

		if(typeof(window.innerWidth) == "number")
			
			return Number(window.innerWidth)
			
		else if (document.documentElement && document.documentElement.clientWidth)
			
			return Number(document.documentElement.clientWidth)
			
		else if (document.body && document.body.clientWidth)
			
			return Number(document.body.clientWidth);
	},
	
	setWidth: function(value){
		this._flashWidth = value;
		this.getFlash().style.width = (this._flashWidth > magna.BrowserManager.getWidth()) ? value + 'px' : '100%';
	},
	
	getScroll: function(){
		
		if (typeof(window.pageYOffset) == "number")
			
			return Number(window.pageYOffset);
			
		else if (document.documentElement && typeof(document.documentElement.scrollTop) == "number")
			
			return Number(document.documentElement.scrollTop);
			
		else if (document.body && typeof(document.body.scrollTop) == "number")
			
			return Number(document.body.scrollTop);
	},
	
	setScroll: function(value){
		
	},
	
	getTitle: function(){
		return String(document.title);
	},
	
	setTitle: function(value){
		document.title = value;
	},
	
	onResize: function() {
		magna.BrowserManager.setHeight(magna.BrowserManager._flashHeight);
		magna.BrowserManager.setWidth(magna.BrowserManager._flashWidth);
		
		var flashID = document.getElementById(magna.BrowserManager._flashSWFId)
		if(flashID.onResize){
			flashID.onResize(magna.BrowserManager._flashHeight);
		}
	},
	
	onScroll: function() {
		var flashID = document.getElementById(magna.BrowserManager._flashSWFId);
		if(flashID.onScroll){
			flashID.onScroll(magna.BrowserManager.documentY());
		}
	},
	
	onUnload: function() {
		var flashID = document.getElementById(magna.BrowserManager._flashSWFId);
		if(flashID.onUnload){
			flashID.onUnload();
		}
	}
}

window.onresize = magna.BrowserManager.onResize;
window.onscroll = magna.BrowserManager.onSCroll;

