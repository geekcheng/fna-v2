package com.adobe.ac.lcds
{
	import mx.managers.CursorManager;
	
	public class FillResponder extends ResponderBase
	{
	   private var callbackFunction : Function;
	   
	   public function FillResponder( callback : Function = null )
      {
         super();
         
         callbackFunction = callback;
      }
      		
		public override function result( data : Object ) : void
		{
			CursorManager.removeBusyCursor();
		   if ( callbackFunction != null )
		   {
		      callbackFunction();
		   }
		}
		
		public override function fault( errorObject : Object) : void
		{
			CursorManager.removeBusyCursor();
			super.fault(errorObject );
		}
		
	}
}