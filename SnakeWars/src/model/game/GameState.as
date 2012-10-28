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
		
		public function GameState() 
		{
			
		}
		
		public function resetState()
		{
			iAmReady = false;
			opponentReady = false;
		}
		
	}

}