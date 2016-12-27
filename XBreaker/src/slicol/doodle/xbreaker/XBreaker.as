package slicol.doodle.xbreaker
{
	import flash.display.Sprite;
	
	import slicol.doodle.xbreaker.command.BubbleClickCommand;
	import slicol.doodle.xbreaker.command.StageStartCommand;
	import slicol.doodle.xbreaker.command.StartupCommand;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.StageView;
	import slicol.doodle.xbreaker.view.ui.stage.UIStageOver;
	import slicol.doodle.xbreaker.view.ui.UIMainDialog;
	import slicol.doodle.xbreaker.view.ui.UIStagePanel;
	import slicol.framework.mvc.Controller;
	import slicol.framework.mvc.Facade;
	import slicol.framework.mvc.Model;
	import slicol.framework.mvc.View;
	
	public class XBreaker extends Facade
	{
		private var m_container:Sprite;
		
		public function XBreaker(container:Sprite)
		{
			m_container = container;
			
			super();
			
		}
		
		override protected function initializeController():void
		{

		}
		
		override protected function initializeModel():void
		{
			Model.addModel(GameStage);
		}
		
		override protected function initializeView():void
		{
			View.container = m_container;
			View.addView(UIMainDialog);
			View.addView(UIStagePanel);
			View.addView(StageView);
		}
		
		
		override protected function initializeFacade():void
		{
			super.initializeFacade();
			
			Controller.execute(StartupCommand);
		}
		
		

	}
}