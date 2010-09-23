package com.adobe.txi.todo.infrastructure.task
{
    import mx.rpc.AsyncToken;
    import mx.rpc.CallResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    import org.spicefactory.lib.task.ResultTask;
    
    public class ASyncTokenResultTask extends ResultTask
    {
        public var token:AsyncToken;
        
        public function ASyncTokenResultTask(token:AsyncToken)
        {
            start();

            this.token = token;

            var responder:CallResponder = new CallResponder();
            responder.token = token;
            
            responder.addEventListener(ResultEvent.RESULT,onResult);
            responder.addEventListener(FaultEvent.FAULT,onError);
        }
        
        private function onResult(event:ResultEvent):void
        {
            setResult( event.result );
        }
        
        private function onError(event:FaultEvent):void
        {
            error( event.fault.faultCode );
        }
    }
}