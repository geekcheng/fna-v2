package ${package}.services.users.impl
{
   import com.adobe.cairngorm.business.ServiceLocator;

   import ${package}.services.MyServiceLocator;
   import ${package}.services.users.IUsersDelegate;
   import ${package}.view.common.model.IGetUsersCallBack;
   import ${package}.vo.UserVO;
   
   import flash.events.EventDispatcher;
   
   import mx.collections.ArrayCollection;
   import mx.collections.ListCollectionView;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;

   public class XmlUsersDelegate extends EventDispatcher implements IUsersDelegate
   {
      private var _callback : IGetUsersCallBack;
      
      public function XmlUsersDelegate()
      {
         super();
         service.addEventListener( ResultEvent.RESULT, handleResult );
      }

      public function fecthUserList( model : IGetUsersCallBack ) : void
      {
         _callback = model;
         service.send();
      }
      
      private function handleResult( e : ResultEvent ) : void
      {
         var users : ListCollectionView = new ArrayCollection();
         
         for each ( var xml : XML in XML( e.result ).user )
         {
            var user : UserVO = new UserVO();
            
            user.firstname = xml.@firstname;
            user.lastname = xml.@lastname;
            user.isOnline = xml.@online == "true";
            users.addItem( user );
         }
         _callback.handleGetUsersCallBack( users );
         dispatchEvent( e.clone() );
      }
      
      private function get service() : HTTPService
      {
         return MyServiceLocator( ServiceLocator.getInstance() ).users;
      } 
   }
}