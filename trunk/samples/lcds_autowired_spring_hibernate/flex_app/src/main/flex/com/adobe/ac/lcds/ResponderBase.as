package com.adobe.ac.lcds
{
   import mx.rpc.AsyncToken;
   import mx.rpc.IResponder;
   import mx.rpc.events.ResultEvent;  

   public class ResponderBase implements IResponder
   { 
      public function result( data : Object ) : void
      {
         throw new Error("ResponderBase.result() -- Abstract method must be implemented by subclass");
      }
      
      public function fault( errorObject : Object ) : void
      { 
         var i : int = 0;    
      }
      
      protected function getRequestParameters( data : Object ) : Array
      {
         var request : AsyncToken = AsyncToken( ResultEvent( data ).token );
         
         return request.message.body as Array;
      }
   }
}