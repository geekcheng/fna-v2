package com.adobe.txi.todo.application
{
    import com.adobe.cairngorm.integration.data.IDataCache;
    import com.adobe.txi.todo.domain.TodoModel;
    
    import mx.rpc.AsyncToken;
    import mx.rpc.remoting.RemoteObject;

    public class RemoveTodoItemCommand
    {

        [Inject(id="todoService")]
        public var service:RemoteObject;

        [Inject]
        public var todoModel:TodoModel;

        [Inject]
        public var cache:IDataCache;

        public function execute(message:RemoveTodoItemMessage):AsyncToken
        {
            return service.remove(message.todoItem.id);
        }

        public function result(result:*, message:RemoveTodoItemMessage):void
        {
            todoModel.deleteItem(message.todoItem);
            cache.clearItem(message.todoItem);
        }
    }
}