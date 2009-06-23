package com.adobe.ac.sample.view.common.model
{
   import com.adobe.ac.model.IPresentationModel;
   
   import mx.collections.ListCollectionView;
   import mx.collections.Sort;
   import mx.collections.SortField;
   
   import com.adobe.ac.sample.model.users.UsersDomainModel;
   import com.adobe.ac.sample.view.buddylist.model.BuddyListPresentationModel;
   import com.adobe.ac.sample.view.master.model.MasterViewPresentationModel;
   import com.adobe.ac.sample.view.usersearch.model.UserSearchPresentationModel;
   
   public class UsersManagementPresentationModel implements IGetUsersCallBack, IPresentationModel
   {
      [Bindable]
      public var masterModel : MasterViewPresentationModel;

      [Bindable]
      public var userSearchModel : UserSearchPresentationModel;

      [Bindable]
      public var buddyListModel : BuddyListPresentationModel;

      private var usersModel : UsersDomainModel;
      
      public function UsersManagementPresentationModel()
      {
         usersModel = new UsersDomainModel();
      }
      
      public function getUsers() : void
      {
         usersModel.fetchBuddyList( this );
      }
      
      public function handleGetUsersCallBack( usersList : ListCollectionView ) : void
      {
         var sort : Sort = new Sort();
         sort.fields = [ 
               new SortField( "isOnline" , false, true ,false ) , 
               new SortField( "lastname" , false, false,false ) ];
         usersList.sort = sort;
         usersList.refresh();

         usersModel.users = usersList; 
         masterModel = new MasterViewPresentationModel( usersModel );
         buddyListModel = new BuddyListPresentationModel( usersModel );
         userSearchModel = new UserSearchPresentationModel( usersModel ); 
      }      
   }
}