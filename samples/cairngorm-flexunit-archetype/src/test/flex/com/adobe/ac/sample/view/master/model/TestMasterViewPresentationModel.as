package com.adobe.ac.sample.view.master.model
{
	import com.adobe.ac.sample.model.users.UsersDomainModel;
	import com.adobe.ac.sample.view.master.model.MasterViewPresentationModel;
	import com.adobe.ac.sample.vo.UserVO;
	
	import flexunit.framework.EventfulTestCase;

	public class TestMasterViewPresentationModel extends EventfulTestCase
	{
		private var myModel : MasterViewPresentationModel;
		private var user : UserVO;
		
		override public function setUp() : void
		{
			myModel = new MasterViewPresentationModel( new UsersDomainModel() );

			user = new UserVO();
			user.isOnline = false;
			user.firstname = "Xavier";
			user.lastname = "Agnetti";
		}		
		
		public function testConstructor() : void
		{
			assertNotNull( myModel.users );
		}

		public function testChangeOnlineState() : void
		{
			myModel.changeOnlineState( 0 );
			
			myModel.selectedUser = user;
			
			myModel.changeOnlineState( 0 );
			
			assertTrue( myModel.selectedUser.isOnline );
			
			myModel.changeOnlineState( 1 );
			
			assertFalse( myModel.selectedUser.isOnline );
		}
	}
}