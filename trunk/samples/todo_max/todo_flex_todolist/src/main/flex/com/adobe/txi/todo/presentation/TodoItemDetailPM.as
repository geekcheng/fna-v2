package com.adobe.txi.todo.presentation
{
	import com.adobe.txi.todo.domain.TodoItem;

	public class TodoItemDetailPM
	{
		[Bindable]
		[Subscribe(objectId="currentTodoItem")]
		public var currentTodoItem:TodoItem;
		
		public function get canSave():Boolean
		{
			return true;
		}
		
		public function get canCancel():Boolean
		{
			return true;
		}
		
		public function save():void
		{
			
		}
			
		public function cancel():void
		{
			
		}
	}
}