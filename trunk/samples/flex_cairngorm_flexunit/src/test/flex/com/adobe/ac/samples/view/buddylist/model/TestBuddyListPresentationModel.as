package com.adobe.ac.samples.view.buddylist.model
{
	import com.adobe.ac.samples.model.users.UsersDomainModel;
	import com.adobe.ac.samples.utils.AbstractUsersContainerTestCase;

	public class TestBuddyListPresentationModel extends AbstractUsersContainerTestCase
	{
		private var pm : BuddyListPresentationModel;
		
		override public function setUp() : void
		{
			super.setUp();
			pm = new BuddyListPresentationModel( new UsersDomainModel() );
			
			pm.users.addItem( firstUser );
			pm.users.addItem( secondUser );
			pm.users.addItem( thirdUser );
		}
		
		public function testSwitchUserVisibility() : void
		{
		    listenForEvent( pm, BuddyListPresentationModel.SHOW_STATE_CHANGED );
		   
			pm.switchUserVisibility();
			
			assertEquals( 0, pm.users.length );
			assertFalse( pm.showAll );
			assertEvents( "SHOW_STATE_CHANGED should have been dispatched" );

			pm.switchUserVisibility();
			
			assertEquals( 3, pm.users.length );
			assertTrue( pm.showAll );
		}
	}
}