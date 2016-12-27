package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.data.CacheData;
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.view.ui.UIMainDialog;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.framework.mvc.Command;
	
	public class StartupCommand extends Command
	{
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute(args:Array):void
		{		
			StageData.highScore = CacheData.me.getHighScore(SetupData.mode );
			StageData.totalBubbleCount = CacheData.me.getBubbleCount();
			
			UIResHelper.initialize();
			UIMainDialog.me.startup();
		}
	}
}