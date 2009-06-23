package ${package}.services.todo
{
   import ${package}.model.TodoItem;
   
   import flash.events.EventDispatcher;
   
   import mx.collections.ArrayCollection;
   import mx.core.Application;
   import mx.managers.ISystemManager;
   import mx.rpc.IResponder;
   import mx.rpc.events.ResultEvent;

	// Mixin : http://flexonrails.net/?p=66
	
   [Mixin]
   public class StubTodoDelegate extends EventDispatcher implements ITodoDelegate
   {
 	private var responder:IResponder;
 	
 	private static var currentId:int=0;
 	private static var todos:ArrayCollection= new ArrayCollection();
 	public static function init (systemManager : ISystemManager):void
  	{
    	todos.addItem(createTodo("Register for MAX 2008"));
		todos.addItem(createTodo("Attend 'Flex for Java Architects'"));
		todos.addItem(createTodo("Go back home to try this maven archetype by myself"));
		todos.addItem(createTodo("Send feedback"));
  	}
	private static function createTodo(title:String):TodoItem
	{
		var todoItem:TodoItem = new TodoItem();
		currentId++;
		todoItem.id=currentId;
		todoItem.title=title;
		return todoItem;
	}

	public function StubTodoDelegate(responder :IResponder)
	{
    	this.responder = responder;
    }
	
	public function getTodoList():void
	{
		var resultEvent:ResultEvent = ResultEvent.createEvent(todos);
		Application.application.callLater(responder.result, [resultEvent]);
	}
	
	public function remove(todo : TodoItem):void
	{
		var position:int = todos.getItemIndex(todo);
		if (position>=0)
			todos.removeItemAt(position);
		var resultEvent:ResultEvent = ResultEvent.createEvent(todo);
		Application.application.callLater(responder.result, [resultEvent]);
	}
	
		
	public function save(todo : TodoItem):void
	{
		todos.addItem(createTodo(todo.title));
    	var resultEvent:ResultEvent = ResultEvent.createEvent(todo);
		Application.application.callLater(responder.result, [resultEvent]);
	}
	
	}
}