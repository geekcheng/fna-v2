package com.adobe.ac.samples.view.pmodel
{
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	import mx.resources.ResourceManager;
	
	[ResourceBundle("todolist")]
	public class MainModel 
	{
		[Bindable]
		public var todoList : ListCollectionView; // of TodoItem
		
		[Bindable]
		public var status:String;
		
		[Bindable]
		public var todoItem:TodoItem;
		
		[Bindable]
		public var isItemSelected:Boolean;
		
		[Bindable]
		public var availableLocales:ArrayCollection = new ArrayCollection([ "fr_FR", "en_US", "pt_BR", "nb_NO"  ]);
		[Bindable]
		public var currentLocale:String;
		public static const TODO_BUNDLE:String = "todolist";
		
		
		// TODO remove stub
		private var stubId:int = 0;
		
		public function MainModel()
		{
			this.switchLocale("fr_FR");
			this.todoItem = null;
			this.stubData(20);// TODO dispath event to fire PController.getTodoList();	
			this.isItemSelected=false;
			this.status = "Application started"; //TODO i18n the status as well
		}
		
		public function switchLocale(locale:Object):void 
		{
			this.currentLocale =  String(locale)
			ResourceManager.getInstance().localeChain = [ currentLocale ];
			this.status = "Locale changed to "+currentLocale;			
		}
		
		private function stubData(nofItems:int):void
		{
			this.todoList = new ArrayCollection();
			for (var i:int= 0; i<nofItems; i++)
			{
				var todo:TodoItem = new TodoItem();
				todo.id = i;
				todo.title = "Dummy title " + todo.id;
				this.todoList.addItem(todo);
				stubId++;
			}
		}
		
		public function refreshList():void
		{
			// TODO dispath event to fire PController.getTodoList();	
			this.status = "list refreshed";	
		}
		
		public function selectItem(selectedItem:Object):void
		{
			this.todoItem = selectedItem as TodoItem;
			var index:int = this.todoList.getItemIndex(this.todoItem);
			this.isItemSelected=true;
			this.status = "Item "+ index +" selected";	
		}
		
		public function newItem():void
		{
			var todo:TodoItem = new TodoItem();
			todo.id = stubId++;
			this.todoList.addItem(todo);
			this.todoItem = todo;	
			this.isItemSelected=true;
			this.status = "new Item prepared";			
		}
		public function removeItem():void
		{
			if (this.todoItem!=null)
			{
				var index:int = this.todoList.getItemIndex(this.todoItem);
				this.todoList.removeItemAt(index);
				this.todoItem = null;
				// TODO dispath event to fire PController.removeItem();	
				this.isItemSelected=false;
				this.status = "Item "+ index +" removed";	
			}
		}
		
		
		public function saveItem():void
		{
			// dispath event to fire PController.removeItem();	
			//new RemoveTodoItemEvent(this).dispatch();
			this.status = "TodoList Saved";
		}		
		
	}
}