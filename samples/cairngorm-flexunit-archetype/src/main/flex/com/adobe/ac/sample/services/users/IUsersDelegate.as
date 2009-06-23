package com.adobe.ac.sample.services.users
{
   import com.adobe.ac.sample.view.common.model.IGetUsersCallBack;
   
   public interface IUsersDelegate
   {
      function fecthUserList( model : IGetUsersCallBack ) : void
   }
}