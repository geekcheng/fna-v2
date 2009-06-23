package ${package}.services
{
   import ${package}.services.users.impl.TestStubbedUsersDelegate;
   //import ${package}.services.users.impl.TestXmlUsersDelegate;
   
   import flexunit.framework.TestSuite;
   
   public class AllServicesTests extends TestSuite
   {
      public function AllServicesTests()
      {
         super();
         addTestSuite( TestStubbedUsersDelegate );
         //addTestSuite( TestXmlUsersDelegate );
         addTestSuite( TestUsersDelegateFactory );
      }
   }
}