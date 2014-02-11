package com.ecoles.models {
	
	import flash.events.*;
	import com.magna.models.AbstractModel;
	
	public class EcolesModel extends AbstractModel {	
		// Initialization:
		public function EcolesModel() {
			this.isFirstTime 	= true;
			this.isBeta		 	= true;
			this.errorMessage	= "";
			this.queryString	= "";
			this.language		= "it";
		}
	}
	
}