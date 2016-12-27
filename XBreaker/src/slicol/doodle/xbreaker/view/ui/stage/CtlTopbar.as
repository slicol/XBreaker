package slicol.doodle.xbreaker.view.ui.stage
{
	import caurina.transitions.Tweener;
	
	import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.TextField;
	
	import slicol.doodle.xbreaker.command.StagePauseCommand;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.framework.mvc.Controller;
	import slicol.touch.MouseTouch;
	
	public class CtlTopbar extends UIMovieClipCtlBase
	{
		private var m_height:int;
		
		private var m_imgScore:MovieClip;
		private var m_txtScore:TextField;
		private var m_txtMode:TextField;
		private var m_btnPause:SimpleButton;
		private var m_txtHighScore:TextField;
		private var m_txtLevel:TextField;
		private var m_txtStepTips:TextField;
		
		
		private var m_totalScore:int;
		private var m_stepScore:int;
		private var m_markCount:int;

		
		private var m_visible:Boolean;
		
		private var m_txtScoreLabel:String = "SCORE";
		private var m_txtHighScoreLabel:String = "HIGH SCORE";
		private var m_txtLevelLabel:String = "LEVEL";
		private var m_txtTargetScoreLabel:String = "TARGET SCORE";
		private var m_txtLevelInfo:String = "";
		private var m_txtBubbleLabel:String = "BUBBLE";
		
		public function CtlTopbar(ui:MovieClip):void
		{
			super(ui);
			
			m_visible = ui.visible;
			
			m_txtScore = ui["txtScore"];
			m_txtScore.mouseEnabled = false;
			m_txtScore.selectable = false;
			m_txtScore.text = "0";
			m_txtScoreLabel = UIString.getLangLabel(m_txtScoreLabel) + ":";
			
			
			m_imgScore = ui["imgScore"];
			m_imgScore.mouseEnabled = false;
			
			m_txtMode = ui["txtMode"];
			m_txtMode.mouseEnabled = false;
			m_txtMode.selectable = false;
			m_txtMode.text = "";
			
			m_txtHighScore = ui["txtHighScore"];
			m_txtHighScore.mouseEnabled = false;
			m_txtHighScore.selectable = false;
			m_txtHighScore.text = "HIGH SCORE: 0";
			m_txtHighScoreLabel = UIString.getLangLabel(m_txtHighScoreLabel) + ":";
			
			m_txtLevel = ui["txtLevel"];
			m_txtLevel.mouseEnabled = false;
			m_txtLevel.selectable = false;
			m_txtLevel.text = "LEVEL:0 TARGET SCORE:2000";
			m_txtLevelLabel = UIString.getLangLabel(m_txtLevelLabel) + ":";
			m_txtTargetScoreLabel = UIString.getLangLabel(m_txtTargetScoreLabel) + ":";
			
			
			
			m_txtStepTips = ui["txtStepTips"];
			m_txtStepTips.mouseEnabled = false;
			m_txtStepTips.selectable = false;
			m_txtStepTips.text = "";
			m_txtStepTips.visible = false;
			
			
			m_height = m_txtScore.y + m_txtScore.height + 10;
			
			
			m_txtBubbleLabel = UIString.getLangLabel(m_txtBubbleLabel);
			
			m_btnPause = ui["btnPause"];
			m_btnPause.addEventListener(MouseTouch.TAP, onBtnPause);
		}
		
		
		public function setStepScore(stepScore:int, markCount:int):void
		{
			Tweener.removeAllTweens();
			
			m_stepScore = stepScore;
			m_markCount = markCount;
			
			updateScoreView();
		}
		
		public function levelPass():void
		{
			var s:String = m_txtLevelInfo + " ("+UIString.getLangLabel("Passed")+"!)";
			m_txtLevel.htmlText = "<font color='#00ff00'>"+s+"</font>";
		}
		
		public function updateTotalScore(total:int, step:int):void
		{
			/*
			m_txtStepTips.visible = true;
			m_txtStepTips.text = "+" + step;
			m_txtStepTips.x = ui.mouseX;
			m_txtStepTips.y = ui.mouseY;
			m_txtStepTips.alpha = 1;
			
			Tweener.removeTweens(m_txtStepTips);
			
			Tweener.addTween(m_txtStepTips, {time:0.8, x:m_txtScore.x, y: m_txtScore.y});
			Tweener.addTween(m_txtStepTips, {time:0.3, delay:0.8, alpha:0});
			*/
			
			stepScore = step;
			
			Tweener.addTween(this, {time:0.2, totalScore:total});
			Tweener.addTween(this, {time:0.2, stepScore:0});
		}
		
		public function set totalScore(value:int):void
		{
			m_totalScore = value;
			updateScoreView();
		}
		
		public function get totalScore():int
		{
			return m_totalScore;
		}
		
		public function set stepScore(value:int):void
		{
			m_stepScore = value;
		}
		
		public function get stepScore():int
		{
			return m_stepScore;
		}
		
		
		
		
		private function updateScoreView():void
		{
			if(m_stepScore > 0)
			{
				m_txtScore.text = m_txtScoreLabel + m_totalScore.toString() + 
					" ( + "+m_stepScore.toString()+" / "+m_markCount+m_txtBubbleLabel +")";
			}
			else
			{
				m_txtScore.text = m_txtScoreLabel + m_totalScore.toString();
			}
		}
		
		//--------------------------------------------------
		
		
		
		override public function set visible(value:Boolean):void
		{
			m_visible = value;
			m_imgScore.visible = value;
			m_txtScore.visible = value;
			m_txtStepTips.visible = value;
			m_txtMode.visible = value;
			m_btnPause.visible = value;
		}
		
		override public function get visible():Boolean
		{
			return m_visible;
		}
		
		//------------------------------------------------------------
		
		public function start(mode:int, level:int, totalScore:int):void
		{
			m_totalScore = totalScore;
			m_markCount = 0;
			m_stepScore = 0;
			
			m_txtMode.text = UIString.getModeLabel(mode);
			
			m_txtHighScore.text = m_txtHighScoreLabel + StageData.highScore.toString();
			
			m_txtLevelInfo = m_txtLevelLabel + level + " " + m_txtTargetScoreLabel + StageData.getLevelScore(level);
			m_txtLevel.text = m_txtLevelInfo;
			
			updateScoreView();
		}
		
		//------------------------------------------------------------
		
		override public function set width(value:Number):void
		{
			m_btnPause.x = (value - m_btnPause.width - 10);
		}
		
		
		override public function set height(value:Number):void
		{
			
		}
		
		
		override public function get height():Number
		{
			return m_height;
		}
		
		
		private function onBtnPause(e:Event):void
		{
			Controller.execute(StagePauseCommand);
		}
	}
	
	
	
}