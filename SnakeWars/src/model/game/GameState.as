package model.game 
{
	import flash.geom.Point;
	
	public class GameState 
	{
		public var iAmReady:Boolean = false;
		public var opponentReady:Boolean = false;
		
		public var playGrid:Array = new Array();
		
		public var mySnakeStartPoint:Point = new Point(0, 0);
		public var enemySnakeStartPoint:Point = new Point(64, 64);
		
		public var mySnake:Snake;
		public var enemySnake:Snake;
		
		public function GameState() 
		{
			
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
			mySnake.enqueue(new Point(mySnake.peak().x +1, mySnake.peak().y));
			mySnake.enqueue(new Point(mySnake.peak().x +1, mySnake.peak().y));
			mySnake.enqueue(new Point(mySnake.peak().x +1, mySnake.peak().y));
			mySnake.enqueue(new Point(mySnake.peak().x +1, mySnake.peak().y));
		}
		
		public function insertEnemySnake()
		{
			enemySnake = new Snake();
			enemySnake.enqueue(enemySnakeStartPoint);
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
			enemySnake.enqueue(new Point(enemySnake.peak().x - 1, enemySnake.peak().y));
		}
		
		public function moveMySnake(direction:String)
		{
			
		}
		
		public function moveOpponentSnake(direction:String)
		{
			
		}
		
	}

}