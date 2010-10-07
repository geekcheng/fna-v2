package com.adobe.txi.todo.application.authentication
{
	import com.adobe.txi.todo.domain.UserModel;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class LoginControllerTest
	{		
		private var loginController:LoginController;

		private var dispatcherCalledFlag:Boolean;

		private var userModel:UserModel;
		
		[Before]
		public function setUp():void
		{
			loginController = new LoginController()
			userModel = new UserModel();
			
			loginController.userModel = userModel;
			loginController.dispatcher = function():void {};
		}
		
		[Test]
		public function testLogin():void
		{
			loginController.dispatcher = function( m:LoginMessage ):void {
				dispatcherCalledFlag = true;
			}
			
			loginController.login("test","test");
			
			assertThat("LoginMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
		
		[Test]
		public function testLogout():void
		{
			loginController.dispatcher = function( m:LogoutMessage ):void {
				dispatcherCalledFlag = true;
			}
			
			loginController.logout();
			
			assertThat("LogoutMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
		
		[Test]
		public function testLoginCompleteHandler():void
		{
			assertThat("isLoggedIn should be set to false", loginController.isLoggedIn, equalTo(false));
			
			loginController.loginCompleteHandler(new LoginMessage("test","test"));
			
			assertThat("isLoggedIn should be set to true", loginController.isLoggedIn, equalTo(true));
		}
		
		[Test]
		public function testLogoutCompleteHandler():void
		{
			loginController.isLoggedIn = true;
			userModel.user = new Object();
			
			assertThat("isLoggedIn should be set to true", loginController.isLoggedIn, equalTo(true));
			assertThat("user must exist", loginController.userModel.user, notNullValue());
			
			loginController.logoutCompleteHandler(new LogoutMessage());
			
			assertThat("isLoggedIn should be set to false", loginController.isLoggedIn, equalTo(false));
			assertThat("user must be reset to null", loginController.userModel.user, nullValue());
		}
		
		
	}
}