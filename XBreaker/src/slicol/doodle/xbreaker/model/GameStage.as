package slicol.doodle.xbreaker.model
{

	import com.tencent.fge.foundation.signals.Signal;
	
	import slicol.doodle.xbreaker.data.BubbleData;
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.foundation.singleton.SingletonFactory;
	
	public class GameStage
	{
		public static function get me() : GameStage 
		{
			return SingletonFactory.getInstance(GameStage);
		}

		
		public var data:StageData;
		
		
		public var onStageOver:Signal = new Signal;
		public var onStepClean:Signal = new Signal;
		public var onStepBegin:Signal = new Signal;
		public var onLevelPass:Signal = new Signal;
	
		public function GameStage()
		{
		}
  

		

		
		public function start(w:int,h:int,typeCount:int,mode:int, level:int = 1):void
		{
			var x:int;
			var y:int;
			
			var matBubble:Vector.<Vector.<BubbleData>> = new Vector.<Vector.<BubbleData>>;

			
			for(x = 0; x < w; ++x)
			{
				matBubble.push(new Vector.<BubbleData>);

				for(y = 0; y < h; ++y)
				{
					var bubble:BubbleData = new BubbleData;
					bubble.x = x;
					bubble.y = y;
					bubble.value = 1 + Math.random() * (typeCount);
					bubble.mark = false;
					
					matBubble[x].push(bubble); 
				}
			}
			
			if(level < 2)//level <= 1
			{
				this.data = new StageData;
			}
			
			this.data.scene = matBubble;
			this.data.width = w;
			this.data.height = h;
			this.data.mode = mode;
			this.data.level = level;
			this.data.passed = false;
		}
			

		public function cleanStep():void
		{
			StageData.totalBubbleCount += this.data.markCount;
			this.data.stageScore += this.data.stepScore;			
			clearSelected();
			
			onStepClean.dispatch();
			
			if(!this.data.passed)
			{
				this.data.passed = isLevelPass();
				if(this.data.passed)
				{
					onLevelPass.dispatch();
				}
			}

			
			if(isLevelOver())
			{
				data.stepScore = 0;
				onStageOver.dispatch();
			}
		}
		
		private function clearSelected():void
		{
			var x:int;
			var y:int;
			var i:int;
			var j:int;
			var newCount:int;
			var v:int;
			var w:int = this.data.width;
			var h:int = this.data.height;

			
			for(x = 0; x < w; ++x)
			{
				for(y = h - 1; y >= 0;)
				{
					if(this.data.scene[x][y].mark == true)
					{
						for(i = y; i > 0; --i)
						{
							move(x,i - 1,x,i);
						}
						clear(x,i);
					}
					else
					{
						--y;
					}
				}				
			}	
				
			if(this.data.mode == StageData.SM_SHIFT)
			{
				this.makeShiftClear();
			}
			else if(this.data.mode == StageData.SM_STANDARD_SERIES)
			{
				this.makeSeriesClear();
			}
			else if(this.data.mode == StageData.SM_SHIFT_SERIES)
			{
				this.makeSeriesClear();
				this.makeShiftClear();
			}
		}
		
		
		private function makeSeriesClear():void
		{
			var x:int;
			var y:int;
			var i:int;
			var zeroCount:int;
			var newCount:int;
			var v:int;
			var w:int = this.data.width;
			var h:int = this.data.height;
			
			//Series
			for(x = w - 1; x >= 0;)
			{
				if(this.data.scene[x][h - 1].value == 0)
				{
					newCount = 1 + Math.random() * (h - 1);
					for(y = h - 1; y >= 0; --y)
					{
						for(i = x; i > 0; --i)
						{
							move(i - 1,y,i,y);
						}
						
						if(y > h - newCount)
						{
							v = 1 + Math.random() * (this.data.typeCount);
							setValue(i,y,v);
						}
						else
						{
							clear(i,y);
						}
					}
				}
				else
				{
					--x;
				}
			}			
		}
		
		private function makeShiftClear():void
		{
			var x:int;
			var y:int;
			var i:int;
			var zeroCount:int;
			var w:int = this.data.width;
			var h:int = this.data.height;
			
			
			for(y = 0; y < h; ++y)
			{
				zeroCount = 0;
				for(x = w - 1; x >= 0;)
				{
					if(this.data.scene[x][y].value == 0)
					{
						for(i = x; i > 0; --i)
						{
							move(i - 1,y,i,y);
						}
						clear(i,y);
						++zeroCount;
						if(zeroCount > x)
						{
							break;
						}
					}
					else
					{
						--x;
						zeroCount = 0;
					}
				}
			}				
		}
		
		public function cancelStep():void
		{
			var x:int;
			var y:int;
			var w:int = this.data.width;
			var h:int = this.data.height;

			for(x = 0; x < w; ++x)
			{
				for(y = h - 1; y >= 0; --y)
				{
					if(this.data.scene[x][y].mark == true)
					{
						this.cancelMark(x,y);
					}
				}
			}	
		}
		

		
		public function beginStep(x:int,y:int):void
		{
			var v:int = this.data.scene[x][y].value;
			
			this.data.markCount = 0;
			mark(x,y,v);
			if(this.data.markCount < 2)
			{
				cancelMark(x,y);
				this.data.markCount = 0;
			}
			else
			{
				//this.data.stepScore = this.data.markCount * (this.data.markCount - 1);
				this.data.stepScore = this.data.markCount * this.data.markCount * 5;
				this.onStepBegin.dispatch();
			}
		}
		
		private function mark(x:int,y:int,v:int):Boolean
		{
			if(x > this.data.width - 1) return false;
			if(x < 0) return false;
			if(y > this.data.height - 1) return false;
			if(y < 0) return false;
			

			if(this.data.scene[x][y].mark == true)
			{
				return false;
			}
			
			if(this.data.scene[x][y].value != v)
			{
				return false;
			}

			
			this.data.scene[x][y].mark = true;
			this.data.markCount++;
			
			mark(x+1,y,v);
			mark(x-1,y,v);
			mark(x,y+1,v);
			mark(x,y-1,v)
			
			return true;			
		}
		
		private function cancelMark(x:int,y:int):void
		{
			this.data.scene[x][y].mark = false;
		}
		
		private function move(x1:int,y1:int,x2:int,y2:int):void
		{
			var v:int = this.data.scene[x1][y1].value;
			var m:Boolean = this.data.scene[x1][y1].mark;
			
			this.data.scene[x2][y2].value = v;
			this.data.scene[x2][y2].mark = m;
		}
		
		private function clear(x:int,y:int):void
		{
			this.data.scene[x][y].value = 0;
			this.data.scene[x][y].mark = false;
		}
		
		public function isSelected(x:int, y:int):Boolean
		{
			return this.data.scene[x][y].mark;
		}
		
		public function isNull(x:int,y:int):Boolean
		{
			return this.data.scene[x][y].value == 0;
		}
		
		private function setValue(x:int,y:int,v:int):void
		{
			this.data.scene[x][y].value = v;
			this.data.scene[x][y].mark = false;
		}
		
		
		public function getValue(x:int,y:int):int
		{
			if(x > this.data.width - 1) return 0;
			if(x < 0) return 0;
			if(y > this.data.height - 1) return 0;
			if(y < 0) return 0;
			return this.data.scene[x][y].value;
		}
		
		
		private function isLevelOver():Boolean
		{
			var x:int;
			var y:int;
			var w:int = this.data.width;
			var h:int = this.data.height;

			for(x = 0; x < w; ++x)
			{
				for(y = h - 1; y > -1; --y)
				{
					var v:int = this.data.scene[x][y].value;
					if(v > 0)
					{
						if(v == this.getValue(x - 1,y) 
						|| v == this.getValue(x + 1,y)
						|| v == this.getValue(x,y - 1)
						|| v == this.getValue(x,y + 1))
						{
							return false;
						}
					}
				}
			}
			
			return true;	
		}
		
		private function isLevelPass():Boolean
		{
			if(data.stageScore > StageData.getLevelScore(data.level) - 1)
			{
				return true;
			}
			return false;
		}


	}
}