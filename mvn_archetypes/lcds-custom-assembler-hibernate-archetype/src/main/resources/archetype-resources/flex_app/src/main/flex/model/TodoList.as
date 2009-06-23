package ${groupId}.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	public class TodoList
	{
		[Bindable]
   		public var todos : ListCollectionView ; // of TodoItem
		
		public function TodoList()
		{
			this.todos=new ArrayCollection();
		}
		

	}
}