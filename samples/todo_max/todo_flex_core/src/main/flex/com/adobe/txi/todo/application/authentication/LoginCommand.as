package com.adobe.txi.todo.application.authentication
{
	import com.adobe.txi.todo.domain.UserModel;
	
	import mx.controls.Alert;
	import mx.rpc.remoting.RemoteObject;
	
	import org.spicefactory.lib.task.SequentialTaskGroup;
	import org.spicefactory.lib.task.Task;
	
	public class LoginCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[Inject]
		public var userModel:UserModel;
		
		public function execute(message:LoginMessage):Task
		{
			var taskGroup:SequentialTaskGroup = new SequentialTaskGroup();
			taskGroup.addTask( new LoginChannelSetTask(service,message.username,message.password) );
			taskGroup.addTask( new GetCurrentUserTask(service,userModel) );
			
			return taskGroup;
		}

	}
}