package com.adobe.ac.lcds.events
{
   import flash.events.Event;

   public class SessionTimeoutEvent extends Event
   {
      public static const EVENT_NAME : String = "sessionTimeoutEvent";
   		
      public function SessionTimeoutEvent()
      {
        super( EVENT_NAME );
      }      
   }
}