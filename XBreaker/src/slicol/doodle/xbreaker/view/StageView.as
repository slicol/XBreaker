package slicol.doodle.xbreaker.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import slicol.doodle.xbreaker.data.BubbleData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.model.GameStage;
	import slicol.foundation.singleton.SingletonFactory;
	
	public class StageView extends Sprite
	{		
		public static function get me() : StageView 
		{
			return SingletonFactory.getInstance(StageView);
		}
		
		
		
		private var m_lstBubble:Array;
		private var m_data:StageData;
		private var m_width:Number = 0;
		private var m_height:Number = 0;
		private var m_theme:int = 0;

		public function StageView()
		{
			super();
		}
		
		public function start(theme:int):void
		{			
			m_data = GameStage.me.data;
			
			if(this.m_lstBubble != null)
			{
				if( this.m_lstBubble.length != m_data.width ||
					this.m_lstBubble[0].length != m_data.height ||
					this.m_theme != theme)
				{
					resize(m_data.width, m_data.height);
				}
			}
			else
			{
				resize(m_data.width, m_data.height);
			}
			
		
			m_theme = theme;
			
			var x:int;
			var y:int;
			
			for(x = 0; x < m_data.width; ++x)
			{
				for(y = 0; y < m_data.height; ++y)
				{
					var view:BubbleView = m_lstBubble[x][y];
					view.data = m_data.scene[x][y];
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function resize(w:int,h:int):void
		{
			var x:int;
			var y:int;
			var bubble:BubbleView;
			
			//Release Old
			if(this.m_lstBubble != null)
			{
				for(x = 0; x < this.m_lstBubble.length; ++x)
				{
					var arrCol:Array = this.m_lstBubble[x];
					for(y = 0; y < arrCol.length; ++y)
					{
						bubble = this.m_lstBubble[x][y];
						bubble.dispose();
						this.removeChild(bubble);
					}
				}						
			}
			
			//Create New
			this.m_lstBubble = new Array(w);
			for(x = 0; x < w; ++x)
			{
				this.m_lstBubble[x] = new Array(h);
				for(y = 0; y < h; ++y)
				{
					bubble = new BubbleView;
					bubble.x = x * BubbleView.width;
					bubble.y = y * BubbleView.height;
					this.addChild(bubble);
					this.m_lstBubble[x][y] = bubble;
					
				}
			}
			
			m_width =  BubbleView.width * w;
			m_height = BubbleView.height * h;
		}
		
		
		override public function get width():Number	{return m_width;	}
		override public function get height():Number	{return m_height;	}
		
		private function onFrame(e:Event):void
		{
			var x:int;
			var y:int;
			var view:BubbleView;
			
			if(this.m_lstBubble != null)
			{
				for(x = 0; x < this.m_lstBubble.length; ++x)
				{
					var arrCol:Array = this.m_lstBubble[x];
					for(y = 0; y < arrCol.length; ++y)
					{
						view = this.m_lstBubble[x][y];
						view.update();
					}
				}						
			}
		}
		

		
	}
}