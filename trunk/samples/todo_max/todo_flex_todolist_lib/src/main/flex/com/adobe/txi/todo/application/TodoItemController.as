package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoItem;

	public class TodoItemController
	{
		[Bindable]
		[PublishSubscribe(objectId="currentTodoItem")]
		public var currentTodoItem:TodoItem;
	}
}