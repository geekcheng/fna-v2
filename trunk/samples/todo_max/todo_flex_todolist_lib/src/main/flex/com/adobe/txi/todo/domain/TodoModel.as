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

        public function deleteItem(todo:TodoItem):void
        {
            todos.removeItemAt(todos.getItemIndex(todo));
        }

        public function createNewTodoItem():TodoItem
        {
            var newItem:TodoItem = new TodoItem();

            return newItem;
        }

        public function isNewTodoItem(item:TodoItem):Boolean
        {
            return item.id == 0;
        }
    }
}