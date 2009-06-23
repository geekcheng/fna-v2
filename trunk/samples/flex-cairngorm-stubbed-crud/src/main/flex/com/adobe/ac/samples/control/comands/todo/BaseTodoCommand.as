package com.adobe.ac.samples.control.comands.todo
{
	import com.adobe.ac.samples.control.events.todo.BaseTodoEvent;
	import com.adobe.ac.samples.services.todo.ITodoDelegate;
	import com.adobe.ac.samples.services.todo.TodoDelegateFactory;
	import com.adobe.ac.samples.view.todo.TodoPModel;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.rpc.IResponder;
	
	public class BaseTodoCommand implements ICommand, IResponder
	{
		protected var todoPModel: TodoPModel;
		
		public function execute( event : CairngormEvent ) : void
		{
			this.todoPModel = BaseTodoEvent( event ).todoPModel;
			var delegate : ITodoDelegate = new TodoDelegateFactory().getTodoDelegate(this);								
			this.callDelegate(delegate);
		}		
		
		protected function callDelegate(delegate : ITodoDelegate) : void
		{
			throw new Error("abstract class method");
		}
		
		public function result( event : Object ) : void
		{				
			throw new Error("abstract class method");
		}
	
		public function fault( event : Object ) : void
		{
			throw new Error("abstract class method");
		}
	}
}