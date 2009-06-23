package ${package}.control.comands.todo
{
	import ${package}.control.events.todo.BaseTodoEvent;
	import ${package}.services.todo.ITodoDelegate;
	import ${package}.services.todo.TodoDelegateFactory;
	import ${package}.view.todo.TodoPModel;
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