package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	
	[SWF(width="640", height="960", backgroundColor="#aaaaaa")]
	public class XBreaker extends Sprite
	{
		public function XBreaker()
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
			UIString.useSystemLang();
			new slicol.doodle.xbreaker.XBreaker(this);
		}
	}
}