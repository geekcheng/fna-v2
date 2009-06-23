package com.adobe.ac.samples.services
{
   import com.adobe.ac.samples.services.users.impl.TestStubbedUsersDelegate;
   
   import flexunit.framework.TestSuite;
   
   public class AllServicesTests extends TestSuite
   {
      public function AllServicesTests()
      {
         super();
         addTestSuite( TestStubbedUsersDelegate );
         addTestSuite( TestUsersDelegateFactory );
      }
   }
}