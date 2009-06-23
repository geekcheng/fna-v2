package com.adobe.ac.samples.control.commands.users
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import com.adobe.ac.samples.control.events.users.FetchUsersEvent;
	import com.adobe.ac.samples.services.users.IUsersDelegate;
	import com.adobe.ac.samples.services.users.UsersDelegateFactory;
	
	public class FetchUsersCommand implements ICommand
	{
		public function execute( event : CairngormEvent ) : void
		{
			var delegate : IUsersDelegate = 
			   UsersDelegateFactory.create( UsersDelegateFactory.STUBBED );
			
			delegate.fecthUserList( FetchUsersEvent( event ).model );
		}
	}
}