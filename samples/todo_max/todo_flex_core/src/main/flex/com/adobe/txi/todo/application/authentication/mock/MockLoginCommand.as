package com.adobe.txi.todo.application.authentication.mock
{
	import com.adobe.txi.todo.application.authentication.LoginMessage;
	import com.adobe.txi.todo.domain.UserModel;
	import com.adobe.txi.todo.infrastructure.task.MockASyncResultTask;
	
	import org.spicefactory.lib.task.Task;

	public class MockLoginCommand
	{
		[Inject]
		public var userModel:UserModel;
		
		public function execute(message:LoginMessage):Task
		{
			var userToReturn:Object = new Object();
			userToReturn.username="test";
			
			return new MockASyncResultTask( userToReturn );
		}
		
		public function result(user:Object, message:LoginMessage):void
		{
			userModel.user = user;
		}
	}
}