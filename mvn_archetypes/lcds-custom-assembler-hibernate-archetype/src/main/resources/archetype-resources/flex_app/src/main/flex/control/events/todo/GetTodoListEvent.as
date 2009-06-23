package ${groupId}.control.events.todo
{
	import ${groupId}.view.todo.TodoPModel;
	
	import flash.events.Event;

	public class GetTodoListEvent extends BaseTodoEvent
	{
		public static const EVENT_NAME : String = "GetTodoListEvent";
		
		public function GetTodoListEvent( todoPModel : TodoPModel )
		{
			super( EVENT_NAME, todoPModel );
		}
		override public function clone() : Event
		{
		   return new GetTodoListEvent( _todoPModel );
		}
	}
}