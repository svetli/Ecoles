package com.ecoles.views.pages.contacts.alerts {
	
	import com.magna.models.AlertModel;
	import com.ecoles.models.EcolesModel;
	
	public class ContactsFormAlert extends AlertModel {
		
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function ContactsFormAlert(pModel:EcolesModel)
		{
			type 	= "ok";
			title 	= pModel.langModel.sent;
			message = pModel.langModel.thank_you;
		}
	
		// Public Methods:
		// Protected Methods:
	}
	
}