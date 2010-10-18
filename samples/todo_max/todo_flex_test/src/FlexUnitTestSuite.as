package
{
	import com.adobe.txi.todo.application.TodoItemControllerTest;
	import com.adobe.txi.todo.application.TodoListControllerTest;
	import com.adobe.txi.todo.application.authentication.LoginControllerTest;
	import com.adobe.txi.todo.domain.TodoModelTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnitTestSuite
	{
		public var test1:TodoItemControllerTest;
		public var test2:TodoListControllerTest;
		public var test3:TodoModelTest;
		public var test5:LoginControllerTest;
		
	}
}