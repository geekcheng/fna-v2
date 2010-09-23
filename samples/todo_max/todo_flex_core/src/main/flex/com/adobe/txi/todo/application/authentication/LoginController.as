package com.adobe.txi.todo.application.authentication
{
	public class LoginController
	{
		[Bindable]
		public var isLoggedIn:Boolean;
		
		[CommandStatus(type="com.adobe.txi.todo.application.authentication.LoginMessage")]
		[Bindable]
		public var loginInProgress:Boolean;
		
		[MessageDispatcher]
		public var dispatcher:Function;		
		
		public function login(username:String,password:String):void
		{
			dispatcher( new LoginMessage(username,password) );
		}
		
		public function logout():void
		{
			dispatcher( new LogoutMessage() );
		}
		
		[CommandComplete]
		public function loginCompleteHandler(message:LoginMessage):void
		{
			isLoggedIn=true;
		}
		
		[CommandComplete]
		public function logoutCompleteHandler(message:LogoutMessage):void
		{
			isLoggedIn=false;
		}

	}
}