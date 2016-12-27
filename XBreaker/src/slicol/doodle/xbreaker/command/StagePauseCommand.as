package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.view.ui.UIStagePanel;
	import slicol.framework.mvc.Command;
	
	public class StagePauseCommand extends Command
	{
		public function StagePauseCommand()
		{
			super();
		}
		
		override public function execute(args:Array):void
		{
			UIStagePanel.me.pause();
		}
	}
}