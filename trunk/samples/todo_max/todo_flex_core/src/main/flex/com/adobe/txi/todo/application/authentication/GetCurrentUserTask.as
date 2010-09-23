package com.adobe.txi.todo.application.authentication
{
    import com.adobe.txi.todo.domain.UserModel;
    
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.RemoteObject;
    
    import org.spicefactory.lib.task.ResultTask;
    
    public class GetCurrentUserTask extends ResultTask
    {
        private var service:RemoteObject;
        private var userModel:UserModel;
        
        public function GetCurrentUserTask(service:RemoteObject,userModel:UserModel)
        {
            super();
            
            this.service = service;
            this.userModel = userModel;
        }
        
        protected override function doStart():void
        {
            var token:AsyncToken = service.getCurrentUser() as AsyncToken;
            token.addResponder(new AsyncResponder(onResult, onError));
        }        
        
        private function onResult(event:ResultEvent,token:AsyncToken):void
        {
            userModel.user = event.result;

			setResult(event.result);
        }
        
        private function onError(event:FaultEvent,token:AsyncToken):void
        {
            error(event.fault.faultDetail);
        }
    }
}