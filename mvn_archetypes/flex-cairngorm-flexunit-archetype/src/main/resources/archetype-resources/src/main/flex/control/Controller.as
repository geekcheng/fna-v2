package ${package}.control
{
   import com.adobe.cairngorm.control.FrontController;

   import ${package}.control.commands.users.FetchUsersCommand;
   import ${package}.control.events.users.FetchUsersEvent;
   
   public class Controller extends FrontController
   {
      public function Controller()
      {
         super();

         addCommand(
         	FetchUsersEvent.EVENT_NAME,
         	FetchUsersCommand );
      }
   }
}