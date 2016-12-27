package slicol.doodle.xbreaker.command
{
	import slicol.doodle.xbreaker.data.BubbleData;
	import slicol.doodle.xbreaker.data.CacheData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.framework.mvc.Command;
	
	public class BubbleClickCommand extends Command
	{
		public function BubbleClickCommand()
		{
			
		}
		
		override public function execute(args:Array):void
		{
			var data:BubbleData = args[0];
			if(data.mark)
			{
				GameStage.me.cleanStep();
			}
			else if(data.value != 0)
			{
				GameStage.me.cancelStep();
				GameStage.me.beginStep(data.x, data.y);
			}
			
			CacheData.me.setBubbleCount(StageData.totalBubbleCount);
		}
		
		

	}
}