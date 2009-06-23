package
{
	import com.adobe.ac.samples.model.AllModelTests;
	import com.adobe.ac.samples.services.AllServicesTests;
	import com.adobe.ac.samples.view.AllViewTests;
	import com.adobe.ac.samples.vo.AllVOTests;
	
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
