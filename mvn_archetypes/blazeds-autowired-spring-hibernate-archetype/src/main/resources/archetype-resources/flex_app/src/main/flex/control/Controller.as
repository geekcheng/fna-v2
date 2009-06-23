package ${package}.control
{
   
   import com.adobe.cairngorm.control.FrontController;
   import ${package}.control.comands.todo.GetTodoListCommand;
   import ${package}.control.comands.todo.RemoveTodoItemCommand;
   import ${package}.control.comands.todo.SaveTodoItemCommand;
   import ${package}.control.events.todo.GetTodoListEvent;
   import ${package}.control.events.todo.RemoveTodoItemEvent;
   import ${package}.control.events.todo.SaveTodoItemEvent;
   
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