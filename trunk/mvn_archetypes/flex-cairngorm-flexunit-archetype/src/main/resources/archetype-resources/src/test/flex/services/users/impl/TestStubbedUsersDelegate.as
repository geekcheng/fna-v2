package ${package}.services.users.impl
{
   import ${package}.view.common.model.UsersManagementPresentationModel;
   
   import flexunit.framework.TestCase;

   public class TestStubbedUsersDelegate extends TestCase 
   {
      private var delegate : StubbedUsersDelegate;
      
      override  public function setUp():void
      {
         delegate = new StubbedUsersDelegate();
      }

      public function testFecthUserList():void
      {
         var usersManager : UsersManagementPresentationModel = new UsersManagementPresentationModel();
         
         delegate.fecthUserList( usersManager );
         
         assertNotNull( usersManager.masterModel );
         assertNotNull( usersManager.masterModel.users );
         assertEquals( 5, usersManager.masterModel.users.length );
      }
   }
}
