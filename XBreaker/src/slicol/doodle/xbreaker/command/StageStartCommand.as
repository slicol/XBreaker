package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.BubbleView;
	import slicol.doodle.xbreaker.view.StageView;
	import slicol.doodle.xbreaker.view.ui.UIMainDialog;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.UIStagePanel;
	import slicol.framework.mvc.Command;
	
	public class StageStartCommand extends Command
	{
	
		public function StageStartCommand()
		{
		}
		
		override public function execute(args:Array):void
		{
			BubbleView.bindUIRes(UIResHelper.mapBubbleClass[SetupData.theme], SetupData.typeCount);
			
			GameStage.me.start(SetupData.width, SetupData.height, SetupData.typeCount, SetupData.mode);
			StageView.me.start(SetupData.theme);
			
			UIMainDialog.me.hide();
			UIStagePanel.me.start();
		}

	}
}