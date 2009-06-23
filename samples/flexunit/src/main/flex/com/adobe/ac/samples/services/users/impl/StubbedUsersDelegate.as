package com.adobe.ac.samples.services.users.impl
{
   import com.adobe.ac.samples.services.users.IUsersDelegate;
   import com.adobe.ac.samples.view.common.model.IGetUsersCallBack;
   import com.adobe.ac.samples.vo.UserVO;
   
   import mx.managers.ISystemManager;
   import mx.collections.ArrayCollection;
   import mx.collections.ListCollectionView;
  
   [Mixin]
   public class StubbedUsersDelegate implements IUsersDelegate
   {
      private static var users : ListCollectionView;
      
      public static function init (systemManager : ISystemManager ):void
   	  {
         users = new ArrayCollection();
         users.addItem( createNewUser( "Xavier" , "Agnetti" , false ) );
         users.addItem( createNewUser( "Francois" , "Le Droff" , true ) );
         users.addItem( createNewUser( "Peter" , "Martin" , false ) );
         users.addItem( createNewUser( "Steven" , "Webster" , true ) );
         users.addItem( createNewUser( "Alistair" , "McLeod" , true ) );
   	  }

      public function fecthUserList( model : IGetUsersCallBack ) : void
      {
         model.handleGetUsersCallBack( users );
      }

      private static function createNewUser( firstName : String , lastName : String , isOnline : Boolean ) : UserVO
      {
         var user : UserVO = new UserVO();
       
         user.firstname = firstName;
         user.lastname = lastName;
         user.isOnline = isOnline;
         return user;
      }
   }
}
