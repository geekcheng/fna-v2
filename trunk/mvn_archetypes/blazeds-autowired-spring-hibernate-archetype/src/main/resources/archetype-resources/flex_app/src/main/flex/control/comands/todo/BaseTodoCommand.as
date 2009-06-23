package ${package}.control.comands.todo
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import ${package}.control.events.todo.BaseTodoEvent;
	import ${package}.view.todo.TodoPModel;
	
	import mx.rpc.IResponder;
	
	public class BaseTodoCommand implements ICommand, IResponder
	{
		protected var todoPModel: TodoPModel;
		
		public function execute( event : CairngormEvent ) : void
		{
			this.todoPModel = BaseTodoEvent( event ).todoPModel;						
			this.callDelegate();
		}		
		
		protected function callDelegate() : void
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