package com.adobe.txi.todo.infrastructure
{
	import flash.events.Event;
	
	public class ChangeDetectorEvent extends Event
	{
		public static const ITEM_CHANGE:String = "itemChange";
		
		public var items:Array;
		
		public function ChangeDetectorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}