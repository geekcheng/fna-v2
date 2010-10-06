package com.adobe.txi.todo.application.authentication
{
    import com.adobe.txi.todo.domain.UserModel;

    import mx.rpc.remoting.RemoteObject;

    import org.spicefactory.lib.task.Task;

    public class LogoutCommand
    {

        [Inject(id="loginService")]
        public var service:RemoteObject;

        [Inject]
        public var userModel:UserModel;

        public function execute(message:LogoutMessage):Task //NOPMD
        {
            return new LogoutChannelSetTask(service);
        }
    }
}