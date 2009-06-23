package com.adobe.ac.sample.model
{
   import com.adobe.ac.sample.model.users.TestUsersDomainModel;
   
   import flexunit.framework.TestSuite;

   public class AllModelTests extends TestSuite
   {
      public function AllModelTests()
      {
         super();
         addTestSuite( TestUsersDomainModel );         
         addTestSuite( TestModelLocator );
      }
   }
}