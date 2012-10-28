package view.util 
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ContentRequester extends Sprite
	{
		public static const REQUEST_NEW_CONTENT:String = "requestNewContent";	
		public static const REQUEST_ROOM_LIST:String = "requestRoomList";
		public static const CREATE_ROOM:String = "createRoom";
		public static const USERNAME_SELECTED:String = "usernameSelected";
		
		public var contentId:int = -1;
		public var contentToRequestId:int = -1;
		public var dataObject:Object;
		
		public var isInit:Boolean = false;
		
		public function ContentRequester() 
		{
			
		}
		
		public function init(initData:Object):void
		{
			
		}
		
		public function requestContent(contentToRequestIdParam:int, contentData:Object):void
		{
			if (contentId == -1) throw new Error("Did not specify requesting content id");
			if (contentToRequestIdParam == -1) throw new Error("Did not specify content id to request");
			if (contentData == null) throw new Error("contentData Object can't be null");
			
			this.contentToRequestId = contentToRequestIdParam;
			this.dataObject = contentData;
			dispatchEvent(new Event(ContentRequester.REQUEST_NEW_CONTENT));
		}
		
	}

}