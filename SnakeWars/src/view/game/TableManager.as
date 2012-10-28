package view.game 
{
	import flash.display.BitmapData;
	import model.game.Table;
	import starling.display.Sprite;
	import view.util.Assets;

	public class TableManager extends Sprite
	{
		private var cols:int;
		private var rows:int;
		
		private var table:Table;
		private var tileData:BitmapData;
		
		public function TableManager() 
		{
			table = new Table();
			
			cols = table.Cols;
			rows = table.Rows;
		}
		
		public function populateTable(width:Number, height:Number):void
		{
			const tileWidth:Number = width / cols;
			const tileHeight:Number = height / rows;
			
			tileData = Assets.getTileBitmap(tileWidth, tileHeight, 0xCCCCCC);
		}
		
	}

}