package com.adobe.txi.todo.shell.login
{
	import com.adobe.txi.todo.application.authentication.LoginController;

	public class LoginContainerPM
	{
		[Bindable]
		public var username:String;
		
		[Bindable]
		public var password:String;
		
		[Inject]
		[Bindable]
		public var loginController:LoginController;
		
		public function login():void
		{
			loginController.login(username,password);
		}
	}
}