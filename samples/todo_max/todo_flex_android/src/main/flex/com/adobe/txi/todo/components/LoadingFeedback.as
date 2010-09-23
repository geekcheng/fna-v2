package com.adobe.txi.todo.components
{
    import spark.components.SkinnableContainer;
    
    public class LoadingFeedback extends SkinnableContainer
    {
        [Bindable]
        public var message:String;
        
        [Bindable]
        public var showSpinning:Boolean=true;
        
        public function LoadingFeedback()
        {
            super();
        }
    }
}