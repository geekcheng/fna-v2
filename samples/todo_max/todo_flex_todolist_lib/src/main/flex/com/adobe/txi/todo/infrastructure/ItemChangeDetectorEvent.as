package com.adobe.txi.todo.infrastructure
{
	import flash.events.Event;
	
	public class ItemChangeDetectorEvent extends Event
	{
		public static const ITEM_CHANGE:String = "itemChange";
		
		public function ItemChangeDetectorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}