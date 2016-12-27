package slicol.doodle.xbreaker.view.ui.common
{
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	import com.tencent.fge.foundation.signals.Signal;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	import slicol.touch.MouseTouch;
	
	
	public class UIMenuBase extends UIMovieClipMobilePageBase
	{
		private var m_btnBack:MovieClip;
		
		public var onBack:Signal = new Signal;

		
		public function UIMenuBase(ui:MovieClip, container:Sprite = null)
		{
			super(ui, container);

			m_btnBack = ui["btnBack"];
			if(m_btnBack)
			{
				m_btnBack.buttonMode = true;
				m_btnBack.addEventListener(MouseTouch.TAP, onBtnBack);
				m_btnBack["txtLabel"].text = UIString.getLangLabel("BACK");
				TextField(m_btnBack["txtLabel"]).mouseEnabled = false;
			}
		}
		 
		
		public function show():void
		{
			updateLayout();
			
			content.alpha = 0;
			Tweener.addTween(content, {time:0.6, alpha:1});
			
			this.visible = true;
			this.alpha = 0;
			Tweener.addTween(this, {time:0.6, alpha:1});
		}
		
		public function hide():void
		{
			Tweener.addTween(content, {time:0.6, alpha:0});
			Tweener.addTween(this, {delay:0.4, time:0.2, alpha:0, visible:false});
		}
		
		
		private function onBtnBack(e:Event):void
		{
			this.hide();
			onBack.dispatch();
		}
		
	}
}