package com.adobe.ac.samples.lcds.services.todo
{
   import com.adobe.ac.lcds.AbstractDataServiceDelegate;
   import com.adobe.cairngorm.enterprise.business.EnterpriseServiceLocator;
   import com.adobe.ac.samples.lcds.model.TodoItem;
   import mx.collections.ListCollectionView;
   import mx.data.DataService;
   import mx.rpc.AsyncToken;
   import mx.rpc.IResponder;

   public class TodoDelegate extends AbstractDataServiceDelegate
   {
    	private var responder:IResponder;
   
   	public function TodoDelegate(responder :IResponder)
   	{
   	   super( EnterpriseServiceLocator.getInstance().getDataService( "todo" ) );
       	this.responder = responder;
       }
   	
   	public function getTodoList( todoList : ListCollectionView ):void
   	{
   	   fill( todoList )
   	}
   	
   	public function remove(todo : TodoItem):void
   	{
   		if (todo!=null)
   		{
   		   var call : AsyncToken = deleteItem( todo );
   			
   			call.addResponder( responder );
   		}
   	}
   	
   	public function create(todo : TodoItem):void
   	{
   		if (todo!=null)
   		{
   		   var call : AsyncToken = createItem( todo );
   			
   			call.addResponder( responder );
   		}
   	}
   	
   	public function save(todo : TodoItem):void
   	{
   	   commit( responder.result );
   	}
	}
}