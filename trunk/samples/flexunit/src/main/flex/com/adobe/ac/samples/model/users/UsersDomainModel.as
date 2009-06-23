package com.adobe.ac.samples.model.users
{
    import com.adobe.ac.model.IDomainModel;

    import com.adobe.ac.samples.control.events.users.FetchUsersEvent;
    import com.adobe.ac.samples.view.common.model.IGetUsersCallBack;

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