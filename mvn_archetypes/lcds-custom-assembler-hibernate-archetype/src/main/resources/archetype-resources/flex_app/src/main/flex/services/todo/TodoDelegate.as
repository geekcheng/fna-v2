package ${groupId}.services.todo
{
   import ${groupId}.model.TodoItem;
   import ${groupId}.view.todo.TodoPModel;
   
   import flash.events.EventDispatcher;
   
   import mx.collections.ArrayCollection;
   import mx.rpc.IResponder;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.remoting.RemoteObject;

   public class TodoDelegate extends EventDispatcher
   {
	private var todoService:RemoteObject;
 	private var responder:IResponder;

	public function TodoDelegate(responder :IResponder)
	{
		this.todoService =  new RemoteObject("todoService");
    	this.responder = responder;
    }
	
	public function getTodoList():void
	{
    	var call : Object = todoService.getAll();
		call.addResponder( responder );
	}
	
	public function remove(todo : TodoItem):void
	{
		if (todo!=null)
		{
    	   	var call : Object = todoService.remove(todo.id);
			call.addResponder( responder );
		}
	}
	
	public function save(todo : TodoItem):void
	{
    	var call : Object = todoService.save(todo);
    	call.addResponder( responder );
	}
	
	}
}