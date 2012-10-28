package model.game 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	public class GameState 
	{
		
		public var iAmReady:Boolean = false;
		public var opponentReady:Boolean = false;
		
		public var playGrid:Array = new Array();
		
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
			
		}
		
		public function insertEnemySnake()
		{
			
		}
		
		public function moveMySnake(direction:String)
		{
			
		}
		
		public function moveOpponentSnake(direction:String)
		{
			
		}
		
	}

}