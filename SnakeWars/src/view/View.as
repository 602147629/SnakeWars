package view 
{
	import starling.display.Sprite;
	import view.util.ContentManipulator;
	import starling.events.Event;
	import view.util.ContentRequester;
	import view.screens.*;
	
	public class View extends Sprite
	{
		public var contentManipulator:ContentManipulator;
		
		// events
		public static var USERNAME_SELECTED:String = "usernameSelected";		
		public var desiredUsername:String;
		
		//public static var REFRESH_GAME_ROOMS_REQUEST:String = "refreshGameRooms";
		public static var REFRESH_GAME_ROOMS_REQUEST:String = "refreshGameRooms";
		
		public static var JOIN_ROOM_REQUEST:String = "joinRoomRequest";
		public var gameId:int = 0;
		
		public static var CREATE_GAME_ROOM:String = "createGameRoom";
		// end events
		
		public function View() 
		{
			
		}
		
		public function init():void
		{
			contentManipulator = new ContentManipulator();
			contentManipulator.init();
			addChild(contentManipulator);
			
			contentManipulator.addEventListener(ContentRequester.USERNAME_SELECTED, usernameSelectedHandler);
			
			contentManipulator.addEventListener(ContentManipulator.CONTENT_CHANGED, contentChangedHandler);
			contentManipulator.lobby.addEventListener(Lobby.REQUEST_ROOM_LIST, getRoomListHandler);
			contentManipulator.lobby.addEventListener(Lobby.CREATE_ROOM, createRoomHandler);
			contentManipulator.game.addEventListener(Game.USER_IS_READY, userIsReadyHandler);
		}
		
		private function usernameSelectedHandler(e:Event):void
		{
			desiredUsername = FirstScreen(e.target).UserName;
		}
		
		private function userIsReadyHandler(e:Event):void
		{
			trace("User ready");
		}
		
		// start requests
			
		// gameRoomsArray - id-uri
		public function addGameRooms(gameRoomsArray:Array):void
		{
			contentManipulator.addGameRooms(gameRoomsArray);
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
			contentManipulator.goToScreen(1);
		}
		
		public function showError(errorMessage:String)
		{
			contentManipulator.showErrorMessage(errorMessage);
		}
		
		public function goToGameScreen()
		{
			contentManipulator.goToScreen(2);
		}
		
		
		public function getRoomListHandler(e:Event):void
		{
			trace("GetRoomList din view");
			dispatchEvent(new Event(View.REFRESH_GAME_ROOMS_REQUEST));
		}
		
		public function createRoomHandler(e:Event):void
		{
			trace("create room handler din view");
			dispatchEvent(new Event(View.CREATE_GAME_ROOM));
		}
		
	}

}