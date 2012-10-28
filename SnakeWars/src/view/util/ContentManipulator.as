package view.util 
{
	import feathers.data.ListCollection;
	import starling.display.Sprite;
	import view.screens.*;
	import starling.events.Event;
	
	
	public class ContentManipulator extends Sprite
	{
		public static var CONTENT_CHANGED:String = "contentChanged";
		
		private var contentArray:Array;
		
		private var firstScreen:FirstScreen = new FirstScreen();
		private var lobby:Lobby = new Lobby();
		private var game:Game = new Game();
		
		private var oldContentPointer:ContentRequester;
		private var contentPointer:ContentRequester;
		
		public function ContentManipulator() 
		{
			
		}
		
		public function init():void
		{
			contentArray = new Array();
			
			setContent();
			setEventListeners();
		}
		
		public function get ContentPointerId():int
		{
			return this.contentPointer.contentId;
		}
		
		private function setContent():void
		{
			contentArray[0] = firstScreen;
			contentArray[1] = lobby;
			contentArray[2] = game;
			
			for (var i:int = 0; i < contentArray.length; i++)
			{
				contentArray[i].visible = false;
				addChild(contentArray[i]);
			}
			
			contentPointer = firstScreen;
			contentPointer.visible = true;
			contentPointer.init(new Object());
		}
		
		private function setEventListeners():void
		{
			for (var i:int = 0; i < contentArray.length; i++)
			{
				ContentRequester(contentArray[i]).contentId = i;
				ContentRequester(contentArray[i]).addEventListener(ContentRequester.REQUEST_NEW_CONTENT, newContentRequested);
			}
			
		}
		
		private function newContentRequested(e:Event):void
		{
			oldContentPointer = contentPointer;
			oldContentPointer.visible = false;
			contentPointer = contentArray[ContentRequester(e.target).contentToRequestId];			
			contentPointer.visible = true;
			
			if(ContentRequester(e.target).dataObject)
				contentPointer.init(ContentRequester(e.target).dataObject);
				
			dispatchEvent(new Event(CONTENT_CHANGED));
		}
		
		public function addGameRooms(gameRoomsArray:Array):void
		{
			var listCollection:ListCollection = new ListCollection();
			
			for each(var obj:Object in gameRoomsArray)
			{
				listCollection.addItemAt(obj, 0);
			}
			
			Lobby(contentArray[1]).RoomListCollection = listCollection;
		}
	}

}