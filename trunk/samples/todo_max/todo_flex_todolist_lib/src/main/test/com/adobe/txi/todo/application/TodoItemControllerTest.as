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
		public function testSetCurrentTodoItemToNull():void
		{
			todoItemController.currentTodoItem = null;
			
			assertThat("the currentTodoItem should be null", todoItemController.currentTodoItem, equalTo(null));
		}
		
		[Test]
		public function testSetCurrentTodoItem_firstTimeWithExistingTodoItem():void
		{
			todoItemController.currentTodoItem = existingTodoItem;
			
			assertThat("the currentTodoItem should be the same as existingTodoItem", existingTodoItem, equalTo(todoItemController.currentTodoItem));			
			assertThat("the currentTodoItemChanged flag should be set to false", todoItemController.currentTodoItemChanged, equalTo(false));
			assertThat("the isNewItem flag should be set to false", todoItemController.isNewItem, equalTo(false));
		}
		
		[Test]
		public function testSetCurrentTodoItem_firstTimeWithNewTodoItem():void
		{
			todoItemController.currentTodoItem = todoModel.currentTodoItem = newTodoItem;
			
			assertThat("the currentTodoItem should be the same as newTodoItem", newTodoItem, equalTo(todoItemController.currentTodoItem));			
			assertThat("the currentTodoItemChanged flag should be set to true", todoItemController.currentTodoItemChanged, equalTo(true));
			assertThat("the isNewItem flag should be set to false", todoItemController.isNewItem, equalTo(true));
		}
		
		[Test]
		public function testCancel_existingItem():void
		{
			todoItemController.currentTodoItem = todoModel.currentTodoItem = existingTodoItem;
			existingTodoItem.title = "change existing Item";
			
			todoItemController.cancel();
			
			assertThat("the currentTodoItem should have been cancelled", existingTodoItem.title, equalTo(TITLE_1));
		}
		
		[Test]
		public function testCancel_newItem():void
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
		public function testSetCurrentTodoItem_secondTimeWithExistingTodoItem_cancel():void
		{
			todoItemController.currentTodoItem = todoModel.currentTodoItem = existingTodoItem;
			existingTodoItem.title = "change existing Item";
			
			todoItemController.currentTodoItem = existingTodoItem2;
			
			assertThat("the currentTodoItem should have been cancelled", existingTodoItem.title, equalTo(TITLE_1));
		}
		
		[Test]
		public function testSave():void
		{
			todoItemController.dispatcher = function( m:SaveTodoItemMessage ):void {
				dispatcherCalledFlag = true;
			}
			
			todoItemController.save();
			
			assertThat("SaveTodoItemMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
		
		[Test]
		public function testSaveCompleteHandler():void
		{
			todoItemController.currentTodoItemChanged = true;
			todoItemController.isNewItem = true;
			
			todoItemController.saveCompleteHandler(new SaveTodoItemMessage(new TodoItem())); 				
				
			assertThat("the currentTodoItemChanged flag must have been reset", todoItemController.currentTodoItemChanged, equalTo(false));
			assertThat("the isNewItem flag must have been reset", todoItemController.isNewItem, equalTo(false));
		}
		
		[Test]
		public function testCreateNewTodoItemThenEditAndCancel():void
		{
			//creating a new Todo Item
			var newItem:TodoItem = todoModel.createNewTodoItem();
			
			//setting the current Item to mimic the behavior of [PublishSubscribe] and [Subscribe]
			todoModel.currentTodoItem = newItem;
			todoItemController.currentTodoItem = newItem; 
			
			//simulate the user typing a title ...
			todoItemController.currentTodoItem.title = TITLE_1;
			
			//saving the new Todo Item
			todoItemController.save();
			
			//This is to mimic the result coming back with a valid ID
			todoItemController.currentTodoItem.id = 1;

			//simulate the result callback of the command operation
			todoItemController.saveCompleteHandler(new SaveTodoItemMessage(null));
						
			assertThat("the currentTodoItem should have the initial title", todoItemController.currentTodoItem.title, equalTo(TITLE_1));
			
			todoItemController.currentTodoItem.title = TITLE_1 + "change";
			
			todoItemController.cancel();
			
			assertThat("the currentTodoItem should have the initial title", todoItemController.currentTodoItem.title, equalTo(TITLE_1));
		}
	}
}