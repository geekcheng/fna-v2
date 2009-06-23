/*

Copyright (c) 2008. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/

package flexunit.framework
{
   import com.adobe.cairngorm.control.CairngormEvent;
   import com.adobe.cairngorm.control.CairngormEventDispatcher;
   
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   /**
    * Singleton that adapts the CairngormEventDispatcher to the IEventDispatcher
    * interface, so that it can be used as a source parameter in eventful test
    * cases.
    */ 
   public class CairngormEventSource implements IEventDispatcher
   {
      private static var _instance : IEventDispatcher = 
         new CairngormEventSource();
      
      private static var cairngormEventDispatcher : CairngormEventDispatcher = 
         CairngormEventDispatcher.getInstance();
      
      public static function get instance() : IEventDispatcher
      {
         return _instance;
      }

      public function addEventListener(
         type : String, 
         listener : Function, 
         useCapture : Boolean = false, 
         priority : int = 0.0, 
         useWeakReference : Boolean = false ) : void
      {
         cairngormEventDispatcher.addEventListener(
            type,
            listener,
            useCapture,
            priority,
            useWeakReference );
      }
      
      public function removeEventListener(
         type : String, 
         listener : Function, 
         useCapture : Boolean = false ) : void
      {
         cairngormEventDispatcher.removeEventListener(
            type,
            listener,
            useCapture );
      }
      
      public function dispatchEvent( event : Event ) : Boolean
      {
         if ( event is CairngormEvent )
         {
            return cairngormEventDispatcher.dispatchEvent( 
               CairngormEvent( event ) );
         }
         
         return true;
      }
      
      public function hasEventListener( type : String ) : Boolean
      {
         return cairngormEventDispatcher.hasEventListener( type );
      }
      
      public function willTrigger( type : String ) : Boolean
      {
         return cairngormEventDispatcher.willTrigger( type );
      }
   }
}