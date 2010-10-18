package com.adobe.txi.todo.domain
{
    import com.adobe.txi.todo.dto.TodoItemDto;

    [RemoteClass(alias="com.adobe.txi.todo.dto.TodoItemDto")]
    public class TodoItem extends TodoItemDto
    {
		[SyncId]
		override public function get id():int
		{
			return super.id;
		}
		
		public function isNewTodoItem():Boolean
        {
            return id == 0;
        }
    }
}