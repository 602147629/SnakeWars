package view.game 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import model.game.Table;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import view.util.Assets;

	public class TableManager extends Sprite
	{
		private const coinNumber:int = 10;
		private const snakeNumber:int = 10;
		
		private var cols:int;
		private var rows:int;
		
		private var tileWidth:int;
		private var tileHeight:int;
		
		private var table:Table;
		private var tileData:Texture;
		private var tileArray:Array;
		
		private var coinData:Texture;
		private var coinPool:Array;
		
		private var snakeData:Texture;
		private var snakePool:Array;
		
		public function TableManager() 
		{
			table = new Table();
			coinPool = new Array();
			snakePool = new Array();
			tileArray = new Array();
			
			cols = table.Cols;
			rows = table.Rows;
		}
		
		public function drawGrid(widthMax:Number, heightMax:Number):void
		{	
			tileWidth = int(widthMax / cols);
			tileHeight = int(heightMax / rows);
			
			tileData = Texture.fromBitmapData(Assets.getTileBitmap(tileWidth, tileHeight, 0xCCCCCC));
			coinData = Texture.fromBitmapData(Assets.getCircleBitmap(tileWidth / 4, 0xe2ad5c));
			snakeData = Texture.fromBitmapData(Assets.getRectangleBitmap(tileWidth / 8, tileHeight / 8, 0xFF5C5C));
			
			for (var i:int = 0; i < cols; i++)
			{
				tileArray.push(new Array);
				for (var j:int = 0; j < rows; j++)
				{
					var tileVisual:TileVisual = new TileVisual();
					tileVisual.init(tileData);
					tileVisual.x = i * tileWidth;
					tileVisual.y = j * tileHeight;
					tileVisual.Center = new Point(i * tileWidth + tileWidth * .5, j * tileHeight + tileHeight * .5);
					
					tileArray[i].push(tileVisual);
					addChild(tileVisual);
				}
			}
		}
		
		public function generatePools():void
		{
			for (var i:int = 0; i < coinNumber; i++)
			{
				var coin:CoinVisual = new CoinVisual(coinData);
				coin.visible = false;
				
				addChild(coin);
				coinPool.push(coin);
			}
			
			for (var j:int = 0; j < snakeNumber; j++)
			{
				var snake:SnakeVisual = new SnakeVisual(snakeData);
				snake.visible = false;
				
				addChild(snake);
				snakePool.push(snake);
			}
			
		}
		
		public function drawSnakeAtPos(pointX:int, pointY:int):Boolean
		{
			for (var i:int = 0; i < snakePool.length; i++)
			{
				if (snakePool[i].visible == false)
				{
					snakePool[i].visible = true;
					snakePool[i].x = TileVisual(tileArray[pointX][pointY]).Center.x;
					snakePool[i].y = TileVisual(tileArray[pointX][pointY]).Center.y;
				}
			}
			
			return false;
		}
		
		public function drawEnemySnakeAtPos(pointX:int, pointY:int):void
		{
			
		}
		
		public function drawCoinAtPos(pointX:int, pointY:int):Boolean
		{
			for (var i:int = 0; i < coinPool.length; i++)
			{
				if (coinPool[i].visible == false)
				{
					coinPool[i].visible = true;
					coinPool[i].x = TileVisual(tileArray[pointX][pointY]).Center.x;
					coinPool[i].y = TileVisual(tileArray[pointX][pointY]).Center.y;
					coinPool[i].PointWherePlaced = TileVisual(tileArray[pointX][pointY]).Center;
					return true;
				}
			}
			
			return false;
		}
		
		public function removeCoinFromPos(pointX:int, pointY:int):void
		{
			
		}
		
	}

}