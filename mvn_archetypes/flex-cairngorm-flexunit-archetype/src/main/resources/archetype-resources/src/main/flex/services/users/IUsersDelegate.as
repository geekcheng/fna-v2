package ${package}.services.users
{
   import ${package}.view.common.model.IGetUsersCallBack;
   
   public interface IUsersDelegate
   {
      function fecthUserList( model : IGetUsersCallBack ) : void
   }
}