package view.screens 
{
	import starling.core.Starling;
	import view.game.*;
	import view.util.ContentRequester;

	
	public class Game extends ContentRequester
	{	
		private var currentScreenWidth:Number;
		private var currentScreenHeight:Number;
		
		private var tableManager:TableManager;
		
		public function Game() 
		{
			
		}
		
		override public function init(initData:Object):void
		{
			currentScreenWidth = Starling.current.stage.stageWidth;
			currentScreenHeight = Starling.current.stage.stageHeight;
			
			tableManager = new TableManager();
			tableManager.drawGrid(currentScreenWidth, currentScreenHeight);
			
			addChild(tableManager);
			tableManager.x = (currentScreenWidth - tableManager.width) * .5;
			tableManager.y = (currentScreenHeight - tableManager.height) * .5;
			
			tableManager.generatePools();
		}
	}

}