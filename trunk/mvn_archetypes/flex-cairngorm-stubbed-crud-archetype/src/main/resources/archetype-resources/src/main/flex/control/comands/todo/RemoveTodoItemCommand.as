package ${package}.control.comands.todo
{
	import ${package}.services.todo.ITodoDelegate;
	
	public class RemoveTodoItemCommand extends BaseTodoCommand 
	{
		override protected function callDelegate(delegate : ITodoDelegate):void
		{
			delegate.remove(this.todoPModel.todoItem);
		}
		
		override public function result( event : Object ) : void
		{				
			this.todoPModel.onResultRemoveItem(event);	
		}		
	
		override public function fault( event : Object ) : void
		{
			this.todoPModel.onFaultRemoveItem(event);
		}
		
	}
}