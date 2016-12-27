package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.foundation.singleton.SingletonFactory;
	import slicol.foundation.singleton.test.CaseA;
	import slicol.foundation.singleton.test.CaseSubFactory;
	
	public class UnitApp extends Sprite
	{
		public function UnitApp()
		{ 
			if(!this.stage)
			{
				this.addEventListener(Event.ADDED_TO_STAGE, init);
			}
			else
			{ 
				init();
			}
		}
		
		
		private function init(arg:*=null):void
		{
			
			for(var i:int = 1; i < 20; ++i)
			{
				var a:int = StageData.getLevelScore(i);
				trace(a);
			}
			
			
		
			
			var list:Array;
			
			list = SingletonFactory.getAllSingletonNameList();
			trace(list);
			
			
			var factory:SingletonFactory;
			
			factory = SingletonFactory.getFactory(CaseSubFactory);
			trace(factory);
			
			factory = SingletonFactory.getFactory(slicol.foundation.singleton.test.CaseSubFactory);
			trace(factory);
			
			factory = SingletonFactory.getFactory(slicol.foundation.singleton.test.CaseSubFactory);
			trace(factory);
			
			
			var instance:*;
			
			//instance = SingletonFactory.getInstance("Case0");
			//trace(instance);
			
			instance = SingletonFactory.getInstance("slicol.foundation.singleton.test::Case0");
			trace(instance);
			
			instance = SingletonFactory.getInstance("slicol.foundation.singleton.test::Case0");
			trace(instance);
			
			
			instance = CaseSubFactory.getMySingletonInstance(slicol.foundation.singleton.test.Case0);
			trace(instance);
			
			
			//instance = CaseA.me;
			//trace(instance);
			
			//instance = SingletonFactory.getInstance("slicol.foundation.singleton.test::CaseA");
			//trace(instance);
			
			
			CaseSubFactory.regMySingleton(CaseA);
			list = SingletonFactory.getAllSingletonNameList();
			trace(list);
			
			
			instance = CaseSubFactory.getMySingletonInstance(CaseA);
			trace(instance);
			
			
			list = SingletonFactory.getAllSingletonNameList();
			trace(list);
		}
	}
}