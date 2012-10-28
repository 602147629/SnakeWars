package model 
{
	
	import model.game.GameState;
	import starling.events.Event;
	import model.network.*;
	import starling.events.*;
		
	public class Model extends EventDispatcher
	{		
		
		public static var instance:Model;
		private static var allowInstantiation:Boolean = false;
		
				
		public static var CONNECT_AND_AUTH_OK:String = "connectAndAuthOk";
		public static var GAME_LIST_RECEIVED:String = "gameListReceived";
		
		public static var GAME_ROOM_ENTERED:String = "gameRoomEntered";
		
		public var gameListArray:Array;
		
		public var network:Network = new Network();
		
		private var gameState:GameState = new GameState();
		
		public function Model():void {
			if (!allowInstantiation) {
			throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
		
		public static function getInstance():Model {
			
			if (instance == null) 
			{
				allowInstantiation = true;
				instance = new Model();
				allowInstantiation = false;
			}
			
			return instance;
		}		
		
		public function startNetworkInteraction(desiredUsername:String)
		{
			addNetworkEventListeners();
			network.init(desiredUsername);
		}
		
		public function createGameRoom()
		{
			network.createRoom();
		}
		
		public function getGameRoomsList()
		{
			network.getGameRoomsList();
		}
		
		private function addNetworkEventListeners()
		{
			network.addEventListener(Network.LOGIN_SUCCESFUL, loginSuccesfulHandler);
			network.addEventListener(Network.GAME_LIST_RECEIVED, gameListReceivedHandler);
			network.addEventListener(Network.GAME_ROOM_ENTERED, gameRoomEnteredHandler);
		}
		
		private function loginSuccesfulHandler(e:Event)
		{
			dispatchEvent(new Event(Model.CONNECT_AND_AUTH_OK));
		}
		
		private function gameListReceivedHandler(e:Event)
		{
			gameListArray = network.gameRooms;
			dispatchEvent(new Event(Model.GAME_LIST_RECEIVED));
		}
		
		private function gameRoomEnteredHandler(e:Event)
		{
			gameState.resetState();
			dispatchEvent(new Event(Model.GAME_ROOM_ENTERED));
		}
		
		
	}

}