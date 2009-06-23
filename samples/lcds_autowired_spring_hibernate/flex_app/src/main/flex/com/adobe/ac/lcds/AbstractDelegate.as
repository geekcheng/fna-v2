package com.adobe.ac.lcds
{
   import com.adobe.cairngorm.enterprise.business.EnterpriseServiceLocator;
   
   import flash.events.EventDispatcher;
   
   [Bindable]
   public class AbstractDelegate extends EventDispatcher implements IDelegate
   {
      public function initialize() : void
      {
      }
      
      protected function get serviceLocator() : EnterpriseServiceLocator
      {
         return EnterpriseServiceLocator.getInstance();
      }      
   }
}
