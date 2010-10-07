package com.adobe.txi.todo.infrastructure
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;

	[Event(name="itemChange", type="com.adobe.txi.todo.infrastructure.ItemChangeDetectorEvent")]
	public class ItemChangeDetector extends EventDispatcher
	{
		private var _collection:ArrayCollection;
		private var _item:*;

		public function set item(value:*):void
		{
			_item = value;
			
			initializeCollection();
		}
		
		private function initializeCollection():void
		{
			if (_collection)
			{
				_collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeHandler);
			}
						
			_collection=new ArrayCollection();
			
			//add the item before listening to COLLECTION_CHANGE in order to prevent the add item change to be dispatched.
			_collection.addItem(_item);
			
			_collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeHandler, false, 0, true);
		}

		private function itemChangeHandler(event:CollectionEvent):void
		{
			if( event.items && event.items.length > 0 && event.items[0] is PropertyChangeEvent )
			{
				var changedItem:* = PropertyChangeEvent( event.items[0]).source;
				
				if( changedItem === _item )
				{
					var changeDetectorEvent:ItemChangeDetectorEvent=new ItemChangeDetectorEvent(ItemChangeDetectorEvent.ITEM_CHANGE);
					
					dispatchEvent(changeDetectorEvent);
				}
			}
			
		}

	}
}