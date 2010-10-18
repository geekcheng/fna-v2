package com.adobe.txi.todo.list
{
	import com.adobe.txi.todo.domain.TodoItem;
	
	import flash.events.Event;
	
	public class DeleteTodoItemEvent extends Event
	{
		public static const DELETE_TODO_ITEM:String = "deleteTodoItem";
		
		public var item:TodoItem;
		
		public function DeleteTodoItemEvent(todoItem:TodoItem)
		{
			super(DELETE_TODO_ITEM, false, false);
			
			item = todoItem;
		}
	}
}