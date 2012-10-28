package view 
{
	import starling.display.Sprite;
	import view.util.ContentManipulator;
	import starling.events.Event;
	import view.util.ContentRequester;
	
	public class View extends Sprite
	{
		public var contentManipulator:ContentManipulator;
		
		// events
		public static var USERNAME_SELECTED:String = "usernameSelected";		
		public var desiredUsername:String;
		
		public static var REFRESH_GAME_ROOMS_REQUEST:String = "refreshGameRooms";
		
		public static var JOIN_ROOM_REQUEST:String = "joinRoomRequest";
		public var gameId:int = 0;
		
		// end events
		
		public function View() 
		{
			
		}
		
		public function init():void
		{
			contentManipulator = new ContentManipulator();
			contentManipulator.init();
			addChild(contentManipulator);
			
			contentManipulator.addEventListener(ContentManipulator.CONTENT_CHANGED, contentChangedHandler);
			contentManipulator.addEventListener(ContentRequester.REQUEST_ROOM_LIST, getRoomListHandler);
			contentManipulator.addEventListener(ContentRequester.CREATE_ROOM, createRoomHandler);
		}
		
		// start requests
		
		public function moveToLobby()
		{
			
		}
		
		// gameRoomsArray - id-uri
		public function addGameRooms(gameRoomsArray:Array)
		{
			
		}
		
		public function moveToGame()
		{
			
		}
		
		// end requests
		
		private function contentChangedHandler(e:Event):void
		{
			var contentRequestId:int = ContentManipulator(e.target).ContentPointerId;
			
			switch(contentRequestId)
			{
				case 0:
					break;
				case 1:
					goToLobbyScreen();
					break;
				case 2:
					goToGameScreen();
					break;
				case -1:
					showError("Could not retrieve content");
					break;
			}
		}
		
		// requests
		public function goToLobbyScreen()
		{
			trace("Lobby");
		}
		
		public function showError(errorMessage:String)
		{
			
		}
		
		public function goToGameScreen()
		{
			trace("Game");
		}
		
		
		public function getRoomListHandler(e:Event):void
		{
			trace("GetRoomList");
		}
		
		public function createRoomHandler(e:Event):void
		{
			trace("Create room");
		}
		
		
		
	}

}