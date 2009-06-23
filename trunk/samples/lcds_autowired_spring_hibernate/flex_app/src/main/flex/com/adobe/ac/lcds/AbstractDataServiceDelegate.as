package com.adobe.ac.lcds
{
   import mx.collections.ListCollectionView;
   import mx.data.Conflict;
   import mx.data.Conflicts;
   import mx.data.DataService;
   import mx.data.DataStore;
   import mx.data.ItemReference;
   import mx.data.events.DataConflictEvent;
   import mx.managers.CursorManager;
   import mx.rpc.AsyncToken;
   import mx.rpc.IResponder;
   
   /**
    * We assume that all DataServices belonging to this DataModel are associated.
    * As such they share a single DataStore. Based on this assumption the base-
    * methods on the DataModel only work against a single DataService - the
    * primary DataService.
    * 
    * If you need to provide more fine-grained operations you should add them to
    * your concrete implementation.
    * 
    * When working with associated DataServices, especially those with eager
    * relationships it is important to explicitly define them on the
    * ServiceLocator and to add a conflict handler. You don't need to define
    * them explicitly, but if you don't the service will be created implicitly
    * for you in the background and conflicts will be swalled silently.
    * 
    * The recommend approach is to override the <code>initialize()</code> method, which you
    * should call from <code>handleFirstShow()</code> on your PresentationModel. In initialze
    * locate your associated DataServices and register for conflicts by calling
    * <code>registerForConflict()</code>.
    * 
    * For example:
    * <code> 
    * public override function initialiaze() : void
    * {
    *    var myService : DataService = Services( serviceLocator ).myService;
    *    registerForConflict( myService );
    * }
    * <code>
    */ 
   [Bindable]
   public class AbstractDataServiceDelegate
      extends AbstractDelegate implements IDataServiceDelegate
   {
   	private const CONNECTED_PROPERTY : String = "connected";
   	
      private var dataService : DataService;
      
      public function AbstractDataServiceDelegate( service : DataService )
      {
         init( service );
         dataService = service;
      }
      
      public function fill(
         collection : ListCollectionView,
         callback : Function = null,
         ... fillParameters ) : void
      {
         releaseCollection( collection );
      	
//         fillParameters.unshift( collection );
         
         var token : AsyncToken = 
         	dataService.fill( collection, fillParameters );
         	
         CursorManager.setBusyCursor();
         	
         token.addResponder( new FillResponder( callback ) );
      }
      
      public function getItem( identity : Object, responder : IResponder ) : void
      {
         var call : AsyncToken = dataService.getItem( identity );
         call.addResponder( responder );
      }
      
      public function commit( resultHandler : Function = null ) : void
      {
      	if( dataService.dataStore.isInitialized )
      	{
      		// this wait for sending the new update until
      		// the previous one is ended
      		// this property can only be set when the dataStore is initialized
      		dataService.dataStore.commitQueueMode = DataStore.CQ_ONE_AT_A_TIME;
      	}
      	 
         if ( dataService.commitRequired )
         {
            var token : AsyncToken = dataService.commit();
            
            CursorManager.setBusyCursor();
      	   token.addResponder( new CommitResponder( resultHandler ) );
         }
      }
      
      public function rollback() : void
      {
         dataService.dataStore.revertChanges();
      }

      public function releaseCollection( collection : ListCollectionView ) : void
      {
         if ( collection != null &&
              dataService.isInitialized && 
      		  dataService.isCollectionManaged( collection ) )
      	{
      		dataService.releaseCollection( collection );
      	}
      }
      
      public function createItem( item : Object ) : ItemReference
      {
         return dataService.createItem( item );
      }
      
      public function deleteItem( item : Object ) : AsyncToken
      {
         return dataService.deleteItem( item );
      }

      protected function registerForConflict( service : DataService ) : void
      {
         if ( service != null &&
            ! service.hasEventListener( DataConflictEvent.CONFLICT ) )
         {
            service.addEventListener(
               DataConflictEvent.CONFLICT, handleConflict, false, 0, true );
         }
      }
      
      private function init( service : DataService ) : void
      {
         registerForConflict( service );
      }
      
      private function handleConflict( event : DataConflictEvent ) : void
      {
         var conflicts : Conflicts
         conflicts = dataService.conflicts;
         
         for( var i : int = 0; i < conflicts.length; i++ )
         {
            var conflict : Conflict = conflicts.getItemAt( i ) as Conflict;
            
            if( ! conflict.resolved )
            {
               conflict.acceptServer();
            }
         }   
      }      
   }
}