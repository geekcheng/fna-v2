package com.adobe.ac.samples.view.todo
{
   import com.adobe.ac.samples.control.events.todo.GetTodoListEvent;
   import com.adobe.ac.samples.control.events.todo.RemoveTodoItemEvent;
   import com.adobe.ac.samples.control.events.todo.SaveTodoItemEvent;
   import com.adobe.ac.samples.model.TodoItem;
   import com.adobe.ac.samples.model.TodoList;
   
   import mx.collections.ArrayCollection;
   
   public class TodoPModel 
   {
	[Bindable]
   	public var todoList : TodoList; // of TodoItem
      
   	[Bindable]
 	public var status:String;
 	
	[Bindable]
	public var todoItem:TodoItem;
	       
      public function TodoPModel(todoList : TodoList)
      {
      	this.status = "Application started";
      	this.todoList = todoList; // from Main ApplicationModel      	
      	newItem(); // to reset the current edited item to a new Item
      }
      
      public function getTodoList():void
      {
      	new GetTodoListEvent(this).dispatch()
      }
      public function onResultGetTodoList(event:Object):void
      {
      	this.todoList.todos = event.result as ArrayCollection;
      	newItem(); // to reset the current edited item to a new Item
      }      
      public function onFaultGetTodoList(event:Object):void
	  {
    	this.status = "TodoList refresh failed ! ("+event.toLocaleString()+")";
	  }
    
      public function newItem():void
      {
      	this.todoItem = new TodoItem();
      	this.todoItem.id=-1;
      	this.todoItem.title="";
      }
      public function removeItem():void
      {
      	new RemoveTodoItemEvent(this).dispatch();
      }
      public function onResultRemoveItem(event:Object):void
	  {
    	this.status = "Item ("+this.todoItem.id+") successfully deleted";
    	new GetTodoListEvent(this).dispatch();// to reset and refresh the dataGrid items
	  }
	  public function onFaultRemoveItem(event:Object):void
	  {
    	this.status = "Deletion failed ! ("+event.toLocaleString()+")";
	  }
      
      public function saveItem():void
      {
      	new SaveTodoItemEvent(this).dispatch()
      }
      public function onResultSaveItem(event:Object):void
	  {
    	this.status = "Item was successfully saved with ID: " + TodoItem(event.result).id;
    	new GetTodoListEvent(this).dispatch();// to reset and refresh the dataGrid items
	  }
	  public function onFaultSaveItem(event:Object):void
	  {
    	this.status = "The current item was not saved ! ("+event.toLocaleString()+")";
	  } 
       
     
     
   }
}