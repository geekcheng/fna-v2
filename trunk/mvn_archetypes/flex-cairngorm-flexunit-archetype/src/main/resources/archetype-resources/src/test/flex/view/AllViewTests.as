package ${package}.view
{
   import ${package}.view.buddylist.model.TestBuddyListPresentationModel;
   import ${package}.view.common.model.TestUsersManagerPresentationModel;
   import ${package}.view.master.model.TestMasterViewPresentationModel;
   import ${package}.view.usersearch.model.TestUserSearchPresentationModel;
   
   import flexunit.framework.TestSuite;
   
   public class AllViewTests extends TestSuite
   {
      public function AllViewTests()
      {
         super();
         addTestSuite( TestMasterViewPresentationModel );
         addTestSuite( TestUserSearchPresentationModel );
         addTestSuite( TestBuddyListPresentationModel );       
         addTestSuite( TestUsersManagerPresentationModel );  
      }
   }
}