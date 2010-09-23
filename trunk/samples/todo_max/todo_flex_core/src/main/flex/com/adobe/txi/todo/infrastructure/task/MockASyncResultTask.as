package com.adobe.txi.todo.infrastructure.task
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class MockASyncResultTask extends MockResultTask
    {
        private var timer:Timer;
        
        public function MockASyncResultTask(result:*,duration:int=100)
        {
            timer = new Timer(duration,1);
            
            super(result, false);
            
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler );
            timer.start();
        }
        
        private function timerCompleteHandler( event:TimerEvent):void
        {
            finishWithResult();
        }
    }
}