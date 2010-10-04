package com.adobe.txi.todo.application.authentication.mock
{
    import com.adobe.txi.todo.application.authentication.LogoutMessage;
    import com.adobe.txi.todo.infrastructure.task.MockASyncResultTask;

    import org.spicefactory.lib.task.Task;

    public class MockLogoutCommand
    {
        public function execute(message:LogoutMessage):Task
        {
            return new MockASyncResultTask(null);
        }
    }
}