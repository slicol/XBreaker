package slicol.doodle.xbreaker.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import slicol.doodle.xbreaker.command.StageQuitCommand;
	import slicol.doodle.xbreaker.command.StageStartCommand;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.StageView;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.doodle.xbreaker.view.ui.stage.CtlTopbar;
	import slicol.doodle.xbreaker.view.ui.stage.UILevelPass;
	import slicol.doodle.xbreaker.view.ui.stage.UIMenuStage;
	import slicol.doodle.xbreaker.view.ui.stage.UIStageOver;
	import slicol.framework.mvc.Controller;
	import slicol.framework.mvc.View;
	
	public class UIStagePanel extends UIMovieClipCtlBase
	{
		public static function get me():UIStagePanel
		{
			return View.getInstance(UIStagePanel);
		}
		
		private var m_ctlTopbar:CtlTopbar;

		private var m_ctlStageView:UIMovieClipCtlBase;
		private var m_imgSkin:MovieClip;
		private var m_txtTips:TextField;
		
		private var m_uiMenuStage:UIMenuStage;
		private var m_uiStageOver:UIStageOver;
		private var m_uiLevelPass:UILevelPass;
		
		
		public function UIStagePanel()
		{
			super(new UIResHelper.UIStagePanel as MovieClip);
			ui.stop();
			View.container.addChild(ui);
			

			m_ctlTopbar = new CtlTopbar(ui);
			
			
			m_imgSkin = ui["imgSkin"];
			m_imgSkin.mouseEnabled = false;
			m_imgSkin.visible = false;
			
			
			m_txtTips = ui["txtTips"];
			m_txtTips.alpha = 0;
			m_txtTips.selectable = false;
			m_txtTips.mouseEnabled = false;
			m_txtTips.text = "";
			ui.addChild(m_txtTips);
			

			m_ctlStageView = new UIMovieClipCtlBase(ui["ctlStageView"]);
			m_ctlStageView.removeAllChildren();
			m_ctlStageView.addChild(StageView.me);
			m_ctlStageView.alpha = 0;
			
			
			m_uiMenuStage = new UIMenuStage(ui);
			m_uiMenuStage.visible = false;
			m_uiMenuStage.onQuit.add(onQuit);
			m_uiMenuStage.onReplay.add(onReplay);
			m_uiMenuStage.onResume.add(onResume);
			
			m_uiStageOver = new UIStageOver(ui);
			m_uiStageOver.visible = false;
			
			m_uiLevelPass = new UILevelPass(ui);
			m_uiLevelPass.visible = false;
			
			GameStage.me.onStageOver.add(onStageOver);
			GameStage.me.onStepBegin.add(onStepBegin);
			GameStage.me.onStepClean.add(onStepClean);
			GameStage.me.onLevelPass.add(onLevelPass);
			
			
		}
		
		
		//--------------------------------------------------------

		public function start():void
		{
			m_ctlTopbar.start(GameStage.me.data.mode, 
				GameStage.me.data.level, GameStage.me.data.stageScore);
			
			m_ctlStageView.alpha = 0;
			TweenLite.to(m_ctlStageView, 0.5, {alpha:1});

			this.visible = true;
			updateLayout();
		}
		
		public function quit():void
		{
			this.visible = false;
		}
		
		
		public function pause():void
		{
			m_uiMenuStage.show();
		}
		
		
		//--------------------------------------------------------
		
		public function updateLayout():void
		{
			var sx:Number = StageView.me.width / ui.stage.stageWidth;
			var sy:Number = StageView.me.height / (ui.stage.stageHeight - m_ctlTopbar.height);
			
			var s:Number = Math.max(sx, sy);
			
			var w:Number = StageView.me.width / s;
			var h:Number = StageView.me.height / s;
			
			m_ctlStageView.scaleX = 1/s;
			m_ctlStageView.scaleY = 1/s;
			
			m_imgSkin.visible = true;
			m_imgSkin.width = ui.stage.stageWidth;
			m_imgSkin.height = ui.stage.stageHeight;

			m_ctlStageView.x = (m_imgSkin.width - w)/2;
			m_ctlStageView.y = m_imgSkin.height - h ;
			
			
			m_ctlTopbar.width = m_imgSkin.width;
			
			m_txtTips.alpha = 0;
			
			m_uiMenuStage.updateLayout();
		}
		
		
		//--------------------------------------------------------
		
		private function onStageOver():void
		{
			if(GameStage.me.data.passed)
			{
				m_uiLevelPass.show();
			}
			else
			{
				m_uiStageOver.show();
			}
		}
		
		private function onStepBegin():void
		{
			m_txtTips.visible = false;
			m_ctlTopbar.setStepScore(GameStage.me.data.stepScore, GameStage.me.data.markCount);
		}
		
		private function onStepClean():void
		{
			var markCount:int = GameStage.me.data.markCount;
			var s:String = UIString.getTipsText(markCount);
			if(s)
			{
				popupTips(s);
			}
			
			var stepScore:int = GameStage.me.data.stepScore;
			var stageScore:int = GameStage.me.data.stageScore;
			m_ctlTopbar.updateTotalScore(stageScore, stepScore);
		}
		
		private function onLevelPass():void
		{
			m_ctlTopbar.levelPass();
			popupTips(UIString.getLangLabel("Level Passed") + "!");
		}
		
		
		public function popupTips(info:String):void
		{
			m_txtTips.visible = true;
			m_txtTips.text = "【 " + info + " 】";
			m_txtTips.alpha = 0;
			m_txtTips.y = m_imgSkin.height/3;
			
			m_txtTips.x = (m_imgSkin.width - m_txtTips.width) / 2;
			
			Tweener.addTween(m_txtTips, {time:1, y: 130, alpha:1});
			Tweener.addTween(m_txtTips, {time:1, delay:1, alpha:0});
		}
		
		
		//--------------------------------------------------------
		
		private function onQuit():void
		{
			Controller.execute(StageQuitCommand);
		}
		
		private function onReplay():void
		{
			Controller.execute(StageStartCommand);
		}
		
		private function onResume():void
		{
			m_uiMenuStage.hide();
		}
		
	}
}



