package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.data.CacheData;
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.ui.UIMainDialog;
	import slicol.doodle.xbreaker.view.ui.UIStagePanel;
	import slicol.framework.mvc.Command;
	
	public class StageQuitCommand extends Command
	{
		public function StageQuitCommand()
		{
			super();
		}
		
		override public function execute(args:Array):void
		{
			if(StageData.highScore < GameStage.me.data.stageScore)
			{
				StageData.highScore = GameStage.me.data.stageScore;
				CacheData.me.setHighScore(SetupData.mode, StageData.highScore);
			}
			
			UIStagePanel.me.quit();
			UIMainDialog.me.show();
		}
	}
}