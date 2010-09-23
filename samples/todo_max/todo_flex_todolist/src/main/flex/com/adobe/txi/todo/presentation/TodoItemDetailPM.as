package com.adobe.txi.todo.presentation
{
	public class TodoItemDetailPM
	{
		[Bindable]
		[PublishSubscribe(objectId="currentTodoItem")]
		public var currentTodoItem:Object;
	}
}