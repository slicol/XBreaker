package slicol.doodle.xbreaker.view.ui.stage
{
	import com.tencent.fge.foundation.signals.Signal;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.common.UIMenuBase;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.touch.MouseTouch;
	
	public class UIMenuStage extends UIMenuBase
	{
		private var m_btnQuit:MovieClip;
		private var m_btnReplay:MovieClip;
		private var m_btnResume:MovieClip;
		
		
		public var onQuit:Signal = new Signal;
		public var onReplay:Signal = new Signal;
		public var onResume:Signal = new Signal;
		
		
		public function UIMenuStage(container:Sprite)
		{
			super((new UIResHelper.UIMenuStage) as MovieClip, container);
			
			m_btnQuit = content["btnQuit"];
			m_btnQuit.buttonMode = true;
			m_btnQuit.addEventListener(MouseTouch.TAP, onBtnQuit);
			m_btnQuit["txtLabel"].text = UIString.getLangLabel("QUIT");
			m_btnQuit["txtLabel"].mouseEnabled = false;
			
			m_btnReplay = content["btnReplay"];
			m_btnReplay.buttonMode = true;
			m_btnReplay.addEventListener(MouseTouch.TAP, onBtnReplay);
			m_btnReplay["txtLabel"].text = UIString.getLangLabel("REPLAY");
			m_btnReplay["txtLabel"].mouseEnabled = false;
			
			m_btnResume = content["btnResume"];
			m_btnResume.buttonMode = true;
			m_btnResume.addEventListener(MouseTouch.TAP, onBtnResume);
			m_btnResume["txtLabel"].text = UIString.getLangLabel("RESUME");
			m_btnResume["txtLabel"].mouseEnabled = false;
		}

		
		private function onBtnQuit(e:Event):void
		{
			this.hide();
			onQuit.dispatch();
		}
		
		private function onBtnReplay(e:Event):void
		{
			this.hide();
			onReplay.dispatch();
		}
		
		private function onBtnResume(e:Event):void
		{
			this.hide();
			onResume.dispatch();
		}
		

	}
}