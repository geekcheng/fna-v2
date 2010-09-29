package com.adobe.txi.todo.infrastructure.modulerig
{
	import com.adobe.cairngorm.module.IModuleManager;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	
	import org.spicefactory.lib.task.events.TaskEvent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	
	public class ModuleRigContainer extends SkinnableContainer
	{
		[SkinPart(required="true")]
		public var headerBarContent:Group;
		
		[Bindable]
		[ArrayElementType("mx.core.IVisualElement")]
		public var rigHeaderPlaceholder:Array;
		
		[Bindable]
		public var title:String;
		
		[Bindable]
		public var moduleManager:IModuleManager;
		
		private var _bootstrap:ModuleRigBootstrapTaskGroup;
		
		public function set bootstrap(value:ModuleRigBootstrapTaskGroup):void
		{
			_bootstrap = value;
			
			_bootstrap.addEventListener(TaskEvent.COMPLETE, bootstrapperCompleteHandler);
			_bootstrap.addEventListener(ErrorEvent.ERROR, bootstrapperErrorHandler);
			_bootstrap.addEventListener(TaskEvent.CANCEL, bootstrapperErrorHandler);
			
			if( _bootstrap )
			{
				_bootstrap.start();
			}
		}
		
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			for each (var element:IVisualElement in rigHeaderPlaceholder)
			{
				headerBarContent.addElement(element);
			}
		}
		
		private function bootstrapperCompleteHandler(event:TaskEvent):void
		{
			currentState = "normal";
			
			invalidateSkinState();
		}
		
		private function bootstrapperErrorHandler(event:Event):void
		{
			currentState = "error";
			
			invalidateSkinState();
		}
	}
}