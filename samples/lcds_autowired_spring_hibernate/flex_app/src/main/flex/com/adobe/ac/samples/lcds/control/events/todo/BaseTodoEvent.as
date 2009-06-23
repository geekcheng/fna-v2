package com.adobe.ac.samples.lcds.control.events.todo
{
  
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.ac.samples.lcds.view.todo.TodoPModel;
	
	import flash.events.Event;

	public class BaseTodoEvent extends CairngormEvent
	{
		protected var _todoPModel : TodoPModel;
		
		public function BaseTodoEvent( eventName: String, todoPModel : TodoPModel )
		{
			super( eventName );
			this._todoPModel = todoPModel;	
		}
		
		public function get todoPModel() : TodoPModel
		{
			return _todoPModel;
		}
		
	}
}