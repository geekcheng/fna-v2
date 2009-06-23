package com.adobe.ac.samples.view.common.model
{
   import com.adobe.ac.samples.control.events.users.FetchUsersEvent;
   import com.adobe.ac.samples.utils.AbstractUsersContainerTestCase;
   
   import flexunit.framework.CairngormEventSource;
   
   import mx.collections.ArrayCollection;
   import mx.collections.ListCollectionView;

   public class TestUsersManagerPresentationModel extends AbstractUsersContainerTestCase
   {
      private var usersManager : UsersManagementPresentationModel;

      override  public function setUp():void
      {
         usersManager = new UsersManagementPresentationModel();
      }
      
      public function testGetUsers() : void
      {
      	listenForEvent(
      		CairngormEventSource.instance,
      		FetchUsersEvent.EVENT_NAME );
      		
      	usersManager.getUsers();
      	
      	assertEvents();

      	assertNotNull(
      		FetchUsersEvent( lastDispatchedExpectedEvent ).model );
      
     	assertEquals(
     		usersManager,
     		FetchUsersEvent( lastDispatchedExpectedEvent ).model );
      }

      public function testHandleGetUsersCallBack():void
      {
         var users : ListCollectionView = new ArrayCollection();
         
         users.addItem( firstUser );
         users.addItem( secondUser );
         users.addItem( thirdUser );         
         usersManager.handleGetUsersCallBack( users );

         assertNotNull( usersManager.buddyListModel );
         assertNotNull( usersManager.masterModel );
         assertNotNull( usersManager.userSearchModel );
         assertNotNull( usersManager.userSearchModel.users );
         assertEquals( users, usersManager.buddyListModel.users );
         assertEquals( users, usersManager.masterModel.users );
         assertEquals( users, usersManager.userSearchModel.users );

         assertNotNull( usersManager.userSearchModel.users.sort );
         assertNotNull( usersManager.userSearchModel.users.sort.fields );
         assertEquals( 2, usersManager.userSearchModel.users.sort.fields.length );
      }
   }
}