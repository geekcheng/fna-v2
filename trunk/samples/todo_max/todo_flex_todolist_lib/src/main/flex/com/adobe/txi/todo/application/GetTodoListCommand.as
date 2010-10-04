package com.adobe.txi.todo.application
{
    import com.adobe.txi.todo.domain.TodoModel;

    import mx.collections.ArrayCollection;
    import mx.rpc.AsyncToken;
    import mx.rpc.remoting.RemoteObject;

    public class GetTodoListCommand
    {

        [Inject(id="todoService")]
        public var service:RemoteObject;

        [Inject]
        public var todoModel:TodoModel;

        /*[Inject]
         public var cache:IDataCache;*/

        public function execute(message:GetTodoListMessage):AsyncToken
        {
            return service.getAll();
        }

        public function result(todoList:ArrayCollection, message:GetTodoListMessage):void
        {
            //todoModel.todos = cache.synchronize(todoList) as ArrayCollection;
            todoModel.todos = todoList;
        }

        public function error(error:*, message:GetTodoListMessage):void
        {
            trace("error");
        }
    }
}