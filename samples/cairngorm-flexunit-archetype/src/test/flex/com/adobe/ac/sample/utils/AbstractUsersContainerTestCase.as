package com.adobe.ac.sample.utils
{
	import com.adobe.ac.sample.vo.UserVO;
	
	import flexunit.framework.EventfulTestCase;

	public class AbstractUsersContainerTestCase extends EventfulTestCase
	{
		private var _firstUser : UserVO;
		private var _secondUser : UserVO;
		private var _thirdUser : UserVO;
		
		override public function setUp() : void
		{
			_firstUser = createUser( "Xavier", "Agnetti", false );
			_secondUser = createUser( "Francois", "Le Droff", false );
			_thirdUser = createUser( "Sam", "Woodman", false )
		}
		
		protected function get firstUser() : UserVO
		{
		   return _firstUser;
		}
		
		protected function get secondUser() : UserVO
		{
		   return _secondUser;
		}
		
		protected function get thirdUser() : UserVO
		{
		   return _thirdUser;
		}

		private function createUser( 
							firstName : String, 
							lastName : String, 
							isOnline : Boolean ) : UserVO
		{
			var user : UserVO = new UserVO();
			
			user.firstname = firstName;
			user.lastname = lastName;
			user.isOnline = isOnline;
			
			return user;
		}		
	}
}