package com.adobe.ac.sample.view
{
   import com.adobe.ac.sample.view.buddylist.model.TestBuddyListPresentationModel;
   import com.adobe.ac.sample.view.common.model.TestUsersManagerPresentationModel;
   import com.adobe.ac.sample.view.master.model.TestMasterViewPresentationModel;
   import com.adobe.ac.sample.view.usersearch.model.TestUserSearchPresentationModel;
   
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