package ${package}.services.todo
{
	import mx.core.Application;
	import mx.rpc.IResponder;
	
	public class TodoDelegateFactory
	{
		// by default the application is stubbed.
		// unless isStubbed flashvar states otherwise
		private var _isStubbed:Boolean = true;
		
		public function TodoDelegateFactory()
		{
			var flashvarStubbed:String = Application.application.parameters["isStubbed"];
			if (flashvarStubbed == "false")
				_isStubbed	= false;	
		}

		public function getTodoDelegate(responder:IResponder):ITodoDelegate
		{
			return _isStubbed ?
					new StubTodoDelegate(responder) :
					new RemoteTodoDelegate(responder);
		}

	}
}