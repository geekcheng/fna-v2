package com.adobe.txi.todo.domain
{
	import com.adobe.txi.todo.dto.TodoItemDto;
	
	[Bindable]
	public class TodoItem extends TodoItemDto
	{
		override public function get id():int
		{
			return super.id;
		}
		
		[SyncId]
		override public function set id(value:int):void
		{
			super.id = value;
		}
	}
}