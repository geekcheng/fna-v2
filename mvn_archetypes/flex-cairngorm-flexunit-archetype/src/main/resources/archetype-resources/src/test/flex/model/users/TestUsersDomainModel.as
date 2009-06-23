package ${package}.model.users
{
	import ${package}.control.events.users.FetchUsersEvent;
	import ${package}.view.common.model.UsersManagementPresentationModel;
	
	import flexunit.framework.CairngormEventSource;
	import flexunit.framework.EventfulTestCase;

	public class TestUsersDomainModel extends EventfulTestCase
	{
		private var model : UsersDomainModel = new UsersDomainModel();
		
		public function testFetchBuddyList() : void
		{
			listenForEvent(
				CairngormEventSource.instance,
				FetchUsersEvent.EVENT_NAME );
			
			model.fetchBuddyList( new UsersManagementPresentationModel() );
			
			assertEvents();
			
			assertNotNull(
				FetchUsersEvent( lastDispatchedExpectedEvent ).model );

			assertNotNull(
				FetchUsersEvent( lastDispatchedExpectedEvent.clone() ).model );
		}
	}
}