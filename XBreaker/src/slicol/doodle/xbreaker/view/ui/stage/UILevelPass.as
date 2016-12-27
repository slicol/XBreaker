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
	
	import slicol.doodle.xbreaker.command.StagePassedCommand;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.framework.mvc.Controller;
	import slicol.touch.MouseTouch;
	
	public class UILevelPass extends UIMovieClipCtlBase
	{
		private var m_imgTitle:MovieClip;
		private var m_txtTips:TextField;
		
		private var m_timer:Timer = new Timer(500);
		
		
		public function UILevelPass(container:Sprite)
		{
			super((new UIResHelper.UILevelPass) as MovieClip);
			stop();
			container.addChild(ui);
			
			m_imgTitle = ui["imgTitle"];
			m_imgTitle.mouseEnabled = false;
			
			m_txtTips = ui["txtTips"];
			m_txtTips.selectable = false;
			m_txtTips.mouseEnabled = false;
			m_txtTips.text = UIString.getLangLabel("Tap To Next Level");
			
			ui.addEventListener(MouseTouch.TAP, onUIClick);
			ui.buttonMode = true;
			
			m_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		
		public function show():void
		{
			this.visible = true;
			
			m_timer.start();
	
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
				TweenLite.to(m_txtTips, 0.3, {alpha:1})
			}
			else
			{
				TweenLite.to(m_txtTips, 0.3, {alpha:0})
			}
			
		}
		
		private function onUIClick(e:Event):void
		{
			this.hide();
			Controller.execute(StagePassedCommand);
		}
		
		public function updateLayout():void
		{
			this.width = ui.stage.stageWidth;
			this.height = ui.stage.stageHeight;
		}
	}
}