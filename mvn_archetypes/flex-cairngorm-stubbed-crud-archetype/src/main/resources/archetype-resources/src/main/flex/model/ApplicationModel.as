package ${package}.model
{
	import mx.collections.ArrayCollection;

	public class ApplicationModel 
	{
		[Bindable]
		public var todoList:TodoList;
		
		public function ApplicationModel()
		{
			this.todoList = new TodoList();
		}
	}
}