package com.adobe.txi.todo.application.authentication
{
    import mx.messaging.ChannelSet;
    import mx.messaging.config.ServerConfig;
    import mx.rpc.AsyncResponder;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.RemoteObject;
    
    import org.spicefactory.lib.task.ResultTask;
    
    public class LogoutChannelSetTask extends ResultTask
    {
        private var service:RemoteObject;
        
        public function LogoutChannelSetTask(service:RemoteObject)
        {
            super();
            
            this.service = service; 
        }
        
        protected override function doStart():void
        {
			try
			{
	            //var channelSet:ChannelSet = service.channelSet;
	            var channelSet:ChannelSet = ServerConfig.getChannelSet("loginService");
	            var token:AsyncToken = channelSet.logout();
	            
	            token.addResponder(new AsyncResponder(onResult, onError));
			}
			catch(e:Error)
			{
				error(e.message);
			}
        }
        
        
        private function onResult(event:ResultEvent,token:AsyncToken):void
        {
            setResult(null);
        }
        
        private function onError(event:FaultEvent,token:AsyncToken):void
        {
            error(event.fault.faultDetail);
        }
    }
}