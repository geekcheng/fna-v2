package com.adobe.txi.todo.infrastructure.modulerig
{
	import org.spicefactory.lib.task.SequentialTaskGroup;
	import org.spicefactory.lib.task.Task;
	import org.spicefactory.parsley.core.context.Context;
	
	public class ModuleRigBootstrapTaskGroup extends SequentialTaskGroup
	{
		private var context:Context;
		
		public function ModuleRigBootstrapTaskGroup(context:Context,tasks:Array)
		{
			super();
			
			this.context = context;
			
			for each( var task:Task in tasks)
			{
				context.addDynamicObject(task);
				addTask(task);
			}
		}
	}
}