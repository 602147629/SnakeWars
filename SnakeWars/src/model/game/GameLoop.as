package model.game 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.events.*;
	import flash.utils.Timer; 
	
	public class GameLoop 
	{
		
		var gameTimer:Timer = new Timer(120);
		
		var gameState:GameState = new GameState();
		
		private var goUp:Boolean = false;
		private var goDown:Boolean = false;
		private var goLeft:Boolean = false;
		private var goRight:Boolean = false;
	
		public function GameLoop() 
		{
			setGameState();
			setWebControls();
			setMainLoop();
		}
		
		private function setGameState()
		{
			
		}
		
		private function setMainLoop()
		{
			gameTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			gameTimer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			trace("timer handler");
			gameState.moveMySnake(Movement.MY_SNAKE_MOVEMENT);
			gameState.moveOpponentSnake(Movement.OPPONENT_SNAKE_MOVEMENT);
		}
		
		private function setWebControls()
		{
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			trace(e.keyCode + " key code");
		}
		
	}

}