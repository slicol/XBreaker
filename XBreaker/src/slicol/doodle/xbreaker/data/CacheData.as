package slicol.doodle.xbreaker.data
{
	import slicol.foundation.singleton.SingletonFactory;
	import slicol.foundation.so.SOLocalData;
	
	public class CacheData extends SOLocalData
	{
		public function CacheData()
		{
			super(true);
		}
		
		public static function get me():CacheData
		{
			return SingletonFactory.getInstance(CacheData);
		}
		
		public function getHighScore(mode:int):int
		{
			return read("HighScore_" + mode);
		}
		
		public function setHighScore(mode:int, score:int):void
		{
			save("HighScore_" + mode, score);
		}
		
		
		public function getBubbleCount():int
		{
			return read("BubbleCount");
		}
		
		public function setBubbleCount(v:int):void
		{
			save("BubbleCount", v);
		}
	}
}