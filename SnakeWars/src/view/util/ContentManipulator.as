package view.util 
{
	import starling.display.Sprite;
	import view.screens.*;
	import starling.events.Event;
	
	
	public class ContentManipulator extends Sprite
	{
		
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
		
		private function newContentRequested(e:Event)
		{
			oldContentPointer = contentPointer;
			oldContentPointer.visible = false;
			contentPointer = contentArray[ContentRequester(e.target).contentToRequestId];			
			contentPointer.visible = true;
			contentPointer.init(ContentRequester(e.target).dataObject);
		}
	}

}