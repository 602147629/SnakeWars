package model.game 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import starling.events.Event;
	import starling.display.*;
	import starling.events.*;
	import flash.utils.setTimeout; 
	
	public class GameLoop extends EventDispatcher
	{
		
				
		public static var instance:GameLoop;
		private static var allowInstantiation:Boolean = false;
		
		private var stageParam:Stage;
		
		var gameState:GameState = new GameState();
		
		private var goUp:Boolean = false;
		private var goDown:Boolean = false;
		private var goLeft:Boolean = false;
		private var goRight:Boolean = false;
	
		public static var TICK:String = "tick";
		
		public function GameLoop():void {
			if (!allowInstantiation) {
			throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
		
		public function setStageRef(stage:Stage)
		{
			trace("SET STAGE REF");
			this.stageParam = stage;
			setGameState();
			setWebControls();
		}
		
		public static function getInstance():GameLoop {
			
			if (instance == null) 
			{
				allowInstantiation = true;
				instance = new GameLoop();
				allowInstantiation = false;
			}
			
			return instance;
		}
		
		private function setGameState()
		{
			setTimeout(timerHandler,150);
		}
		
		private function setMainLoop()
		{
	
		}
		
		private function timerHandler():void
		{
			trace(Movement.MY_SNAKE_MOVEMENT);
			gameState.moveMySnake(Movement.MY_SNAKE_MOVEMENT);
			gameState.moveOpponentSnake(Movement.OPPONENT_SNAKE_MOVEMENT);
			setTimeout(timerHandler, 100);
			dispatchEvent(new Event(GameLoop.TICK));
		}
		
		private function setWebControls()
		{
			stageParam.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			//trace("key down!!");
			//trace(e.keyCode + " key code");
			Movement.MY_SNAKE_MOVEMENT = convertKeyCodeToMovementConstants(e.keyCode);
			//trace(Movement.MY_SNAKE_MOVEMENT);
			//trace("");
		}
		
		private function convertKeyCodeToMovementConstants(keyChar:int):String
		{
			switch(keyChar)
			{
				case 38: { return MovementConstants.MOVE_FORWARD; }
				case 40: { return MovementConstants.MOVE_BACK; }
				case 37: { return MovementConstants.MOVE_LEFT; }
				case 39: { return MovementConstants.MOVE_RIGHT; }
			}
			
			return Movement.MY_SNAKE_MOVEMENT;
		}
		
	}

}