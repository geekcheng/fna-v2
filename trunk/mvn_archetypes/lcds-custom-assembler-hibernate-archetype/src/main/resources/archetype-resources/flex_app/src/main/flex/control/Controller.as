package ${groupId}.control
{
   
   import com.adobe.cairngorm.control.FrontController;
   import ${groupId}.control.comands.todo.GetTodoListCommand;
   import ${groupId}.control.comands.todo.RemoveTodoItemCommand;
   import ${groupId}.control.comands.todo.SaveTodoItemCommand;
   import ${groupId}.control.events.todo.GetTodoListEvent;
   import ${groupId}.control.events.todo.RemoveTodoItemEvent;
   import ${groupId}.control.events.todo.SaveTodoItemEvent;
   
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