package com.adobe.txi.todo.infrastructure
{
	import flash.events.EventDispatcher;

	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

	[Event(name="itemChange", type="com.adobe.txi.todo.infrastructure.ChangeDetectorEvent")]
	public class ChangeDetector extends EventDispatcher
	{
		private var _collection:ArrayCollection;

		public function set collection(value:ArrayCollection):void
		{
			if (value && value != _collection)
			{
				if (_collection)
				{
					_collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeHandler);
				}

				_collection=value;
				_collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChangeHandler, false, 0, true);
			}
		}

		private function itemChangeHandler(event:CollectionEvent):void
		{
			var changeDetectorEvent:ChangeDetectorEvent=new ChangeDetectorEvent(ChangeDetectorEvent.ITEM_CHANGE);
			changeDetectorEvent.items=event.items;

			dispatchEvent(changeDetectorEvent);
		}
	}
}