package com.adobe.txi.todo.application
{
	import com.adobe.txi.todo.domain.TodoItem;
	import com.adobe.txi.todo.domain.TodoModel;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.utils.ObjectUtil;

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
		
		private var _savedCurrentTodoItem:Object;
		private var _currentTodoItem:TodoItem;
		private var _todos:ArrayCollection;
		
		[Inject]
		public var todoModel:TodoModel;
		
		[Subscribe(objectId="currentTodoItem")]
		public function set currentTodoItem(value:TodoItem):void
		{
			//force cancel before moving to another item
			if( currentTodoItemChanged && _currentTodoItem && _currentTodoItem != value )
			{
				cancel();				
			}
				
			//keep in memory a copy of the todo item in case of revert
			_savedCurrentTodoItem = ObjectUtil.copy(value);
			_currentTodoItem = value;
			
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
			if( value && value != _todos )
			{
				if( _todos )
				{
					_todos.removeEventListener(CollectionEvent.COLLECTION_CHANGE, currentTodoItemChangeHandler);
				}
				
				_todos = value;
				_todos.addEventListener(CollectionEvent.COLLECTION_CHANGE, currentTodoItemChangeHandler, false, 0, true );
			}
		}
		
		public function cancel():void
		{
			if( isNewItem )
			{
				_todos.removeItemAt(_todos.getItemIndex(_currentTodoItem))
				todoModel.currentTodoItem = null;
			}
			else
			{
				_currentTodoItem.title = _savedCurrentTodoItem.title;
			}
			
			invalidateCurrentTodoItemStates();
		}
		
		public function save():void
		{
			dispatcher( new SaveTodoItemMessage(_currentTodoItem) );
		}
		
		[CommandComplete]
		public function saveCompleteHandler(message:SaveTodoItemMessage):void
		{
			invalidateCurrentTodoItemStates();
		}
		
		private function currentTodoItemChangeHandler(event:CollectionEvent):void
		{
			currentTodoItemChanged = true;
		}
		
		private function invalidateCurrentTodoItemStates():void
		{
			if( _currentTodoItem && todoModel.isNewTodoItem(_currentTodoItem) )
			{
				currentTodoItemChanged = true;
				isNewItem = true;
			}
			else
			{
				currentTodoItemChanged = false;
				isNewItem = false;
			}
		}
		
		
	}
}