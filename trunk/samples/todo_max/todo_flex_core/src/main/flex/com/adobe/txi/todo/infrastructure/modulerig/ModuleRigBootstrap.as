package com.adobe.txi.todo.infrastructure.modulerig
{
	import org.spicefactory.lib.task.SequentialTaskGroup;
	import org.spicefactory.lib.task.Task;
	import org.spicefactory.parsley.config.Configuration;
	import org.spicefactory.parsley.config.RootConfigurationElement;
	import org.spicefactory.parsley.core.registry.ObjectDefinitionRegistry;
	import org.spicefactory.parsley.dsl.ObjectDefinitionBuilder;
	
	[DefaultProperty("tasks")]
	public class ModuleRigBootstrap implements RootConfigurationElement
	{
		[ArrayElementType("org.spicefactory.lib.task.Task")]
		public var tasks:Array;
		
		public var objectId:String;
		
		public function process(config:Configuration):void
		{
			var builder:ObjectDefinitionBuilder = config.builders.forClass(ModuleRigBootstrapTaskGroup);
			
			builder.constructorArgs().value(config.context).value(tasks);
			
			builder.asSingleton().id(objectId).register();
		}
	}
}