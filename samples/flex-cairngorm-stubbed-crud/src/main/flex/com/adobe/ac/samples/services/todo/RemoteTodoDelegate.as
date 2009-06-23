package com.adobe.ac.samples.services.todo
{
   import com.adobe.ac.samples.model.TodoItem;
   
   import flash.events.EventDispatcher;
   
   import mx.rpc.IResponder;
   import mx.rpc.remoting.RemoteObject;

   public class RemoteTodoDelegate extends EventDispatcher implements ITodoDelegate
   {
	private var todoService:RemoteObject;
 	private var responder:IResponder;

	public function RemoteTodoDelegate(responder :IResponder)
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