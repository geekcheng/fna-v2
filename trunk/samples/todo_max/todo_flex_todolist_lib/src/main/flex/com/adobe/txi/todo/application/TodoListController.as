package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.domain.TodoModel;
	
	import mx.collections.ArrayCollection;

	public class TodoListController
	{
		private var _todoModel:TodoModel;
		
		[Bindable]
		[CommandStatus(type="com.adobe.txi.todo.application.GetTodoListMessage")]
		public var getAllInProgress:Boolean;
		
		[Bindable]
		[PublishSubscribe(objectId="currentTodoItem")]
		public var currentTodoItem:TodoItem;
				
		[Bindable]
		[Subscribe(objectId="todos")]
		public var todos:ArrayCollection;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Init]
		public function initialize():void
		{
			getAll();
		}
		
		[Inject]
		public function set todoModel(value:TodoModel):void
		{
			_todoModel = value;
		}
		
		public function getAll():void
		{
			//reset the current list
			_todoModel.todos = null;
			
			//call server operation
			dispatcher( new GetTodoListMessage() );	
		}
		
		
	
	}
}