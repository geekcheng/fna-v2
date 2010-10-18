package com.adobe.txi.todo.application.mock
{
    import com.adobe.txi.todo.application.GetTodoListMessage;
    import com.adobe.txi.todo.domain.TodoItem;
    import com.adobe.txi.todo.domain.TodoModel;
    import com.adobe.txi.todo.infrastructure.task.MockASyncResultTask;

    import mx.collections.ArrayCollection;

    import org.spicefactory.lib.task.Task;

    public class MockGetTodoListCommand
    {

        [Inject]
        public var todoModel:TodoModel;

        public function execute(message:GetTodoListMessage):Task
        {
            var todoList:ArrayCollection = new ArrayCollection();

            var todoItem:TodoItem;

            todoItem = new TodoItem();
            todoItem.id = 1;
            todoItem.title = "Todo Item One";
            todoList.addItem(todoItem);

            todoItem = new TodoItem();
            todoItem.id = 2;
            todoItem.title = "Todo Item Two";
            todoList.addItem(todoItem);

            todoItem = new TodoItem();
            todoItem.id = 3;
            todoItem.title = "Todo Item Three";
            todoList.addItem(todoItem);

            todoItem = new TodoItem();
            todoItem.id = 4;
            todoItem.title = "Todo Item Four";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 5;
            todoItem.title = "Todo Item Five";
            todoList.addItem(todoItem);

			todoItem = new TodoItem();
            todoItem.id = 6;
            todoItem.title = "Todo Item Six";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 7;
            todoItem.title = "Todo Item Seven";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 8;
            todoItem.title = "Todo Item Eight";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 9;
            todoItem.title = "Todo Item Nine";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 10;
            todoItem.title = "Todo Item Ten";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 11;
            todoItem.title = "Todo Item Eleven";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 12;
            todoItem.title = "Todo Item Twelve";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 13;
            todoItem.title = "Todo Item Thirteen";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 14;
            todoItem.title = "Todo Item Fourteen";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 15;
            todoItem.title = "Todo Item Fifteen";
            todoList.addItem(todoItem);
			
			todoItem = new TodoItem();
            todoItem.id = 16;
            todoItem.title = "Todo Item Sixteen";
            todoList.addItem(todoItem);
			
            return new MockASyncResultTask(todoList, 3000);
        }

        public function result(todoList:ArrayCollection, message:GetTodoListMessage):void
        {
            todoModel.todos = todoList;
        }
    }
}