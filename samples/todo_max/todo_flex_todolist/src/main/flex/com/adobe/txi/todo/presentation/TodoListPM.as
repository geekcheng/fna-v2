package com.adobe.txi.todo.presentation
{
	import com.adobe.txi.todo.application.GetTodoListMessage;
	import com.adobe.txi.todo.domain.TodoItem;
	
	import mx.collections.ArrayCollection;

	public class TodoListPM
	{
		[Bindable]
		[Subscribe(objectId="todos")]
		public var todos:ArrayCollection;
		
		[Bindable]
		[PublishSubscribe(objectId="currentTodoItem")]
		public var currentTodoItem:TodoItem;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Init]
		public function initialize():void
		{
			dispatcher( new GetTodoListMessage() );	
		}
	}
}