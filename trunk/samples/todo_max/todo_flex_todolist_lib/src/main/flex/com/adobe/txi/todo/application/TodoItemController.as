package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.domain.TodoModel;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;

	public class TodoItemController
	{
		[MessageDispatcher]
		public var dispatcher:Function;

		[Bindable]
		public var currentTodoItemChanged:Boolean;

		[Bindable]
		public var isNewItem:Boolean;

		[Bindable]
		[CommandStatus(type="com.adobe.txi.todo.application.SaveTodoItemMessage")]
		public var saveInProgress:Boolean;

		private var _currentTodoItem:TodoItem;

		private var _todos:ArrayCollection;

		[Inject]
		public var todoModel:TodoModel;
		
		[Subscribe(objectId="currentTodoItem")]
		public function set currentTodoItem(value:TodoItem):void
		{
			//force cancel before moving to another item if that new item is different from null
			if ( value && currentTodoItemChanged && _currentTodoItem && _currentTodoItem != value)
			{
				cancel();
			}

			//keep in memory a copy of the todo item in case of revert
			todoModel.backupCurrentTodoItem();
			
			
			if(_currentTodoItem)
			{
				_currentTodoItem.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,propertyChangeHandler);				
			}
			
			_currentTodoItem=value;
			_currentTodoItem.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,propertyChangeHandler);

			//invalidate current states
			invalidateCurrentTodoItemStates();
		}

		[Bindable]
		public function get currentTodoItem():TodoItem
		{
			return _currentTodoItem;
		}

		[Subscribe(objectId="todos")]
		public function set todos(value:ArrayCollection):void
		{
			if (value && value != _todos)
			{
				_todos=value;
				currentTodoItemChanged=false;
			}
		}

		public function cancel():void
		{
			todoModel.rollbackCurrentTodoItem();
			
			invalidateCurrentTodoItemStates();
		}

		public function save():void
		{
			dispatcher(new SaveTodoItemMessage(_currentTodoItem));
		}

		[CommandComplete]
		public function saveCompleteHandler(message:SaveTodoItemMessage):void
		{
			//override the previous backup of the item with the new one.
			todoModel.backupCurrentTodoItem();
			
			//force an invalidation of the states
			invalidateCurrentTodoItemStates();
		}

		private function propertyChangeHandler(event:PropertyChangeEvent):void
		{
			//Make sure that the item modified is the currently edited item
			currentTodoItemChanged=true;
		}

		private function invalidateCurrentTodoItemStates():void
		{
			if (todoModel.currentTodoItem && todoModel.currentTodoItem.isNew())
			{
				currentTodoItemChanged=true;
				isNewItem=true;
			}
			else
			{
				currentTodoItemChanged=false;
				isNewItem=false;
			}
		}


	}
}