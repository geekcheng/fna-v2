package com.adobe.ac.samples.view.buddylist.model
{	
	import com.adobe.ac.model.IPresentationModel;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.adobe.ac.samples.model.users.IUsersContainer;
	import com.adobe.ac.samples.model.users.UsersDomainModel;
	import com.adobe.ac.samples.vo.UserVO;
	
	import mx.collections.ListCollectionView;
	

	[Bindable]
	public class BuddyListPresentationModel extends EventDispatcher implements IPresentationModel, IUsersContainer
	{
	   public static const SHOW_STATE_CHANGED : String = "showStateChanged";
	   
		private var _usersHolder : UsersDomainModel;		
		private var _showAll : Boolean = true;
		private var filteredView : ListCollectionView;
		
		public function BuddyListPresentationModel( usersHolder : UsersDomainModel )
		{
		   super();
			_usersHolder = usersHolder;
		}
		
		public function switchUserVisibility() : void
		{
			_showAll = !_showAll;
			
			if ( !_showAll )
			{
				filteredView = new ListCollectionView( _usersHolder.users );
				filteredView.filterFunction = showOnlyOnlineFilterFunction;
				filteredView.refresh();				
			} 
			dispatchEvent( new Event( SHOW_STATE_CHANGED ) );
		}		
		
		private function showOnlyOnlineFilterFunction( item : Object ) : Boolean
		{
			return UserVO( item ).isOnline;
		}
		
        [Bindable("showStateChanged")]
		public function get showAll() : Boolean
		{
		   return _showAll;
		}
		
		[Bindable("showStateChanged")]
		public function get users() : ListCollectionView
		{
			return _showAll ? _usersHolder.users : filteredView;
		}
	}
}