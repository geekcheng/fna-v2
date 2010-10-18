package com.adobe.txi.todo.application
{
    import com.adobe.txi.todo.domain.TodoItem;

    public class RemoveTodoItemMessage
    {
        public var todoItem:TodoItem;
		
		public function RemoveTodoItemMessage(todoItem:TodoItem)
		{
			this.todoItem = todoItem;
		}
    }
}