package slicol.doodle.xbreaker.view.ui.common
{
	import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class UIMovieClipMobilePageBase extends UIMovieClipCtlBase
	{
		private var m_background:MovieClip;
		private var m_content:MovieClip;
		
		private var m_contentWidth:Number = 0;
		private var m_contentHeight:Number = 0;
		private var m_contentX:Number = 0;
		private var m_contentY:Number = 0;
		
		public function UIMovieClipMobilePageBase(ui:MovieClip=null, contanier:Sprite=null)
		{
			ui.gotoAndStop(1);
			
			if(ui.hasOwnProperty("background"))
			{
				m_background = ui["background"];
			}
			else if(ui.hasOwnProperty("imgBackground"))
			{
				m_background = ui["imgBackground"];
			}
			else if(ui.hasOwnProperty("imgSkin"))
			{
				m_background = ui["imgSkin"];
			}
			
			m_content = ui;
			m_contentWidth = ui.width;
			m_contentHeight = ui.height;
			
			var myui:MovieClip;
			myui = new MovieClip;
			
			if(m_background)
			{
				myui.addChild(m_background);
			}
			
			myui.addChild(m_content);

			super(myui);
			
			
			if(contanier)
			{
				contanier.addChild(myui);
			}
		}
		
		public function get content():MovieClip{return m_content;}
		public function get contentWidth():Number{return m_contentWidth;}
		public function get contentHeight():Number{return m_contentHeight;}
		
		override public function get width():Number
		{
			if(ui.stage)
			{
				return ui.stage.stageWidth;
			}
			return contentWidth;
		}
		
		override public function get height():Number
		{
			if(ui.stage)
			{
				return ui.stage.stageHeight;
			}
			return contentHeight;
		}
		
		override public function set width(value:Number):void{}
		override public function set height(value:Number):void{}
		
		public function updateLayout():void
		{
			if(ui.stage && m_background)
			{
				m_background.width = ui.stage.stageWidth;
				m_background.height = ui.stage.stageHeight;
			}
			
			m_content.x = (ui.stage.stageWidth - contentWidth)/2;
			m_content.y = (ui.stage.stageHeight- contentHeight)/2;
		}
	}
}