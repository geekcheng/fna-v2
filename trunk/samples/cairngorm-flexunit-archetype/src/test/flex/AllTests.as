package
{
	import com.adobe.ac.sample.model.AllModelTests;
	import com.adobe.ac.sample.services.AllServicesTests;
	import com.adobe.ac.sample.view.AllViewTests;
	import com.adobe.ac.sample.vo.AllVOTests;
	
	import flexunit.framework.TestSuite;

	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
           super();
		   addTest( new AllModelTests() );
		   addTest( new AllViewTests() );
		   addTest( new AllVOTests() );
		   addTest( new AllServicesTests() );
		}		
	}
}
