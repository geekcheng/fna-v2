package com.adobe.txi.todo.domain
{
    import com.adobe.txi.todo.dto.TodoItemDtoBase;

    [RemoteClass(alias="com.adobe.txi.todo.dto.TodoItemDto")]
    public class TodoItem extends TodoItemDtoBase
    {
		[SyncId]
		override public function get id():Number
		{
			return super.id;
		}
		
		public function isNew():Boolean
        {
            return id == 0;
        }
    }
}