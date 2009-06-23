package com.adobe.ac.samples.services.todo
{
   import com.adobe.ac.samples.model.TodoItem;

   public interface ITodoDelegate 
   {
	function getTodoList():void;
		
	function remove(todo : TodoItem):void;
		
	function save(todo : TodoItem):void;
	
	}
}