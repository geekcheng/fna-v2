package com.adobe.ac.samples.services.users
{
   import com.adobe.ac.samples.view.common.model.IGetUsersCallBack;
   
   public interface IUsersDelegate
   {
      function fecthUserList( model : IGetUsersCallBack ) : void
   }
}