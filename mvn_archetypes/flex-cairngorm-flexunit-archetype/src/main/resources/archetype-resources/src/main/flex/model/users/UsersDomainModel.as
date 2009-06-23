package ${package}.model.users
{
   import com.adobe.ac.model.IDomainModel;

   import ${package}.control.events.users.FetchUsersEvent;
   import ${package}.view.common.model.IGetUsersCallBack;
   
   import mx.collections.ArrayCollection;
   import mx.collections.ListCollectionView;

	public class UsersDomainModel implements IDomainModel, IUsersContainer
	{
		public function UsersDomainModel()
		{
		}

      	[Bindable]
		public var users : ListCollectionView = new ArrayCollection(); // of UserVO
		
		public function fetchBuddyList( callback : IGetUsersCallBack ) : void
		{
			new FetchUsersEvent( callback ).dispatch()
		}
	}
}