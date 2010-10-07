package com.adobe.txi.todo.infrastructure
{
	import com.adobe.txi.todo.infrastructure.flexunit.EventAssert;
	
	import mx.collections.ArrayCollection;

	public class ItemChangeDetectorTest
	{		
		private var itemChangeDetector:ItemChangeDetector;
		private var collection:ArrayCollection;
		private var item:Item;
		
		[Before]
		public function setUp():void
		{
			itemChangeDetector = new ItemChangeDetector();
		
			collection = new ArrayCollection();
			item = new Item();
			item.title = "this is an object";
			
			collection.addItem(item);
			
			itemChangeDetector.item = item;
		}
		
		[Test(async, timeout="500")]
		public function testItemChange():void
		{
			EventAssert.addAsyncEventAssertion(this, itemChangeDetector, ItemChangeDetectorEvent.ITEM_CHANGE);
			item.title = "this is another title for the same object";
		}
		
	}
}

[Bindable]
class Item
{
	public var title:String;
}