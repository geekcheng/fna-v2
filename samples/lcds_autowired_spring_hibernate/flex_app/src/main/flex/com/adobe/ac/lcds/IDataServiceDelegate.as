package com.adobe.ac.lcds
{
   public interface IDataServiceDelegate extends IDelegate
   {
      function commit( resultHandler : Function = null ) : void;
      
      function rollback() : void;
   }
}