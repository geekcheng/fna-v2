package ${package}.vo
{
   import flexunit.framework.TestCase;

   public class TestUserVO extends TestCase 
   {
      private var user : UserVO;
      
      override  public function setUp():void
      {
         user = new UserVO();
         user.isOnline = false;
         user.firstname = "Xavier";
         user.lastname = "Agnetti";
      }

      public function testToString():void
      {
         assertEquals( "Xavier Agnetti - Offline", user.toString() );      
         
         user.isOnline = true;   

         assertEquals( "Xavier Agnetti - Online", user.toString() );      
      }
   }
}