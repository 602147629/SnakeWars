package  
{

	import model.Model;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import view.View;
	
	public class MainInterface extends Sprite
	{
		private var modelInst:Model;
		private var viewInst:View;
		
		public function MainInterface() 
		{
			Starling.current.stage.stageWidth = 800;
			Starling.current.stage.stageHeight = 480;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Initiate model
			modelInst = Model.getInstance();
			modelInst.addEventListener(Model.CONNECT_AND_AUTH_OK, connectAndAuthOkHandler);
			modelInst.addEventListener(Model.GAME_LIST_RECEIVED, gameListReceivedHandler);
			modelInst.addEventListener(Model.GAME_ROOM_ENTERED, gameRoomEnteredHandler);
			
			// Initiate view
			viewInst = new View();
			viewInst.init();
			addChild(viewInst);
			viewInst.addEventListener(View.USERNAME_SELECTED, usernameSelectedHandler);
			viewInst.addEventListener(View.CREATE_GAME_ROOM, createGameRoomHandler);
			viewInst.addEventListener(View.REFRESH_GAME_ROOMS_REQUEST, refreshGameRoomsRequest);
			viewInst.addEventListener(View.JOIN_ROOM_REQUEST, joinRoomRequestHandler);
		}
		
		private function usernameSelectedHandler(e:Event)
		{
			trace("user name selected handler!!!!");
			modelInst.startNetworkInteraction(viewInst.desiredUsername);
		}
		
		
		private function connectAndAuthOkHandler(e:Event):void
		{
			viewInst.goToLobbyScreen();
			trace("connect");
		}
		
		private function gameListReceivedHandler(e:Event):void
		{
			trace("game list received");
			viewInst.addGameRooms(modelInst.gameListArray);
		}
		
		private function gameRoomEnteredHandler(e:Event):void
		{
			viewInst.goToGameScreen();
		}
		
		private function createGameRoomHandler(e:Event):void
		{
			trace("main interface -  > create game room");
			modelInst.createGameRoom();
		}
		
		private function refreshGameRoomsRequest(e:Event):void
		{
			trace("refresh din main");
			modelInst.getGameRoomsList();
		}
		
		private function joinRoomRequestHandler(e:Event):void
		{
			modelInst.joinRoom(viewInst.gameId);
		}
		
		
	}

}