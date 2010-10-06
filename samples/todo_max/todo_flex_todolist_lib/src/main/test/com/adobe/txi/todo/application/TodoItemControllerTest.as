package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.domain.TodoModel;
	
	import mx.collections.ArrayCollection;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class TodoItemControllerTest
	{
		private var todoItemController:TodoItemController;
		private var todoModel:TodoModel;
		private var existingTodoItem:TodoItem;
		private var existingTodoItem2:TodoItem;
		private var newTodoItem:TodoItem;
		private var todos:ArrayCollection;
		
		private var dispatcherCalledFlag:Boolean;
		
		private static const TITLE_1:String = "todo Item 1";
		
		[Before]
		public function setUp():void
		{
			todoItemController = new TodoItemController();
			todoModel = new TodoModel();
			
			todos = new ArrayCollection();			
			
			todoModel.todos = todos;
			todoItemController.todos = todoModel.todos;
			todoItemController.todoModel = todoModel;
			todoItemController.dispatcher = function():void {};
			
			dispatcherCalledFlag = false;
			
			existingTodoItem = new TodoItem();
			existingTodoItem.id = 1;
			existingTodoItem.title = TITLE_1;
			
			existingTodoItem2 = new TodoItem();
			existingTodoItem2.id = 2;
			existingTodoItem2.title = "todo Item 2";
			
			todos.addItem(existingTodoItem);
			todos.addItem(existingTodoItem2);
			
			newTodoItem = new TodoItem();
		}
		
		[After]
		public function tearDown():void
		{
			todoItemController = null;
		}
		
		[Test]
		public function setCurrentTodoItem_firstTimeWithExistingTodoItem():void
		{
			todoItemController.currentTodoItem = existingTodoItem;
			
			assertThat("the currentTodoItem should be the same as existingTodoItem", existingTodoItem, equalTo(todoItemController.currentTodoItem));			
			assertThat("the currentTodoItemChanged flag should be set to false", todoItemController.currentTodoItemChanged, equalTo(false));
			assertThat("the isNewItem flag should be set to false", todoItemController.isNewItem, equalTo(false));
		}
		
		[Test]
		public function setCurrentTodoItem_firstTimeWithNewTodoItem():void
		{
			todoItemController.currentTodoItem = newTodoItem;
			
			assertThat("the currentTodoItem should be the same as newTodoItem", newTodoItem, equalTo(todoItemController.currentTodoItem));			
			assertThat("the currentTodoItemChanged flag should be set to true", todoItemController.currentTodoItemChanged, equalTo(true));
			assertThat("the isNewItem flag should be set to false", todoItemController.isNewItem, equalTo(true));
		}
		
		[Test]
		public function cancel_existingItem():void
		{
			todoItemController.currentTodoItem = existingTodoItem;
			existingTodoItem.title = "change existing Item";
			
			todoItemController.cancel();
			
			assertThat("the currentTodoItem should have been cancelled", existingTodoItem.title, equalTo(TITLE_1));
		}
		
		[Test]
		public function cancel_newItem():void
		{
			todos.addItem(newTodoItem);
			assertThat("the todos collection must contain the newTodoItem", todos.contains(newTodoItem), equalTo(true));
			
			todoModel.currentTodoItem = newTodoItem;
			todoItemController.currentTodoItem = newTodoItem;
			existingTodoItem.title = "change new Item";
			
			assertThat("the currentTodoItem should be the same as newTodoItem", newTodoItem, equalTo(todoItemController.currentTodoItem));		
			assertThat("the currentTodoItemChanged flag should be set to true", todoItemController.currentTodoItemChanged, equalTo(true));
			
			todoItemController.cancel();
			
			assertThat("the currentTodoItem should be null", todoModel.currentTodoItem, nullValue());		
			assertThat("the currentTodoItemChanged flag should be set to false", todoItemController.currentTodoItemChanged, equalTo(false));
			assertThat("the todos collection must not contain anymore the newTodoItem", todos.contains(newTodoItem), equalTo(false));
		}
		
		[Test]
		public function setCurrentTodoItem_secondTimeWithExistingTodoItem_cancel():void
		{
			todoItemController.currentTodoItem = existingTodoItem;
			existingTodoItem.title = "change existing Item";
			
			todoItemController.currentTodoItem = existingTodoItem2;
			
			assertThat("the currentTodoItem should have been cancelled", existingTodoItem.title, equalTo(TITLE_1));
		}
		
		[Test]
		public function save():void
		{
			todoItemController.dispatcher = function( m:SaveTodoItemMessage ):void {
				dispatcherCalledFlag = true;
			}
			
			todoItemController.save();
			
			assertThat("SaveTodoItemMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
	}
}