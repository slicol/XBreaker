package slicol.doodle.xbreaker.view.ui.stage
{
	import com.greensock.TweenLite;
	import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import slicol.doodle.xbreaker.command.StageQuitCommand;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.framework.mvc.Controller;
	import slicol.touch.MouseTouch;
	
	public class UIStageOver extends UIMovieClipCtlBase
	{
		private var m_imgTitle:MovieClip;
		private var m_txtTips:TextField;
		
		private var m_txtModeLabel:TextField;
		private var m_txtMode:TextField;
		
		private var m_txtHighScoreLabel:TextField;
		private var m_txtHighScore:TextField;
		private var m_txtTotalScoreLabel:TextField;
		private var m_txtTotalScore:TextField;
		private var m_txtTotalBubble:TextField;
		private var m_txtTotalBubbleLabel:TextField;

		private var m_timer:Timer = new Timer(500);
		private var m_hasNewHighScore:Boolean = false;
		
		public function UIStageOver(container:Sprite)
		{
			super((new UIResHelper.UIStageOver) as MovieClip);
			stop();
			container.addChild(ui);
			
			m_imgTitle = ui["imgTitle"];
			m_imgTitle.mouseEnabled = false;
			
			m_txtTips = ui["txtTips"];
			m_txtTips.selectable = false;
			m_txtTips.mouseEnabled = false;
			m_txtTips.text = UIString.getLangLabel("Tap To Main Menu");
			
			m_txtModeLabel = ui["txtModeLabel"];
			m_txtModeLabel.selectable = false;
			m_txtModeLabel.mouseEnabled = false;
			m_txtModeLabel.text = UIString.getLangLabel("Game Mode") + ":";
			
			m_txtMode = ui["txtMode"];
			m_txtMode.selectable = false;
			m_txtMode.mouseEnabled = false;
			m_txtMode.text = "STANDARD";
			
			
			
			m_txtHighScoreLabel = ui["txtHighScoreLabel"];
			m_txtHighScoreLabel.selectable = false;
			m_txtHighScoreLabel.mouseEnabled = false;
			m_txtHighScoreLabel.text = UIString.getLangLabel("High Score") + ":";
			
			m_txtHighScore = ui["txtHighScore"];
			m_txtHighScore.selectable = false;
			m_txtHighScore.mouseEnabled = false;
			m_txtHighScore.text = "0";
			
			
			
			m_txtTotalScoreLabel = ui["txtTotalScoreLabel"];
			m_txtTotalScoreLabel.selectable = false;
			m_txtTotalScoreLabel.mouseEnabled = false;
			m_txtTotalScoreLabel.text = UIString.getLangLabel("Total Score") + ":";
			
			m_txtTotalScore = ui["txtTotalScore"];
			m_txtTotalScore.selectable = false;
			m_txtTotalScore.mouseEnabled = false;
			m_txtTotalScore.text = "0";
			
			
			m_txtTotalBubbleLabel = ui["txtTotalBubbleLabel"];
			m_txtTotalBubbleLabel.selectable = false;
			m_txtTotalBubbleLabel.mouseEnabled = false;
			m_txtTotalBubbleLabel.text = UIString.getLangLabel("Bubble Count") + ":";
			
			m_txtTotalBubble = ui["txtTotalBubble"];
			m_txtTotalBubble.selectable = false;
			m_txtTotalBubble.mouseEnabled = false;
			m_txtTotalBubble.text = "0";
			
			
			
			ui.addEventListener(MouseTouch.TAP, onUIClick);
			ui.buttonMode = true;
			
			m_timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			
		}
		
		public function show():void
		{
			this.visible = true;
			
			m_timer.start();
			
			m_txtHighScore.text = StageData.highScore.toString();

			m_txtMode.text = UIString.getModeLabel(GameStage.me.data.mode);
			m_txtTotalBubble.text = StageData.totalBubbleCount.toString();
			
			m_hasNewHighScore = GameStage.me.data.stageScore > StageData.highScore;
			
			if(m_hasNewHighScore)
			{
				m_txtTotalScore.htmlText = "<font color='#ff0000'><b>"+GameStage.me.data.stageScore+
					"</b></font> <font color='#ffff00'> [New!]</font>";
			}
			else
			{
				m_txtTotalScore.text = GameStage.me.data.stageScore.toString();
			}
			
			updateLayout();
		}
		
		public function hide():void
		{
			this.visible = false;
			m_timer.stop();
		}
		
		private function onTimer(e:Event):void
		{
			if(m_txtTips.alpha < 0.1)
			{
				TweenLite.to(m_txtTips, 0.3, {alpha:1});
			}
			else
			{
				TweenLite.to(m_txtTips, 0.3, {alpha:0});
			}
			
			if(m_hasNewHighScore)
			{
				if(m_txtTotalScore.alpha < 0.1)
				{
					TweenLite.to(m_txtTotalScore, 0.3, {alpha:1});
				}
				else
				{
					TweenLite.to(m_txtTotalScore, 0.3, {alpha:0});
				}				
			}
		}
		
		private function onUIClick(e:Event):void
		{
			this.hide();
			Controller.execute(StageQuitCommand);
		}
		
		public function updateLayout():void
		{
			this.width = ui.stage.stageWidth;
			this.height = ui.stage.stageHeight;
		}
	}
}