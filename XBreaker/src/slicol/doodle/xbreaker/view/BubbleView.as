package slicol.doodle.xbreaker.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import slicol.doodle.xbreaker.command.BubbleClickCommand;
	import slicol.doodle.xbreaker.data.BubbleData;
	import slicol.framework.mvc.Controller;
	import slicol.touch.MouseTouch;
	
	public class BubbleView extends Sprite
	{		
		private var m_data:BubbleData;
		private var m_ctlValue:CtlValue;
		
		public static var UIValue:Class;
		public static var width:Number = 25;
		public static var height:Number = 25;
		
		public static var UseExtendRes:Boolean;
		
		public static function bindUIRes(ui:Class, typeCount:int):void
		{
			UIValue = ui;
			
			var tmp:MovieClip = new UIValue;
			width = tmp.width;
			height = tmp.height;
			
			UseExtendRes = tmp.totalFrames / typeCount == 2;
		}
		
		public function BubbleView()
		{
			super();

			m_ctlValue = new CtlValue(new UIValue);
			this.addChild(m_ctlValue.ui);
			
			this.buttonMode = true;
			
			m_ctlValue.x = 0;
			m_ctlValue.y = 0;
			
			this.addEventListener(MouseTouch.TAP, onClick);
		}
		
		public function dispose():void
		{
			this.removeEventListener(MouseTouch.TAP, onClick);

			this.removeChildren();
			
			m_ctlValue.dispose();
			m_ctlValue = null;
		}
		
		
		public function set data(v:BubbleData):void
		{
			m_data = v;
		
		}
		
		public function get data():BubbleData
		{
			return m_data;
		}
		
		public function update():void
		{
			if(m_data)
			{
				m_ctlValue.update(m_data.value, m_data.mark);
			}
		}


		private function onClick(e:Event):void
		{
			Controller.execute(BubbleClickCommand, m_data);
		}
		
		private function onOver(e:Event):void
		{
			
		}
		
		private function onOut(e:Event):void
		{
			
		}
	}
}
import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
import com.tencent.fge.utils.FilterUtil;

import flash.display.MovieClip;

import slicol.doodle.xbreaker.view.BubbleView;


class CtlValue extends UIMovieClipCtlBase
{
	private var m_value:int = 0;
	private var m_mark:Boolean = false;
	
	private static var MarkFilter:Array = FilterUtil.getSelectedFilter(0xeeeeee);
	
	public function CtlValue(ui:MovieClip):void
	{
		super(ui);
		
		gotoAndStop(1);
	}
	
	public function update(v:int, mark:Boolean):void
	{
		if(m_value != v || m_mark != mark)
		{
			m_value = v;
			m_mark = mark;
			
			if(m_value <= 0)
			{
				gotoAndStop(1);
				
				this.renderable = false;
			}
			else
			{
				this.renderable = true;
				
				if(BubbleView.UseExtendRes)
				{
					if(mark)
					{
						gotoAndStop(m_value * 2);
						this.filters = MarkFilter;
					}
					else
					{
						this.filters = MarkFilter;
						gotoAndStop(m_value * 2 - 1);
					}
				}
				else
				{
					gotoAndStop(m_value);
					this.filters = mark ? MarkFilter : null;
				}

			}
		}
	}
}
