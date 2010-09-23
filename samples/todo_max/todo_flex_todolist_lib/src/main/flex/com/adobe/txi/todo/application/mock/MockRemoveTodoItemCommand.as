package com.adobe.txi.todo.application.mock
{
	import com.adobe.txi.todo.application.RemoveTodoItemMessage;
	import com.adobe.txi.todo.domain.TodoModel;
	import com.adobe.txi.todo.infrastructure.task.MockASyncResultTask;
	
	import org.spicefactory.lib.task.Task;

	public class MockRemoveTodoItemCommand
	{
		[Inject]
		public var todoModel:TodoModel;
		
		public function execute(message:RemoveTodoItemMessage):Task
		{
			return new MockASyncResultTask( message.todoItem );
		}
		
		public function result(result:Object, message:RemoveTodoItemMessage):void
		{
			todoModel.deleteItem(message.todoItem);
		}
	}
}