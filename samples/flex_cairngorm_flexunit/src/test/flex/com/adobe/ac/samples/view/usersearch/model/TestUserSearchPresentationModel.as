package com.adobe.ac.samples.view.usersearch.model
{
	import com.adobe.ac.samples.model.users.UsersDomainModel;
	import com.adobe.ac.samples.utils.AbstractUsersContainerTestCase;

	public class TestUserSearchPresentationModel extends AbstractUsersContainerTestCase
	{
		private var pm : UserSearchPresentationModel;
		
		override public function setUp() : void
		{
			super.setUp();

			pm = new UserSearchPresentationModel( new UsersDomainModel() );
			
			pm.users.addItem( firstUser );
			pm.users.addItem( secondUser );
			pm.users.addItem( thirdUser );
		}
				
		public function testSearch() : void
		{
		   listenForEvent( pm, UserSearchPresentationModel.SEARCH_QUERY_CHANGED );
		   
			pm.search( "h" );
			
			assertEquals( 0, pm.users.length );
			assertEvents( "SEARCH_QUERY_CHANGED event should have been dispatched" );
			
			pm.search( "" );

			assertEquals( 3, pm.users.length );

			pm.search( "X" );

			assertEquals( 1, pm.users.length );

			pm.search( "x" );

			assertEquals( 1, pm.users.length );
		}
	}
}