package slicol.doodle.xbreaker.view.ui.menu
{
	import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import slicol.doodle.xbreaker.data.SetupData;
	import slicol.doodle.xbreaker.view.ui.UIResHelper;
	import slicol.doodle.xbreaker.view.ui.common.UIMenuBase;
	import slicol.doodle.xbreaker.view.ui.lang.UIString;
	
	public class UIMenuSetup extends UIMenuBase
	{
		
		//private var m_lstThemeItem:Vector.<ChkItem>;
		private var m_lstModeItem:Vector.<ChkItem>;
		private var m_itemMode:MovieClip;
		
		
		public function UIMenuSetup(container:Sprite)
		{
			super((new UIResHelper.UIMenuSetup) as MovieClip, container);
			
			var i:int = 0;
			var item:ChkItem;
			
			m_itemMode = content["itemMode"];
			m_itemMode["txtLabel"].text = UIString.getLangLabel("MODE SELECT");
			TextField(m_itemMode["txtLabel"]).mouseEnabled = false;
			
			/*
			m_lstThemeItem = new Vector.<ChkItem>;
			for(i = 1; i <= 3; i++)
			{
				item = new ChkItem(content["chkTheme" + i], i - 1);
				item.locked = false;
				item.selected = false;
				item.onClick.add(onThemeClick);
				m_lstThemeItem.push(item);
			}
			m_lstThemeItem[0].selected = true;
			*/
			
			m_lstModeItem = new Vector.<ChkItem>;
			for(i = 1; i <= 4; i++)
			{
				item = new ChkItem(content["chkMode" + i], i - 1);
				item.locked = false;
				item.selected = false;
				item.onClick.add(onModeClick);
				item.label = UIString.getModeLabel(i - 1);
				m_lstModeItem.push(item);
			}
			m_lstModeItem[0].selected = true;
			m_lstModeItem[0].locked = false;

		}
		
		/*
		private function onThemeClick(index:int):void
		{
			SetupData.theme = index + 1;
			
			var i:int = 0; 
			
			for(i = 0; i < m_lstThemeItem.length; ++i)
			{
				m_lstThemeItem[i].selected = false;
			}
			
			m_lstThemeItem[index].selected = true;
		}
		*/
		
		
		private function onModeClick(index:int):void
		{
			SetupData.mode = index;
			
			var i:int = 0; 
			
			for(i = 0; i < m_lstModeItem.length; ++i)
			{
				m_lstModeItem[i].selected = false;
			}
			
			m_lstModeItem[index].selected = true;
		}
	}
}
import com.tencent.fge.engine.ui.UIMovieClipCtlBase;
import com.tencent.fge.foundation.signals.Signal;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import slicol.touch.MouseTouch;

class ChkItem extends UIMovieClipCtlBase
{
	private var m_imgSelected:MovieClip;
	private var m_imgLock:MovieClip;
	private var m_locked:Boolean = true;
	private var m_txtLabel:TextField;
	
	private var m_index:int;
	
	public var onClick:Signal = new Signal(int);
	
	public function ChkItem(ui:MovieClip, index:int):void
	{
		super(ui);
		
		m_index = index;
		
		m_txtLabel = ui["txtLabel"];
		
		if(m_txtLabel)
		{
			m_txtLabel.selectable = false;
			m_txtLabel.mouseEnabled = false;
		}
		
		m_imgSelected = ui["imgSelected"];
		m_imgSelected.visible = false;
		m_imgSelected.mouseEnabled = false;
		
		m_imgLock = ui["imgLock"];
		if(m_imgLock)
		{
			m_imgLock.mouseEnabled = false;
		}
		
		
		
		ui.addEventListener(MouseTouch.TAP, onUIClick);
		
	}
	
	private function onUIClick(e:Event):void
	{

		if(m_locked)
		{
			return;
		}
		
		onClick.dispatch(m_index);
	}
	
	
	public function set selected(value:Boolean):void
	{
		m_imgSelected.visible = value;
	}
	
	public function get selected():Boolean
	{
		return m_imgSelected.visible;
	}
	
	public function get locked():Boolean
	{
		return m_locked;
	}
	
	public function set locked(value:Boolean):void
	{
		m_locked = value;
		ui.buttonMode = !value;
		
		if(m_imgLock)
		{
			m_imgLock.gotoAndStop(value ? 1 : 2);
		}
	}
	
	public function set label(v:String):void
	{
		m_txtLabel.text = v;
	}
}