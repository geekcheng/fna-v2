package com.adobe.ac.samples.lcds.control
{
   
   import com.adobe.ac.samples.lcds.control.comands.todo.CreateTodoItemCommand;
   import com.adobe.ac.samples.lcds.control.comands.todo.GetTodoListCommand;
   import com.adobe.ac.samples.lcds.control.comands.todo.RemoveTodoItemCommand;
   import com.adobe.ac.samples.lcds.control.comands.todo.SaveTodoItemCommand;
   import com.adobe.ac.samples.lcds.control.events.todo.CreateTodoItemEvent;
   import com.adobe.ac.samples.lcds.control.events.todo.GetTodoListEvent;
   import com.adobe.ac.samples.lcds.control.events.todo.RemoveTodoItemEvent;
   import com.adobe.ac.samples.lcds.control.events.todo.SaveTodoItemEvent;
   import com.adobe.cairngorm.control.FrontController;
   
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
         	CreateTodoItemEvent.EVENT_NAME,
         	CreateTodoItemCommand ); 	
         	
        addCommand(
         	RemoveTodoItemEvent.EVENT_NAME,
         	RemoveTodoItemCommand );
         	
        addCommand(
         	SaveTodoItemEvent.EVENT_NAME,
         	SaveTodoItemCommand );
      }
   }
}