package com.adobe.ac.samples.control
{
   import com.adobe.cairngorm.control.FrontController;

   import com.adobe.ac.samples.control.commands.users.FetchUsersCommand;
   import com.adobe.ac.samples.control.events.users.FetchUsersEvent;
   
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