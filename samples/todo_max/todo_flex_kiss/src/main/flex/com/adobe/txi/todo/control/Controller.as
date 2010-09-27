package com.adobe.txi.todo.control
{
   
   import com.adobe.cairngorm.control.FrontController;
   import com.adobe.txi.todo.control.comands.todo.GetTodoListCommand;
   import com.adobe.txi.todo.control.comands.todo.RemoveTodoItemCommand;
   import com.adobe.txi.todo.control.comands.todo.SaveTodoItemCommand;
   import com.adobe.txi.todo.control.events.todo.GetTodoListEvent;
   import com.adobe.txi.todo.control.events.todo.RemoveTodoItemEvent;
   import com.adobe.txi.todo.control.events.todo.SaveTodoItemEvent;
   
   public class Controller extends FrontController
   {
      public function Controller()
      {
         super();
         addTodoCommands();
      }
      
      private function addTodoCommands():void
      {
      	addCommand(
         	GetTodoListEvent.EVENT_NAME,
         	GetTodoListCommand );
         	
        addCommand(
         	RemoveTodoItemEvent.EVENT_NAME,
         	RemoveTodoItemCommand );
         	
        addCommand(
         	SaveTodoItemEvent.EVENT_NAME,
         	SaveTodoItemCommand );
      }
   }
}