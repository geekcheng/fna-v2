package com.adobe.ac.samples.lcds.control.comands.todo
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.ac.samples.lcds.control.events.todo.RemoveTodoItemEvent;
	import com.adobe.ac.samples.lcds.services.todo.TodoDelegate;
	import com.adobe.ac.samples.lcds.view.todo.TodoPModel;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class CreateTodoItemCommand extends BaseTodoCommand 
	{
		override protected function callDelegate():void
		{
			var delegate : TodoDelegate = new TodoDelegate(this);					
			delegate.create(this.todoPModel.todoItem);
		}
		
		override public function result( event : Object ) : void
		{				
			this.todoPModel.onResultCreateItem(event);	
		}		
	
		override public function fault( event : Object ) : void
		{
			this.todoPModel.onFaultCreateItem(event);
		}
		
	}
}