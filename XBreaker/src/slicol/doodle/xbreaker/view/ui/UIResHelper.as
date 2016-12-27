package slicol.doodle.xbreaker.view.ui
{
	import flash.utils.Dictionary;
	
	import slicol.doodle.xbreaker.data.StageData;
	import slicol.doodle.xbreaker.data.ThemeData;

	public class UIResHelper
	{
		[Embed(source="../../../../../../assets/ui.swf", symbol="UIStagePanel")]
		public static var UIStagePanel:Class;		
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="UIMenuStage")]
		public static var UIMenuStage:Class;		
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="UIMenuSetup")]
		public static var UIMenuSetup:Class;		
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="UIMenuMain")]
		public static var UIMenuMain:Class;		
		
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="UIStageOver")]
		public static var UIStageOver:Class;
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="UILevelPass")]
		public static var UILevelPass:Class;
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="ImgBackground")]
		public static var ImgBackground:Class;
		
		
		[Embed(source="../../../../../../assets/ui.swf", symbol="ItemBubble")]
		public static var ItemBubble:Class;
		

		
		public function UIResHelper()
		{
		}
		
		
		public static var mapBubbleClass:Dictionary = new Dictionary;
		
		public static function initialize():void
		{
			mapBubbleClass[ThemeData.BUBBLE] = ItemBubble;
		}
	}
}