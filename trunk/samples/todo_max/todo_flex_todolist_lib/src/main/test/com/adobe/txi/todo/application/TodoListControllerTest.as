package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoModel;
	import com.adobe.txi.todo.infrastructure.flexunit.EventAssert;
	
	import mx.collections.ArrayCollection;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;

	public class TodoListControllerTest
	{		
		private var todoListController:TodoListController;
		private var todoModel:TodoModel;
		
		private var dispatcherCalledFlag:Boolean;
		
		[Before]
		public function setUp():void
		{
			todoListController = new TodoListController();
			todoModel = new TodoModel();
			
			todoListController.todoModel = todoModel;
			todoListController.dispatcher = function():void {};

			dispatcherCalledFlag = false;
		}
		
		[After]
		public function tearDown():void
		{
			todoListController = null;
		}
		
		[Test]
		public function initialize():void
		{
			todoListController.dispatcher = function( m:GetTodoListMessage ):void {
				dispatcherCalledFlag = true;
			}
				
			todoListController.initialize();
			
			assertThat("GetTodoListMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
		
		[Test]
		public function testGetAll_getTodoListMessage():void
		{
			todoListController.dispatcher = function( m:GetTodoListMessage ):void {
				dispatcherCalledFlag = true;
			}
			
			todoListController.getAll();
			
			assertThat("GetTodoListMessage should have been dispatched", dispatcherCalledFlag, equalTo(true));
		}
		
		[Test]
		public function testGetAll_collectionReset():void
		{
			todoModel.todos = new ArrayCollection();
			
			todoListController.getAll();
			
			assertThat("todos collection should have been null", todoListController.todos, nullValue());
		}
		
		[Test]
		public function addNewTodoItem():void
		{
			todoModel.todos = new ArrayCollection();
			todoListController.todos = todoModel.todos;
			
			todoListController.addNewTodoItem();
			
			assertThat("todos should have one item", todoModel.todos.length, equalTo(1));
			assertThat("todoListController.currentTodoItem should be set to the new created item", todoListController.currentTodoItem , notNullValue());
		}
		
	}
}