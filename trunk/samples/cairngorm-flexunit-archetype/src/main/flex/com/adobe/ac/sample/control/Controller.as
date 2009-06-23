package com.adobe.ac.sample.control
{
   import com.adobe.cairngorm.control.FrontController;

   import com.adobe.ac.sample.control.commands.users.FetchUsersCommand;
   import com.adobe.ac.sample.control.events.users.FetchUsersEvent;
   
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