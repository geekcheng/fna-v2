package com.adobe.ac.samples.services
{
	import com.adobe.ac.samples.services.users.UsersDelegateFactory;
	import com.adobe.ac.samples.services.users.impl.StubbedUsersDelegate;
	import com.adobe.ac.samples.services.users.impl.XmlUsersDelegate;
	
	import flexunit.framework.TestCase;

	public class TestUsersDelegateFactory extends TestCase
	{
		public function testCreate() : void
		{
			try
			{
				new MyServiceLocator();
			}
			catch( e : Error ) 
			{
			}
			assertTrue( UsersDelegateFactory.create( UsersDelegateFactory.XML ) is XmlUsersDelegate );
			assertFalse( UsersDelegateFactory.create( UsersDelegateFactory.XML ) is StubbedUsersDelegate );
			assertTrue( UsersDelegateFactory.create( UsersDelegateFactory.STUBBED ) is StubbedUsersDelegate);
			assertFalse( UsersDelegateFactory.create( UsersDelegateFactory.STUBBED ) is XmlUsersDelegate );
			try
			{
				UsersDelegateFactory.create( "unknown" );
				fail();
			}
			catch( e : Error )
			{
			}
		}
	}
}