package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.StageView;
	import slicol.doodle.xbreaker.view.ui.UIMainDialog;
	import slicol.doodle.xbreaker.view.ui.UIStagePanel;
	import slicol.framework.mvc.Command;
	
	public class StagePassedCommand extends Command
	{
		public function StagePassedCommand()
		{
			super();
		}
		
		override public function execute(args:Array):void
		{
			var level:int = GameStage.me.data.level;
			level++;
			
			GameStage.me.start(SetupData.width, SetupData.height, SetupData.typeCount, SetupData.mode, level);
			StageView.me.start(SetupData.theme);
			
			UIStagePanel.me.start();
		}
	}
}