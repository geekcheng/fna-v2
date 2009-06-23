package com.adobe.ac.sample.model
{
	import flexunit.framework.TestCase;
	
	public class TestModelLocator extends TestCase
	{
		public function testGetInstance() : void
		{
			assertNotNull( ModelLocator.instance.usersManager );
			assertNotNull( ModelLocator.instance.usersManager );
		}
	}
}