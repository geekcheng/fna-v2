package ${package}.view.master.model
{
	import com.adobe.ac.model.IPresentationModel;

	import ${package}.model.users.IUsersContainer;
	import ${package}.model.users.UsersDomainModel;
	import ${package}.vo.UserVO;
	
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