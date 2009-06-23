package com.adobe.ac.samples.lcds.control.events.todo
{
	import com.adobe.ac.samples.lcds.view.todo.TodoPModel;
	
	import flash.events.Event;

	public class CreateTodoItemEvent extends BaseTodoEvent
	{
		public static const EVENT_NAME : String = "CreateTodoItemEvent";
		
		public function CreateTodoItemEvent( todoPModel : TodoPModel )
		{
			super( EVENT_NAME, todoPModel );
		}
		
		override public function clone() : Event
		{
		   return new CreateTodoItemEvent( _todoPModel );
		}
	}
}