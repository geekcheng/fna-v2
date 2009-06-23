package com.adobe.ac.samples.control.events.users
{
	import com.adobe.cairngorm.control.CairngormEvent;

    import com.adobe.ac.samples.view.common.model.IGetUsersCallBack;
	
	import flash.events.Event;

	public class FetchUsersEvent extends CairngormEvent
	{
		public static const EVENT_NAME : String = "fecthUsers";
		private var _model : IGetUsersCallBack;
		
		public function FetchUsersEvent( callback : IGetUsersCallBack )
		{
			super( EVENT_NAME );
			
			_model = callback;
		}
		
		public function get model() : IGetUsersCallBack
		{
			return _model;
		}
		
		override public function clone() : Event
		{
		   return new FetchUsersEvent( model );
		}
	}
}