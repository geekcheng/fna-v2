package com.adobe.ac.samples.view
{
	
	
	import com.adobe.ac.samples.view.pmodel.MainModel;
	import com.adobe.ac.samples.view.pmodel.TodoItem;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	
	public class PController
	{
		[Bindable]
		public var mainModel : MainModel;
		private static var instance : PController;
		
		private static function lock():void{};
			
			public static function init():PController
			{
				if (PController.instance == null)
				{
					PController.instance = new PController(new MainModel(),PController.lock);
				}
				return PController.instance;
				
			}     
			
			public function PController(mainModel : MainModel, lock:Object)
			{
				if (lock != PController.lock)
				{
					delete this;
					return;
				}
				else
				{
					this.mainModel = mainModel;					
				}
			}
			public function getPModel():MainModel
			{
				return this.mainModel;
			}
			
			/*public static function getTodoList():void
			{
				// TODO server call
			}*/
			
			public function onResultGetTodoList(event:Object):void
			{
				this.mainModel.todoList = event.result as ArrayCollection;
				//newItem(); // to reset the current edited item to a new Item
			}      
			public function onFaultGetTodoList(event:Object):void
			{
				this.mainModel.status = "TodoList refresh failed ! ("+event.toLocaleString()+")";
			}
			
			/*public static function removeItem():void
			{
				// TODO server call
			}*/
			
			public function onResultRemoveItem(event:Object):void
			{
				this.mainModel.status = "Item ("+this.mainModel.todoItem.id+") successfully deleted";
				//new GetTodoListEvent(this).dispatch();// to reset and refresh the dataGrid items
			}
			public function onFaultRemoveItem(event:Object):void
			{
				this.mainModel.status = "Deletion failed ! ("+event.toLocaleString()+")";
			}
			
			/*public static function saveItem():void
			{
				//new SaveTodoItemEvent(this).dispatch()
			}*/
			public function onResultSaveItem(event:Object):void
			{
				this.mainModel.status = "Item was successfully saved with ID: " + TodoItem(event.result).id;
				//new GetTodoListEvent(this).dispatch();// to reset and refresh the dataGrid items
			}
			public function onFaultSaveItem(event:Object):void
			{
				this.mainModel.status = "The current item was not saved ! ("+event.toLocaleString()+")";
			} 
			
			
			
	}
}