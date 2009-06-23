package com.adobe.ac.sample.services
{
   import com.adobe.ac.sample.services.users.impl.TestStubbedUsersDelegate;
   import com.adobe.ac.sample.services.users.impl.TestXmlUsersDelegate;
   
   import flexunit.framework.TestSuite;
   
   public class AllServicesTests extends TestSuite
   {
      public function AllServicesTests()
      {
         super();
         addTestSuite( TestStubbedUsersDelegate );
         addTestSuite( TestXmlUsersDelegate );
         addTestSuite( TestUsersDelegateFactory );
      }
   }
}