package slicol.doodle.xbreaker.view.ui
{
	import com.tencent.fge.utils.AsyInvoke;
	
	import flash.display.Sprite;
	
	import slicol.doodle.xbreaker.command.StageStartCommand;
	import slicol.doodle.xbreaker.view.ui.menu.UIMenuMain;
	import slicol.framework.mvc.Controller;
	import slicol.framework.mvc.View;
	
	public class UIMainDialog extends Sprite
	{
		public static function get me():UIMainDialog
		{
			return View.getInstance(UIMainDialog);
		}
		
		
		
		private var m_imgBackground:Sprite;
		private var m_uiMenuMain:UIMenuMain;

		
		public function UIMainDialog()
		{
			View.container.addChild(this);
		}
		
		
		//-----------------------------------------------------------

		public function startup():void
		{
			this.visible = false;
			
			//背景
			m_imgBackground = new UIResHelper.ImgBackground;
			this.addChild(m_imgBackground);

			//MenuMain
			m_uiMenuMain = new UIMenuMain(this);
			m_uiMenuMain.visible = true;
			m_uiMenuMain.onNewStage.add(onNewStage);
			
			AsyInvoke.execute(show, 200);
		}

		//-----------------------------------------------------------
		
		public function show():void
		{
			this.visible = true;
			m_uiMenuMain.show();
			updateLayout();
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		//-----------------------------------------------------------
		
		private function onNewStage():void
		{
			Controller.execute(StageStartCommand);
		}
		
		
		//-----------------------------------------------------------
		
		private function updateLayout():void
		{
			m_imgBackground.width = m_imgBackground.stage.stageWidth;
			m_imgBackground.height = m_imgBackground.stage.stageHeight;
		}
	}
}