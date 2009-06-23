package ${package}.services.todo
{
   import ${package}.model.TodoItem;

   public interface ITodoDelegate 
   {
	function getTodoList():void;
		
	function remove(todo : TodoItem):void;
		
	function save(todo : TodoItem):void;
	
	}
}