package com.adobe.ac.samples.model
{
   import com.adobe.ac.samples.model.users.TestUsersDomainModel;
   
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