package com.adobe.txi.todo.application.mock
{
	import com.adobe.txi.todo.application.GetTodoListMessage;
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.domain.TodoModel;
	import com.adobe.txi.todo.infrastructure.task.MockASyncResultTask;
	
	import mx.collections.ArrayCollection;
	
	import org.spicefactory.lib.task.Task;

	public class MockGetTodoListCommand
	{
		[Inject]
		public var todoModel:TodoModel;
		
		public function execute(message:GetTodoListMessage):Task
		{
			var todoList:ArrayCollection = new ArrayCollection();
			
			var todoItem:TodoItem;
			
			todoItem = new TodoItem();			
			todoItem.id = "1";
			todoItem.creationDate = new Date();
			todoItem.title = "Todo Item One";			
			todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
			todoItem.id = "2";
			todoItem.creationDate = new Date();
			todoItem.title = "Todo Item Two";			
			todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
			todoItem.id = "3";
			todoItem.creationDate = new Date();
			todoItem.title = "Todo Item Three";			
			todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
			todoItem.id = "4";
			todoItem.creationDate = new Date();
			todoItem.title = "Todo Item Four";			
			todoList.addItem(todoItem);
			
			return new MockASyncResultTask( todoList, 3000 );
		}
		
		public function result(todoList:ArrayCollection, message:GetTodoListMessage):void
		{
			todoModel.todos = todoList;
		}
	}
}