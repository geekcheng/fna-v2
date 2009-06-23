package ${groupId}.control.events.todo
{
	import ${groupId}.view.todo.TodoPModel;
	
	import flash.events.Event;

	public class SaveTodoItemEvent extends BaseTodoEvent
	{
		public static const EVENT_NAME : String = "SaveTodoItemEvent";
		
		public function SaveTodoItemEvent( todoPModel : TodoPModel )
		{
			super( EVENT_NAME, todoPModel );
		}
		
		override public function clone() : Event
		{
		   return new SaveTodoItemEvent( _todoPModel );
		}
	}
}