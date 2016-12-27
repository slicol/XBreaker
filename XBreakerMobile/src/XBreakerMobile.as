package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import slicol.doodle.xbreaker.XBreaker;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	
	//[SWF(width="768", height="1024", backgroundColor="#aaaaaa")]
	public class XBreakerMobile extends Sprite
	{
		public function XBreakerMobile()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
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
			//UIString.Lang = UIString.LANG_EN;
			//MouseTouch.useTouch();
			new slicol.doodle.xbreaker.XBreaker(this);
			
			//Snapshot.attach(this);
			
			
		}
	}
}