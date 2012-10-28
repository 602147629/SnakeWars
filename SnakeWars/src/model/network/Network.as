package model.network 
{

	import flash.display.MovieClip;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.*;
	import com.smartfoxserver.v2.entities.match.*;
	import com.smartfoxserver.v2.entities.data.*;
	import com.smartfoxserver.v2.entities.*;
	import com.smartfoxserver.v2.entities.variables.*;
	import com.smartfoxserver.v2.entities.invitation.*;
	import com.smartfoxserver.v2.requests.game.*;
	import starling.events.EventDispatcher;
	
	import com.smartfoxserver.v2.core.SFSBuddyEvent;
	import com.smartfoxserver.v2.requests.buddylist.*;
	
	import com.smartfoxserver.v2.entities.managers.IRoomManager;
	import starling.events.Event;
	
	import com.smartfoxserver.v2.exceptions.SFSError;
	

	public class Network extends EventDispatcher
	{
		// GAME
		
		public static var GAME_ROOM_ENTERED:String = "gameRoomEntered";
		
		
		//L O B B Y   E V E N T S
		public static var ERROR_MESSAGE:String = "errorMessage";
		
		public static var CONNECTION_FAILURE:String="connectionFailure";
		
		public static var CONNECTION_LOST:String="connectionLost";
		
		public static var LOGIN_SUCCESFUL:String="loginSuccesful";
		
		public static var LOGIN_ERROR:String="loginError";
		
		public static var ROOM_ADDED:String="roomAdded";
		//public var newRoom:GameRoomData=new GameRoomData();
		public var newRoom:Object=new Object();
		
		public static var ROOM_DELETED:String="roomDeleted";
		public var deletedRoomId:int;
		
		public static var USER_JOINED_ROOM:String="userJoinedRoom";
		public var userNameJoinedRoom:String;
		public var roomIdJoinedByUser:int;
		
		public static var USER_LEFT_ROOM:String="userLeftRoom";
		public var userNameLeftRoom:String;
		public var roomIdLeftByUser:int;
		
		public static var GAME_ROOM_JOINED:String="gameRoomJoined";
		
		public static var ROOM_JOIN_ERROR:String="roomJoinError";
		public var roomJoinErrorMessage:String="";
		
		public static var PUBLIC_MESSAGE_RECEIVED:String="publicMessageReceived";
		public var publicMessageObject:Object = new Object();
		
		public static var PRIVATE_MESSAGE_RECEIVED:String="privateMessageReceived";
		public var privateMessageObject:Object = new Object();
				
		public var ZONE_NAME:String = "SnakeWars";
				
		private var sfs:SmartFox;
		private var username:String = "sabin";
		
		public static var GAME_LIST_RECEIVED:String = "gameListReceived";
		public var gameRooms:Array = new Array();
		
		//dummy!!!1
		private var noOfRequests:int = 0;
		
				
		public function Network()
		{
			
		}
		
		public function init(usernameParam:String) 
		{
			
			this.username = usernameParam+ Math.ceil(Math.random()*20)+Math.ceil(Math.random()*11)+Math.ceil(Math.random()*8);
			
			sfs = new SmartFox(false);// --- debug true
			sfs.connect("54.247.26.55",9933);
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			
			sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			
			
			sfs.addEventListener(SFSEvent.ROOM_ADD, onRoomCreated);
			
			sfs.addEventListener(SFSEvent.ROOM_FIND_RESULT, onRoomFindResult);
			//sfs.addEventListener(SFSEvent.USER_FIND_RESULT, onUserFindResult);
						
			//sfs.addEventListener(SFSEvent.ROOM_ADD, roomAddHandler);
			//sfs.addEventListener(SFSEvent.ROOM_REMOVE, roomRemoveHandler);
			
			//sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, userEnterRoomHandler);
			//sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, userExitRoomHandler);		
			
			//sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoin);
			//sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinError);
						
			//sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
			//sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE, onPrivateMessage);
			
			//doar de test
         	//sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
		}
		
		private function onConnection(e:SFSEvent)
		{
			if (e.params.success)
			{
				//trace("Connection Success!");
				sendLoginRequest();
			}
			else
			{
				//trace("Connection Failure: " + e.params.errorMessage);
				dispatchEvent(new Event(Network.CONNECTION_FAILURE));
			}

		}
		
		private function sendLoginRequest() {			
			var optionalParam:ISFSObject=new SFSObject();
			sfs.send( new LoginRequest(username, "", ZONE_NAME));
		}

		private function onConnectionLost(e:SFSEvent)
		{
			//trace("connection lost for reason"+e.params.reason);
			dispatchEvent(new Event(Network.CONNECTION_LOST));
		}
		
		private function onLogin(e:SFSEvent) 
		{
			dispatchEvent(new Event(Network.LOGIN_SUCCESFUL));
		}
		
		private function onLoginError(e:SFSEvent) 
		{
			//trace("logged in error!");
			//trace(e.params.errorMessage+" logged in error reason");
			dispatchEvent(new Event(Network.LOGIN_ERROR));
		}
				
		public function createRoom()
		{
			var roomSettings:RoomSettings = new RoomSettings("r" + Math.ceil(Math.random() * 2) + Math.ceil(Math.random() * 33) + Math.ceil(Math.random() * 123) );
			roomSettings.isGame = true;
			sfs.send( new CreateRoomRequest( roomSettings ));
		}
				
		private function onRoomCreated(evt:SFSEvent):void
     	{
         	trace("Room created: " + evt.params.room);
     	}
				
		public function getGameRoomsList()
		{
				trace("get game rooms list! noOfRequests:" + noOfRequests);
			    var exp:MatchExpression = new MatchExpression(RoomProperties.NAME, StringMatch.NOT_EQUALS, "!");//BoolMatch.EQUALS, true);
                // Find the Rooms
				sfs.send(new FindRoomsRequest(exp));
		}
		
		private function onRoomFindResult(e:SFSEvent)
		{
			trace("rooms found!!");	
			gameRooms.splice(0, gameRooms.length);
			for (var i:int = 0; i < e.params.rooms.length; i++)
			{
				var room:Room = (e.params.rooms[i]);
				trace(room.isGame + " is room game?");
				if (room.isGame) 
				{
				var obj:Object = new Object();
				obj.id = room.id;
				gameRooms.push(obj);
				}
			}
			if (gameRooms.length > 0)
			{
				trace("dispatched game room received");
				dispatchEvent(new Event(Network.GAME_LIST_RECEIVED));				
			}
		}
		/*
		private function onJoin(evt:SFSEvent):void
		{
			var roomJoined:Room = evt.params.room;
			evaluateRoom(roomJoined);
			//trace("joined room!");
		}
				
		private function userEnterRoomHandler(evt:SFSEvent) 
		{
			var room:Room = evt.params.room;
            var user:User = evt.params.user;
			//evaluateRoom(room);
			
			
			userNameJoinedRoom = user.name;
		    roomIdJoinedByUser = room.id;		
			
			//trace("user enter room handler");
			
			dispatchEvent(new Event(Network.USER_JOINED_ROOM));
		}
		
		private function evaluateRoom(room:Room)
		{
			trace("evaluate room :" + room.isGame);
			if (room.isGame)
			{
				//trace("room joinede is game");
				trace("entered game room");
				dispatchEvent(new Event(Network.GAME_ROOM_ENTERED));
			}
			else
			{
				trace("before creating room!!!");
				createRoom();
				//getGameRoomsList();
				//trace("room joined is LOBBY");
				//test
				//getGameRoomsList();
			}
		}
				
		public function joinRoom()
		{
			
		}
		
 
		private function onJoinError(evt:SFSEvent):void
		{
    		trace("Join failed: " + evt.params.errorMessage);
			this.roomJoinErrorMessage = evt.params.errorMessage;
			dispatchEvent(new Event(Network.ROOM_JOIN_ERROR));
		}
		
		private function onPublicMessage(evt:SFSEvent):void
     	{
         var sender:SFSUser = evt.params.sender;
		 this.publicMessageObject.sender = sender.name;
		 this.publicMessageObject.mesaj  = evt.params.message;
         dispatchEvent(new Event(Network.PUBLIC_MESSAGE_RECEIVED));
		}
		
		private function onPrivateMessage(evt:SFSEvent):void {
			var sender:User = evt.params.sender;
			this.privateMessageObject.sender = sender.name;
			this.privateMessageObject.mesaj = evt.params.message;
			dispatchEvent(new Event(Network.PRIVATE_MESSAGE_RECEIVED));
		}
		
		private function roomAddHandler(e:SFSEvent) {
			var room:SFSRoom = e.params.room;
			trace("added room!!!");
			dispatchEvent(new Event(Network.ROOM_ADDED));
		}
		
		private function roomRemoveHandler(e:SFSEvent) {
			var room:SFSRoom = e.params.room;
			deletedRoomId = room.id;
			dispatchEvent(new Event(Network.ROOM_DELETED));
		}
				
		private function userExitRoomHandler(evt:SFSEvent) {
			var room:Room = evt.params.room;
            var user:User = evt.params.user;
			
			userNameLeftRoom = user.name;
			roomIdLeftByUser = room.id;
			
			dispatchEvent(new Event(Network.USER_LEFT_ROOM));
		}
		     
     	private function onRoomCreationError(evt:SFSEvent):void
     	{
         	trace("Room creation failed: " + evt.params.errorMessage);
     	}
				
		public function sendPrivateMessage(toUser:String,mesaj:String) {
			var user:User = sfs.userManager.getUserByName(toUser);
         	sfs.send(new PrivateMessageRequest(mesaj, user.id));
		}
		
		public function sendPublicMessage(mesaj:String) {
			sfs.send(new PublicMessageRequest(mesaj));
		}
		*/
	
}

}