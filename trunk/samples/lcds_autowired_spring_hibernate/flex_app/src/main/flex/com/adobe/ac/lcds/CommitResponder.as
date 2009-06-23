package com.adobe.ac.lcds
{
	import mx.managers.CursorManager;
	
	public class CommitResponder extends ResponderBase
	{
	   public var resultHandler : Function;
	   
	   public function CommitResponder( resultHandler : Function )
      {
         super();
         
         this.resultHandler = resultHandler;
      }
      		
		public override function result( data : Object ) : void
		{
			CursorManager.removeBusyCursor();
		   if( resultHandler != null )
		   {
		      resultHandler();
		   }
		}

      public override function fault( errorObject : Object ) : void
      {
      	CursorManager.removeBusyCursor();
         super.fault( errorObject );
      }
	}
}