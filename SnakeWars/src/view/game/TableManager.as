package view.game 
{
	import flash.display.BitmapData;
	import starling.events.Event;
	import flash.geom.Point;
	import model.game.GameState;
	import model.game.Table;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
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
		private var snakeData:Texture;
		private var enemySnakeData:Texture;
		
		private var gameState:GameState;
		private var piecesArray:Array;
		
		public function TableManager() 
		{
			//gameState.getInstance();
			gameState = new GameState();
			gameState.initPlayGrid();
			gameState.insertMySnake();
			gameState.insertEnemySnake();
			
			table = new Table();
			tileArray = new Array();
			piecesArray = new Array();
			
			cols = table.Cols;
			rows = table.Rows;
			
		}
		
		public function drawGrid(widthMax:Number, heightMax:Number):void
		{	
			tileWidth = int(widthMax / cols);
			tileHeight = int(heightMax / rows);
			
			tileData = Texture.fromBitmapData(Assets.getTileBitmap(tileWidth, tileHeight, 0xCCCCCC));
			coinData = Texture.fromBitmapData(Assets.getCircleBitmap(tileWidth / 4, 0xe2ad5c));
			snakeData = Texture.fromBitmapData(Assets.getRectangleBitmap(tileWidth,tileHeight, 0xFF5C5C));
			enemySnakeData = Texture.fromBitmapData(Assets.getRectangleBitmap(tileWidth,tileHeight, 0x70C741));

			
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
			
			drawSnakesOnGrid(gameState.playGrid);
			gameState.moveOpponentSnake("moveForward");
			drawSnakesOnGrid(gameState.playGrid);
			gameState.moveOpponentSnake("moveRight");
			drawSnakesOnGrid(gameState.playGrid);			
		}
		
		public function drawSnakesOnGrid(gameStateArray:Array):void
		{
			for (var c:int = 0; c < piecesArray.length; c++)
			{
				removeChild(piecesArray[c]);
				piecesArray[c] = null;
			}
			
			for (var i:int = 0; i < cols; i++)
				for (var j:int = 0; j < rows; j++)
				{
					if (gameStateArray[i][j] == 1)
					{
						var image:Image = new Image(snakeData);
						image.x = i * tileWidth;
						image.y = j * tileHeight;
						addChild(image);
						piecesArray.push(image);
						
					}
					else if (gameStateArray[i][j] == 2)
					{
						var image:Image = new Image(enemySnakeData);
						image.x = i * tileWidth;
						image.y = j * tileHeight;
						addChild(image);
						piecesArray.push(image);
					}
					else if (gameStateArray[i][j] == 3)
					{
						var image:Image = new Image(coinData);
						image.x = i * tileWidth;
						image.y = j * tileHeight;
						addChild(image);
						piecesArray.push(image);
					}
				}
		}
		
		public function resetAllPieces():void
		{	
			// Clear the arrays
		}
		
		
	}

}