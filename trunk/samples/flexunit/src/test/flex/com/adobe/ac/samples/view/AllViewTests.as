package com.adobe.ac.samples.view
{
   import com.adobe.ac.samples.view.buddylist.model.TestBuddyListPresentationModel;
   import com.adobe.ac.samples.view.common.model.TestUsersManagerPresentationModel;
   import com.adobe.ac.samples.view.master.model.TestMasterViewPresentationModel;
   import com.adobe.ac.samples.view.usersearch.model.TestUserSearchPresentationModel;
   
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