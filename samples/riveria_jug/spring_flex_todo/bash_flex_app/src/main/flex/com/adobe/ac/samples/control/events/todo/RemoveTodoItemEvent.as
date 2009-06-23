package com.adobe.ac.samples.control.events.todo
{
	import com.adobe.ac.samples.view.todo.TodoPModel;
	
	import flash.events.Event;

	public class RemoveTodoItemEvent extends BaseTodoEvent
	{
		public static const EVENT_NAME : String = "RemoveTodoEvent";
		
		public function RemoveTodoItemEvent( todoPModel : TodoPModel )
		{
			super( EVENT_NAME, todoPModel );
		}
		
		override public function clone() : Event
		{
		   return new GetTodoListEvent( _todoPModel );
		}
	}
}