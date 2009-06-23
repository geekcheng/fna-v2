package com.adobe.ac.samples.control.comands.todo
{
	import com.adobe.ac.samples.services.todo.ITodoDelegate;
	
	public class SaveTodoItemCommand extends BaseTodoCommand 
	{
		override protected function callDelegate(delegate : ITodoDelegate):void
		{
			delegate.save(this.todoPModel.todoItem);
		}
		
		override public function result( event : Object ) : void
		{				
			this.todoPModel.onResultSaveItem(event);	
		}		
	
		override public function fault( event : Object ) : void
		{
			this.todoPModel.onFaultSaveItem(event);
		}
		
	}
}