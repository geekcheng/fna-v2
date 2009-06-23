package
{
	import com.adobe.ac.samples.DummyTest;
	
	import flexunit.framework.TestSuite;

	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
         super();
         addTestSuite( DummyTest ); 	 
		}		
	}
}
