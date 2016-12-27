package slicol.doodle.xbreaker.view.ui.menu
{
	import com.tencent.fge.foundation.signals.Signal;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	import slicol.doodle.xbreaker.data.CacheData;
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.common.UIMenuBase;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.touch.MouseTouch;
	
	public class UIMenuMain extends UIMenuBase
	{
		private var m_btnNewStage:MovieClip;
		private var m_btnSetup:MovieClip;
		private var m_btnAbout:MovieClip;
		
		private var m_txtHighScore:TextField;
		private var m_txtTotalBubble:TextField;
		
		public var onNewStage:Signal = new Signal;
		//public var onSetup:Signal = new Signal;
		//public var onAbout:Signal = new Signal;
		
		
		private var m_txtHighScoreLabel:String = "HIGH SCORE";
		private var m_txtTotalBubbleLabel:String = "BUBBLE COUNT";
		
		//Sub Menu
		private var m_uiMenuSetup:UIMenuSetup;
		
		public function UIMenuMain(container:Sprite)
		{
			super(new UIResHelper.UIMenuMain as MovieClip, container);
			
			m_btnNewStage = content["btnNewStage"];
			m_btnNewStage.buttonMode = true;
			m_btnNewStage.addEventListener(MouseTouch.TAP, onBtnNewStage);
			m_btnNewStage["txtLabel"].text = UIString.getLangLabel("NEW GAME");
			m_btnNewStage["txtLabel"].mouseEnabled = false;
			
			m_btnSetup = content["btnSetup"];
			m_btnSetup.buttonMode = true;
			m_btnSetup.addEventListener(MouseTouch.TAP, onBtnSetup);
			m_btnSetup["txtLabel"].text = UIString.getLangLabel("MODE");
			m_btnSetup["txtLabel"].mouseEnabled = false;
			
			m_btnAbout = content["btnAbout"];
			m_btnAbout.buttonMode = true;
			m_btnAbout.addEventListener(MouseTouch.TAP, onBtnAbout);
			m_btnAbout["txtLabel"].text = UIString.getLangLabel("ABOUT");
			m_btnAbout["txtLabel"].mouseEnabled = false;

			
			m_txtHighScore = content["txtHighScore"];
			m_txtHighScore.selectable = false;
			m_txtHighScore.mouseEnabled = false;
			m_txtHighScore.text = "HIGH SCORE:0 / STANDARD";
			m_txtHighScoreLabel = UIString.getLangLabel(m_txtHighScoreLabel) + ":";
			
			
			m_txtTotalBubble = content["txtTotalBubble"];
			m_txtTotalBubble.selectable = false;
			m_txtTotalBubble.mouseEnabled = false;
			m_txtTotalBubble.text = "BUBBLE COUNT:0";
			m_txtTotalBubbleLabel = UIString.getLangLabel(m_txtTotalBubbleLabel) + ":";
			
			
			
			//MenuSetup
			m_uiMenuSetup = new UIMenuSetup(container);
			m_uiMenuSetup.visible = false;
			m_uiMenuSetup.onBack.add(onSetupBack);
			
		}
		
		
		override public function show():void
		{
			super.show();
			
			StageData.highScore = CacheData.me.getHighScore(SetupData.mode );
			m_txtHighScore.text = m_txtHighScoreLabel + StageData.highScore + " / " + UIString.getModeLabel(SetupData.mode);
			m_txtTotalBubble.text = m_txtTotalBubbleLabel + StageData.totalBubbleCount;
		}
		
		private function onBtnNewStage(e:Event):void
		{
			this.hide();
			onNewStage.dispatch();
		}
		
		private function onBtnSetup(e:Event):void
		{
			this.hide();
			m_uiMenuSetup.show();
		}
		
		private function onBtnAbout(e:Event):void
		{
			navigateToURL(new URLRequest("http://www.slicol.com"));
		}
		

		//-----------------------------------------------------------
		
		private function onSetupBack():void
		{
			this.show();
		}
	}
}