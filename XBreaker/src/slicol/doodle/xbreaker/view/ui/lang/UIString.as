package slicol.doodle.xbreaker.view.ui.lang
{
	import com.tencent.fge.utils.StringUtil;
	
	import flash.system.Capabilities;
	import flash.utils.Dictionary;

	public class UIString
	{
		public static const LANG_EN:int = 0;
		public static const LANG_ZH_CN:int = 1;
		public static const LANG_ZH_TW:int = 2;
		
		public static var Lang:int = LANG_EN;
		
		public function UIString()
		{
		}
		
		public static function useSystemLang():void
		{
			if(Capabilities.language == "zh-CN")
			{
				Lang = LANG_ZH_CN;
			}
			else
			{
				Lang = LANG_EN;
			}
		}
		
		public static function getLangLabel(name:String):String
		{
			if(!MapLangEN2CN)
			{
				initLangLabel();
			}
			
			if(Lang == LANG_ZH_CN)
			{
				
				var tmp:String = name.toLowerCase();
				tmp = StringUtil.trimBack(tmp, " ");
				tmp = MapLangEN2CN[tmp];
				if(tmp)
				{
					return tmp;
				}
			}
			
			return name;
		}
		
		public static function getModeLabel(mode:int):String
		{
			if(Lang == LANG_ZH_CN)
			{
				return ModeNameList_CN[mode];
			}
			
			return ModeNameList_EN[mode];
		}
		

		public static var ModeNameList_EN:Array = new Array("Standard","Series","Shift","Shift Series");
		public static var ModeNameList_CN:Array = new Array("标准模式","连续模式","位移模式","连续位移模式");
		
		public static var MapLangEN2CN:Dictionary;

		private static function initLangLabel():void
		{
			MapLangEN2CN = new Dictionary;
			
			MapLangEN2CN["new game"] = "开始游戏";
			MapLangEN2CN["about"] = "关于";
			
			MapLangEN2CN["mode"] = "模式选择";
			MapLangEN2CN["mode select"] = "模式选择";
			MapLangEN2CN["back"] = "返回";
			
			MapLangEN2CN["quit"] = "结束游戏";
			MapLangEN2CN["replay"] = "重新开始";
			MapLangEN2CN["resume"] = "继续游戏";
			
			MapLangEN2CN["high score"] = "最高分数";
			
			MapLangEN2CN["game mode"] = "游戏模式";
			
			MapLangEN2CN["total score"] = "本局得分";
			
			MapLangEN2CN["score"] = "当前分数";
			
			MapLangEN2CN["target score"] = "目标分数";
			MapLangEN2CN["level"] = "当前等级";
			
			MapLangEN2CN["pass"] = "通关";
			MapLangEN2CN["passed"] = "通关";
			
			MapLangEN2CN["bubble count"] = "泡泡总数";
			MapLangEN2CN["bubble"] = "泡泡";
			
			MapLangEN2CN["tap to main menu"] = "随意点击屏幕 返回主菜单";
			MapLangEN2CN["tap to next level"] = "随意点击屏幕 开始下一关";
			
			MapLangEN2CN["level passed"] = "目标达成";
			
			
		}
		
		private static var m_mapTipsText:Dictionary ;

		
		public static function getTipsText(markCount:int):String
		{
			if(!m_mapTipsText)
			{
				m_mapTipsText = new Dictionary;
				m_mapTipsText[0] = ["Very Good!","非常不错哦!"];
				m_mapTipsText[1] = ["You Are Great!","真是太厉害了!"];
				m_mapTipsText[2] = ["Wow, It Is Surprising!","哇，真是让人惊讶!!"];
			}
			
			if(markCount < 10)
			{
				return "";
			}
			
			if(markCount > 20)
			{
				markCount = 20;
			}
			

			var lst:Array = m_mapTipsText[int((markCount - 10)/5)];
			var s:String = lst[Lang];
			
			return s;
		}
	}
}