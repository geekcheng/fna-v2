package com.adobe.txi.todo.rig
{
	import com.adobe.txi.todo.application.authentication.LoginMessage;
	
	import org.spicefactory.lib.task.Task;
	
	public class ModuleRigLoginTask extends Task
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public var username:String;
		public var password:String;

		protected override function doStart():void
		{
			dispatcher( new LoginMessage(username,password) );
		}
		
		[CommandComplete]
		public function loginComplete(message:LoginMessage):void
		{
			complete();
		}
		
		[CommandError]
		public function loginError(error:*, message:LoginMessage):void
		{
			error("");
		}
	}
}