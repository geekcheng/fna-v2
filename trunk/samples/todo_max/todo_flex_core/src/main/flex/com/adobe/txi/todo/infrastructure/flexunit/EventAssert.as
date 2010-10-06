package com.adobe.txi.todo.infrastructure.flexunit
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class EventAssert
    {
        public static function addAsyncEventAssertion(
            testCase:Object, 
            source:IEventDispatcher, 
            eventType:String, timeout:int=500):void
        {
            var listener:EventListener = new EventListener(source, eventType);
            
            listener.startListening(
                Async.asyncHandler(testCase, assertEvent, timeout, listener, timeoutHandler));
        }
        
        private static function assertEvent(event:Event, listener:EventListener):void  
        {
            assertThat( 
                'expected an event of type '+listener.type+', but it was not dispatched', 
                event.type, equalTo(listener.type) );
            
            listener.stopListening();
        }
        
        private static function timeoutHandler(listener:EventListener):void
        {
            Assert.fail('expected an event of type '+String(listener.type)+', but it was not dispatched');
            listener.stopListening();
        }
        
        
        
        private var allListeners : Array = new Array();
        
        
        public function listenForEvent(source:IEventDispatcher, type:String, isExpected:Boolean = true):void
        {
            var listener:EventListener = new EventListener(source, type, isExpected);
            listener.startListening();
            
            allListeners.push(listener);
        }
        
        public function assertEvents(message:String=""):void
        {
            stopAllListeners();
            
            for each (var listener:EventListener in allListeners)
            {
                if (!listener.assertCorrectDispatch())
                {
                    Assert.fail(message);
                }
            }
        }
        
        public function getDispatchedEventFor(source:IEventDispatcher, type:String):Event
        {
            for each (var listener:EventListener in allListeners)
            {
                if (listener.source==source && listener.type==type)
                {
                    return listener.dispatchedEvent;
                }
            }
            return null;
        }
        
        public function stopAllListeners():void
        {
            for each (var listener:EventListener in allListeners)
            {
                listener.stopListening();
            }
        }
        
    }
}

import flash.events.Event;
import flash.events.IEventDispatcher;

class EventListener
{
    public function EventListener(source:IEventDispatcher, type:String, isExpected:Boolean = true)
    {
        _source = source;
        _type = type;
        _isExpected = isExpected;
        
        // set the default handler
        eventHandler = handleEvent;
    }
    
    private var eventHandler:Function;
    
    private var _source:IEventDispatcher;
    
    public function get source():IEventDispatcher
    {
        return _source;
    }
    
    private var _type:String;
    
    public function get type():String
    {
        return _type;
    }
    
    private var _isExpected:Boolean;
    
    public function get isExpected():Boolean
    {
        return _isExpected;
    }
    
    private var _dispatchedEvent:Event;
    
    public function get dispatchedEvent():Event
    {
        return _dispatchedEvent;
    }
    
    
    public function startListening(handler:Function = null):void
    {
        if (handler!=null)
        {
            this.eventHandler = handler;
        }
        source.addEventListener(type, eventHandler, false, 0, true);
    }
    
    public function stopListening():void
    {
        source.removeEventListener(type, eventHandler);
    }
    
    public function assertCorrectDispatch():Boolean
    {
        if ( (isExpected && !dispatchedEvent) || (!isExpected && dispatchedEvent) )
        {
            return false;
        }
        return true;
    }
    
    private function handleEvent(event:Event):void
    {
        _dispatchedEvent = event;
        stopListening();
    }
    
}
