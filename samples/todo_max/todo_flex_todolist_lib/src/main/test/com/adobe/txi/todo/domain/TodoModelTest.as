package com.adobe.txi.todo.domain
{
	import mx.collections.ArrayCollection;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class TodoModelTest
	{		
		private var todoModel:TodoModel;
		private var todos:ArrayCollection;
		private var item1:TodoItem;
		
		[Before]
		public function setUp():void
		{
			todoModel = new TodoModel();
			todos = new ArrayCollection();
			item1 = new TodoItem();
			item1.id = 1;
			item1.title = "item 1";
			
			todoModel.todos = todos;
		}
		
		[Test]
		public function testDeleteItem():void
		{
			todos.addItem(item1);
			
			assertThat("todos must contains item1", todos.contains(item1), equalTo(true));
			
			todoModel.deleteItem(item1);
			
			assertThat("todos do not contains item1", todos.contains(item1), equalTo(false));
		}
		
		[Test]
		public function testCreateNewItem():void
		{
			var newItem:TodoItem = todoModel.createNewTodoItem();
			
			assertThat("newItem is not null", newItem, notNullValue());
			
			assertThat("newItem id is 0", newItem.id, equalTo(0));
			
			assertThat("newItem title is null", newItem.title, nullValue());
		}
		
		[Test]
		public function testIsNewTodoItem():void
		{
			var newItem:TodoItem = todoModel.createNewTodoItem();
			
			assertThat("must return true", newItem.isNewTodoItem(), equalTo(true));
			
			assertThat("must return false", item1.isNewTodoItem(), equalTo(false));
		}
		
		[Test]
		public function testBackupCurrentTodoItem():void
		{
			assertThat("the savedCurrentTodoItem is null", todoModel.savedCurentTodoItem, nullValue());
			
			todoModel.currentTodoItem = item1;
			
			todoModel.backupCurrentTodoItem();
			
			assertThat("the savedCurrentTodoItem is a copy of item1", todoModel.savedCurentTodoItem.title, equalTo("item 1"));
			assertThat("the savedCurrentTodoItem is a copy of item1", todoModel.savedCurentTodoItem.id, equalTo(1));
		}
		
		[Test]
		public function testRollbackCurrentTodoItem_existingItem():void
		{
			todoModel.currentTodoItem = item1;
			todoModel.backupCurrentTodoItem();
			
			todoModel.currentTodoItem.title = "something else";
			
			todoModel.rollbackCurrentTodoItem();
			
			assertThat("the currentTodoItem is reverted", todoModel.currentTodoItem.title, equalTo("item 1"));
		}
		
		[Test]
		public function testRollbackCurrentTodoItem_newItem():void
		{
			todoModel.currentTodoItem = todoModel.createNewTodoItem();
			todoModel.backupCurrentTodoItem();
			
			assertThat("the todos collection contains the currentTodoItem", todoModel.todos.contains(todoModel.currentTodoItem), equalTo(true));
			
			todoModel.currentTodoItem.title = "something else";
			
			todoModel.rollbackCurrentTodoItem();
			
			assertThat("the currentTodoItem is reseted", todoModel.currentTodoItem, nullValue());
			
			assertThat("the todos collection do not contains anymore the currentTodoItem", todoModel.todos.contains(todoModel.currentTodoItem), equalTo(false));
		}
		
	}
}