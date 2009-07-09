package com.adobe.ac.samples.view.pmodel
{
	[Bindable]
	public class I18nDescriptor
	{
		public var image : String;
		public var country : String;
		public var language : String;
		public var locale : String;
				
		public function I18nDescriptor(language : String,country : String)
		{
			this.language = language;
			this.country = country;
			this.locale = this.language+"_"+this.country;

			this.image = "./assets/i18nList/"+this.locale+".png";
		}
	}
}