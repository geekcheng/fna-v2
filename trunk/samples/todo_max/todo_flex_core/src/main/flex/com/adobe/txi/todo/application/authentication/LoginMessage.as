package com.adobe.txi.todo.application.authentication
{
	public class LoginMessage
	{
		public var username:String;
		public var password:String;
		
		public function LoginMessage(username:String, password:String)
		{
			this.username = username;
			this.password = password;
		}
	}
}