package com.adobe.ac.sample.vo
{
   import flexunit.framework.TestSuite;
   
   public class AllVOTests extends TestSuite
   {
      public function AllVOTests()
      {
         super();
         addTestSuite( TestUserVO );
      }
   }
}