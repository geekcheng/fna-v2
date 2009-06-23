package
{
	import ${package}.model.AllModelTests;
	import ${package}.services.AllServicesTests;
	import ${package}.view.AllViewTests;
	import ${package}.vo.AllVOTests;
	
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
