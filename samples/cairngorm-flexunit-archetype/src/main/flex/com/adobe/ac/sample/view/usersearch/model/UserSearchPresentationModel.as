package com.adobe.ac.sample.view.usersearch.model
{
	import com.adobe.ac.model.IPresentationModel;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.adobe.ac.sample.model.users.IUsersContainer;
	import com.adobe.ac.sample.model.users.UsersDomainModel;
	import com.adobe.ac.sample.vo.UserVO;
	
	import mx.collections.ListCollectionView;
	

	[Bindable]
	public class UserSearchPresentationModel extends EventDispatcher implements IPresentationModel, IUsersContainer
	{
	   public static const SEARCH_QUERY_CHANGED : String = "searchQueryChanged"; 
		private var _usersHolder : UsersDomainModel;
		private var _filteredUsers : ListCollectionView;
		private var _filter : String = "";
		
		public function UserSearchPresentationModel( holder : UsersDomainModel )
		{
		   super();
			_usersHolder = holder;	
		}
		
		public function search( input : String ) : void
		{
			_filter = input;
			
			if( filterEnabled )
			{
				_filteredUsers = new ListCollectionView( _usersHolder.users );				
				_filteredUsers.filterFunction = searchUserFromFilter;					
				_filteredUsers.refresh();
			}
			dispatchEvent( new Event( SEARCH_QUERY_CHANGED ) );
		}
		
		private function searchUserFromFilter( item : Object ) : Boolean
		{
			return UserVO( item ).firstname.toLowerCase().indexOf( _filter.toLowerCase() ) != -1 ||
				   UserVO( item ).lastname.toLowerCase().indexOf( _filter.toLowerCase() ) != -1;
		}
		
		[Bindable(event="searchQueryChanged")]
		public function get users() : ListCollectionView
		{
			return filterEnabled ? _filteredUsers : _usersHolder.users;
		}
		
		private function get filterEnabled() : Boolean
		{
			return _filter != "";
		}
	}
}