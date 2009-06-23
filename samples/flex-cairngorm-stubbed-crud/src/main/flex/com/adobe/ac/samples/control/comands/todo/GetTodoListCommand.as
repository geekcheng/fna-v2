package com.adobe.ac.samples.control.comands.todo
{
	import com.adobe.ac.samples.services.todo.ITodoDelegate;
	
	public class GetTodoListCommand extends BaseTodoCommand 
	{
		override protected function callDelegate(delegate : ITodoDelegate):void
		{
			delegate.getTodoList();
		}
		
		override public function result( event : Object ) : void
		{				
			this.todoPModel.onResultGetTodoList(event);			
		}		
	
		override public function fault( event : Object ) : void
		{
			this.todoPModel.onFaultGetTodoList(event);
		}
	}
}