package com.adobe.txi.todo.application
{
    import com.adobe.txi.todo.domain.TodoItem;

    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.remoting.RemoteObject;

    import spark.components.Application;

    public class SaveTodoItemCommand
    {

        [Inject(id="todoService")]
        public var service:RemoteObject;

        /*[Inject]
         public var cache:IDataCache;*/

        public function execute(message:SaveTodoItemMessage):AsyncToken
        {
            return service.save(message.todoItem);
        }

        public function result(todoItem:TodoItem, message:SaveTodoItemMessage):void
        {
            //cache.updateItem(message.todoItem, todoItem);
            message.todoItem.id = todoItem.id;
        }

        public function error(result:FaultEvent):void
        {
            Alert.show("error", "", 4, null, null, null, 4, Application(FlexGlobals.topLevelApplication).moduleFactory);
        }
    }
}