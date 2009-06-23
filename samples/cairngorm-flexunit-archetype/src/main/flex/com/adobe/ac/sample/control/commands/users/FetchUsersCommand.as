package com.adobe.ac.sample.control.commands.users
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import com.adobe.ac.sample.control.events.users.FetchUsersEvent;
	import com.adobe.ac.sample.services.users.IUsersDelegate;
	import com.adobe.ac.sample.services.users.UsersDelegateFactory;
	
	public class FetchUsersCommand implements ICommand
	{
		public function execute( event : CairngormEvent ) : void
		{
			var delegate : IUsersDelegate = 
			   UsersDelegateFactory.create( UsersDelegateFactory.XML );
			
			delegate.fecthUserList( FetchUsersEvent( event ).model );
		}
	}
}