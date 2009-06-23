package com.adobe.ac.samples.vo
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