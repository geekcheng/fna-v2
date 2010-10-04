package com.adobe.txi.todo.application.rig
{
    import com.adobe.txi.todo.application.authentication.LoginMessage;

    import mx.utils.StringUtil;

    import org.spicefactory.lib.task.Task;

    public class ModuleRigLoginTask extends Task
    {

        [MessageDispatcher]
        public var dispatcher:Function;

        public var username:String;

        public var password:String;

        private static const ERROR_MSG:String = "Error during the login task with credentials user:{0} pass:{1}";

        protected override function doStart():void
        {
            dispatcher(new LoginMessage(username, password));
        }

        [CommandComplete]
        public function loginComplete(message:LoginMessage):void
        {
            complete();
        }

        [CommandError]
        public function loginError(result:*, message:LoginMessage):void
        {
            error(StringUtil.substitute(ERROR_MSG, username, password));
        }
    }
}