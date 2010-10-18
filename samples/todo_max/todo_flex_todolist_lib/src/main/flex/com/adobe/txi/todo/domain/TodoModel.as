package com.adobe.txi.todo.domain
{
    import mx.collections.ArrayCollection;
    import mx.utils.ObjectUtil;

    public class TodoModel
    {
        [Bindable]
        [Publish(objectId="todos")]
        public var todos:ArrayCollection;

        [Bindable]
        [PublishSubscribe(objectId="currentTodoItem")]
        public var currentTodoItem:TodoItem;
		
    	private var _savedCurrentTodoItem:Object;

		public function backupCurrentTodoItem():void
		{
			_savedCurrentTodoItem=ObjectUtil.copy(currentTodoItem);
		}
		
		public function get savedCurentTodoItem():Object
		{
			return _savedCurrentTodoItem;
		}
		
		public function rollbackCurrentTodoItem():void
		{
			if(!_savedCurrentTodoItem)
			{
				return;
			}
			
			if (currentTodoItem.isNewTodoItem())
			{
				todos.removeItemAt(todos.getItemIndex(currentTodoItem))

				currentTodoItem=null;
			}
			else
			{
				if(savedCurentTodoItem)
				{
					currentTodoItem.title=_savedCurrentTodoItem.title;
				}
			}
		}

        public function deleteItem(todo:TodoItem):void
        {
			if(todos)
			{
	            todos.removeItemAt(todos.getItemIndex(todo));
			}
        }

        public function createNewTodoItem():TodoItem
        {
			var newItem:TodoItem;
			
			if(todos)
			{
				newItem = new TodoItem();	
				todos.addItem(newItem);
			}

            return newItem;
        }
    }
}