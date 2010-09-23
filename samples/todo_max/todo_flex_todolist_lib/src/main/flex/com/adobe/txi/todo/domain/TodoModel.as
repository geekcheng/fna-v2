package com.adobe.txi.todo.domain
{
	import mx.collections.ArrayCollection;

	public class TodoModel
	{
		[Bindable]
		[Publish(objectId="todos")]
		public var todos:ArrayCollection;
		
		[Bindable]
		[PublishSubscribe(objectId="currentTodoItem")]
		public var currentTodoItem:TodoItem;
		
		public function checkAllItems():void
		{
			for each( var todo:TodoItem in todos)
			{
				todo.check = true;
			}
		}
		
		public function changeCheckedTodoItemsToComplete():void
		{
			for each( var todo:TodoItem in todos)
			{
				if( todo.check )
				{
					todo.completed = true;
				}
			}
		}
		
		public function deleteItem(todo:Object):void
		{
			todos.removeItemAt(todos.getItemIndex(todo));
		}
		
		public function createNewTodoItem():Object
		{
			var newItem:TodoItem= new TodoItem();
			newItem.creationDate = new Date();
			
			return newItem;
		}
	}
}