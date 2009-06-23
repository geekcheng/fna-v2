package ${groupId}.control.comands.todo
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import ${groupId}.control.events.todo.RemoveTodoItemEvent;
	import ${groupId}.services.todo.TodoDelegate;
	import ${groupId}.view.todo.TodoPModel;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class RemoveTodoItemCommand extends BaseTodoCommand 
	{
		override protected function callDelegate():void
		{
			var delegate : TodoDelegate = new TodoDelegate(this);					
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