package view.screens 
{
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.Scroller;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import flash.text.TextFormat;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.Assets;
	import view.util.ContentRequester;
	import starling.core.Starling;
	
	public class Lobby extends ContentRequester
	{
		// UI elements
		private var connTextField:TextField;
		private var errorTextField:TextField;
		
		private var createRoomBtn:Button;
		private var refreshBtn:Button;
		private var roomList:List;
		private var roomListCollection:ListCollection;
		private var pageIndicator:PageIndicator;
		
		// Room list textures
		private const normalSymbolTexture:Texture = Texture.fromBitmapData(Assets.getCircleBitmap(10, 0xff5c5c));
		private	const selectedSymbolTexture:Texture = Texture.fromBitmapData(Assets.getCircleBitmap(10, 0x70c741));
		private const roomItemBackgroundTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(50, 50, 0xCCCCCC));
		private const roomItemDownTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(30, 30, 0xDDDDDD));
		
		public static var CREATE_ROOM:String = "createRoom";
		public static var REQUEST_ROOM_LIST:String = "requestRoomList";
		
		public function Lobby() 
		{
			
		}

		override public function init(initData:Object):void
		{	
			const currentStageWidth:int = Starling.current.stage.stageWidth;
			const currentStageHeight:int = Starling.current.stage.stageHeight;
			const separatorY:int = currentStageHeight * 0.02; 
			const separatorX:int = currentStageWidth * 0.01; 
			
			const btnTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(120, 30, 0xCCCCCC));

			/*
			connTextField = new TextField(200, 20, "Connecting...");
			connTextField.x = (currentStageWidth - connTextField.width) * .5;
			connTextField.y = (currentStageHeight - connTextField.height) * .5;
			addChild(connTextField);
			*/
			
			/*
			errorTextField = new TextField(300, 60, "Error: ");
			errorTextField.color = 0xFF0000;
			errorTextField.x = (currentStageWidth - errorTextField.width) * .5;
			errorTextField.y = connTextField.y + connTextField.height + separatorY;
			errorTextField.visible = false;
			addChild(errorTextField);
			*/
			
			createRoomBtn = new Button(btnTexture, "Create Room");
			createRoomBtn.x = (currentStageWidth - createRoomBtn.width) * .1;
			createRoomBtn.y = separatorY;
			createRoomBtn.addEventListener(Event.TRIGGERED, onCreateRoomHandler);
			addChild(createRoomBtn);
			
			refreshBtn = new Button(btnTexture, "Refresh");
			refreshBtn.x = createRoomBtn.x + createRoomBtn.width + separatorX;
			refreshBtn.y = createRoomBtn.y;
			refreshBtn.addEventListener(Event.TRIGGERED, onRefreshHandler);
			addChild(refreshBtn);
			
			populateRooms();
			
			pageIndicator.y = currentStageHeight - separatorY * 2;
			
			const shorterSide:Number = Math.min(currentStageWidth, currentStageHeight);
			const layout:TiledRowsLayout = TiledRowsLayout(roomList.layout);
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = shorterSide * 0.02;
			layout.gap = shorterSide * 0.01;
				
			roomList.itemRendererProperties.gap = shorterSide * 0.01;
			roomList.y = createRoomBtn.y + createRoomBtn.height + separatorY;
			roomList.width = currentStageWidth;
			roomList.height = pageIndicator.y;
			roomList.validate();
			
			pageIndicator.maximum = Math.ceil(roomList.maxHorizontalScrollPosition / roomList.width) +1;
			pageIndicator.validate();
			pageIndicator.x = (currentStageWidth - pageIndicator.width) * .5;
			
			isInit = true;
		}
		
		private function populateRooms():void
		{
			var collection:ListCollection = this.roomListCollection;
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			
			this.roomList = new List();
			this.roomList.dataProvider = collection;
			this.roomList.layout = listLayout;
			this.roomList.scrollerProperties.snapToPages = true;
			this.roomList.scrollerProperties.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			this.roomList.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			this.roomList.itemRendererFactory = tileListItemRendererFactory;
			this.roomList.onScroll.add(list_onScroll);
			this.roomList.onChange.add(list_onChange);
			this.addChild(this.roomList);
			
			const pageIndicatorLayout:HorizontalLayout = new HorizontalLayout();
			pageIndicatorLayout.gap = 3;
			pageIndicatorLayout.paddingTop = pageIndicatorLayout.paddingRight = pageIndicatorLayout.paddingBottom =
				pageIndicatorLayout.paddingLeft = 6;
				
			pageIndicator = new PageIndicator();
			pageIndicator.normalSymbolFactory = function():Image
			{
				return new Image(normalSymbolTexture);
			}
			pageIndicator.selectedSymbolFactory = function():Image
			{
				return new Image(selectedSymbolTexture);
			}
			pageIndicator.layout = pageIndicatorLayout;
			pageIndicator.maximum = 1;
			addChild(pageIndicator);
		}
		
		private function onCreateRoomHandler(e:Event):void
		{
			trace("create room handler!!!!");
			dispatchEvent(new Event(Lobby.CREATE_ROOM));
		}
		
		private function onRefreshHandler(e:Event):void
		{
			refreshRoomList();
			roomList.dataProvider = this.roomListCollection;
			roomList.invalidate();
		}
		
		private function tileListItemRendererFactory():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "label";
			renderer.itemHasIcon = false;
			renderer.itemHasLabel = true;
			renderer.defaultSkin = new Image(roomItemBackgroundTexture);
			renderer.downSkin = new Image(roomItemDownTexture);
			renderer.width = 200;
			renderer.height = 200;
			return renderer;
		}
		
		protected function refreshRoomList():void
		{
			dispatchEvent(new Event(ContentRequester.REQUEST_ROOM_LIST,true));
		}
		
		protected function createRoom():void
		{
			dispatchEvent(new Event(ContentRequester.CREATE_ROOM, true));
		}
		
		
		public function get RoomListCollection():ListCollection
		{
			return this.roomListCollection;
		}
		
		public function set RoomListCollection(value:ListCollection):void
		{
			this.roomListCollection = new ListCollection();
		}
		
		private function list_onScroll(list:List):void
		{
			this.pageIndicator.selectedIndex = roomList.horizontalPageIndex;
		}
		
		private function list_onChange(list:List):void
		{
			trace(list.selectedItem.roomId);
		}
	}

}