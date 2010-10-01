package com.adobe.txi.todo.application
{
	import com.adobe.cairngorm.integration.data.IDataCache;
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.dto.TodoItemDto;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;

	public class SaveTodoItemCommand
	{
		[Inject(id="todoService")]
		public var service:RemoteObject;
		
		/*[Inject]
		public var cache:IDataCache;*/
		
		public function execute(message:SaveTodoItemMessage):AsyncToken
		{
			return service.save( new Object() );
		}
		
		public function result(todoItem:TodoItem, message:SaveTodoItemMessage):void
		{
			//cache.updateItem(message.todoItem, todoItem);
			message.todoItem.id = todoItem.id;
		}
		
		public function error(result:FaultEvent):void
		{
			Alert.show("error");
		}
	}
}