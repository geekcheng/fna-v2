package com.adobe.ac.samples.view.master.model
{
	import com.adobe.ac.model.IPresentationModel;

	import com.adobe.ac.samples.model.users.IUsersContainer;
	import com.adobe.ac.samples.model.users.UsersDomainModel;
	import com.adobe.ac.samples.vo.UserVO;
	
	import mx.collections.ListCollectionView;
	
	
	[Bindable]
	public class MasterViewPresentationModel implements IPresentationModel, IUsersContainer
	{
		private var _usersHolder : UsersDomainModel;
		public var selectedUser : UserVO;
		
		public function MasterViewPresentationModel( usersHolder : UsersDomainModel )
		{
			_usersHolder = usersHolder;
		}
		
		public function get users() : ListCollectionView
		{
			return _usersHolder.users;
		}
		
		public function changeOnlineState( selectedIndex : int ) : void
		{
			if( selectedUser )
			{
				selectedUser.isOnline = selectedIndex == 0;
			}
		}		
	}
}