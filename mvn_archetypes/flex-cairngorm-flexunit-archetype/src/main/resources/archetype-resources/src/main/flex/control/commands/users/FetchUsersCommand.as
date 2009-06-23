package ${package}.control.commands.users
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;

	import ${package}.control.events.users.FetchUsersEvent;
	import ${package}.services.users.IUsersDelegate;
	import ${package}.services.users.UsersDelegateFactory;
	
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