package com.adobe.txi.todo.domain
{
	[Bindable]
	public class TodoItem
	{
		public var check:Boolean;
		public var completed:Boolean;
		
		public var id:String;
		public var title:String;
		public var creationDate:Date;
	}
}