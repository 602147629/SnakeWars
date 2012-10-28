package model.game 
{
	import flash.geom.Point;
	
	public class GameState 
	{
		public const rows:int = 64;
		public const cols:int = 64;
		
		public var iAmReady:Boolean = false;
		public var opponentReady:Boolean = false;
		
		public var playGrid:Array = new Array();
		
		public var mySnakeStartPoint:Point = new Point(0, 32);
		public var enemySnakeStartPoint:Point = new Point(63, 32);
		
		public var mySnake:Snake;
		public var enemySnake:Snake;
		
		public var myPlayerNumber:int = 1;
		
		public function GameState() 
		{
			initPlayGrid();
		}
		
		public function initPlayGrid():void
		{	
			playGrid = new Array();
			for (var i:int = 0; i < cols; i++ )
			{
				playGrid.push(new Array());
				for (var j:int = 0; j < rows; j++)
					playGrid[i].push(0);
			}
			
			insertMySnake();
			insertEnemySnake();
		}
		
		public function resetState()
		{
			iAmReady = false;
			opponentReady = false;
		}
		
		public function insertMySnake()
		{
			mySnake = new Snake();
			mySnake.enqueue(mySnakeStartPoint);
			playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
			mySnake.enqueue(new Point((mySnake.peak().x +1), mySnake.peak().y));
			playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
			mySnake.enqueue(new Point((mySnake.peak().x +1), mySnake.peak().y));
			playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
			mySnake.enqueue(new Point((mySnake.peak().x +1), mySnake.peak().y));
			playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
			mySnake.enqueue(new Point((mySnake.peak().x +1), mySnake.peak().y));
			playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
		}
		
		public function insertEnemySnake()
		{
			enemySnake = new Snake();
			enemySnake.enqueue(enemySnakeStartPoint);
			playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
		}
		
		public function moveMySnake(direction:String)
		{
			var lastPost:Point = mySnake.dequeue();
			playGrid[lastPost.x][lastPost.y] = 0;
			
			trace("move my snake");
			
			switch(direction)
			{
				case MovementConstants.MOVE_BACK:
					mySnake.enqueue(new Point(mySnake.peak().x, mySnake.peak().y + 1));
					playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
					break;
				case MovementConstants.MOVE_FORWARD:
					mySnake.enqueue(new Point(mySnake.peak().x, mySnake.peak().y - 1));
					playGrid[mySnake.peak().x][mySnake.peak().y] = 1;
					break;
				case MovementConstants.MOVE_LEFT:
					mySnake.enqueue(new Point(mySnake.peak().x - 1, mySnake.peak().y));
					playGrid[mySnake.peak().x][mySnake.peak().y] = 1;					
					break;
				case MovementConstants.MOVE_RIGHT:
					mySnake.enqueue(new Point(mySnake.peak().x + 1, mySnake.peak().y));
					playGrid[mySnake.peak().x][mySnake.peak().y] = 1;					
					break;
			}
		}
		
		public function moveOpponentSnake(direction:String)
		{
			var lastPost:Point = enemySnake.dequeue();
			playGrid[lastPost.x][lastPost.y] = 0;
			
			trace("move opponent snake");
			
			switch(direction)
			{
				case MovementConstants.MOVE_BACK:
					enemySnake.enqueue(new Point(enemySnake.peak().x, enemySnake.peak().y + 1));
					playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
					break;
				case MovementConstants.MOVE_FORWARD:
					enemySnake.enqueue(new Point(enemySnake.peak().x, enemySnake.peak().y - 1));
					playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;
					break;
				case MovementConstants.MOVE_LEFT:
					enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
					playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;					
					break;
				case MovementConstants.MOVE_RIGHT:
					enemySnake.enqueue(new Point(enemySnake.peak().x + 1, enemySnake.peak().y));
					playGrid[enemySnake.peak().x][enemySnake.peak().y] = 2;					
					break;
			}
		}
		
	}

}