package slicol.doodle.xbreaker.data
{
	public class StageData
	{
		public static const SM_STANDARD:int = 0;
		public static const SM_STANDARD_SERIES:int = 1;
		public static const SM_SHIFT:int = 2;
		public static const SM_SHIFT_SERIES:int = 3;
		
		public static var highScore:int = 0;
		public static var totalBubbleCount:int = 0;
		
		public var typeCount:int = 5;
		public var width:int = 10;
		public var height:int = 10;
		public var scene:Vector.<Vector.<BubbleData>>;
		public var markCount:int;
		public var stageScore:int;
		public var stageRank:int;
		public var stepScore:int;
		public var mode:int = SM_STANDARD;
		public var level:int = 1;
		public var passed:Boolean = false;
		
		public static function getLevelScore(lv:int):int
		{
			var tmp:int = (lv - 1) / 5;
			if(lv == 1)
			{
				return 1000;
			}
			else if(lv == 2)
			{
				return 3000;
			}
			else
			{
				
				var q:int = (lv-1)/5;
				var m:int = q * 5;
				var k:int = q + 2;
				var b:int = 10 + 5*(q-1)*(q-1+5)/2;
				var s:int = (lv-m)*k+b;
				
				return s * 1000;
			}
		}
	}
}