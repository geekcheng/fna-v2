package com.adobe.ac.samples.control
{
   
   import com.adobe.cairngorm.control.FrontController;
   import com.adobe.ac.samples.control.comands.todo.GetTodoListCommand;
   import com.adobe.ac.samples.control.comands.todo.RemoveTodoItemCommand;
   import com.adobe.ac.samples.control.comands.todo.SaveTodoItemCommand;
   import com.adobe.ac.samples.control.events.todo.GetTodoListEvent;
   import com.adobe.ac.samples.control.events.todo.RemoveTodoItemEvent;
   import com.adobe.ac.samples.control.events.todo.SaveTodoItemEvent;
   
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