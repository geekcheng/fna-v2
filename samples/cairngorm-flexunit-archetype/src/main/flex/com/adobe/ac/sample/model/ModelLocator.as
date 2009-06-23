package com.adobe.ac.sample.model
{
	import com.adobe.cairngorm.model.IModelLocator;

	import com.adobe.ac.sample.view.common.model.UsersManagementPresentationModel;

	public class ModelLocator implements IModelLocator
	{
		private static var _instance : ModelLocator;
		
		[Bindable]
		public var usersManager : UsersManagementPresentationModel;
		
		public function ModelLocator( enforcer : SingletonEnforcer )
		{
			usersManager = new UsersManagementPresentationModel();
		}
		
		public static function get instance() : ModelLocator
		{
			if ( _instance == null )
			{
				_instance = new ModelLocator( new SingletonEnforcer() );
			}
			return _instance;
		}
	}
}

class SingletonEnforcer{}