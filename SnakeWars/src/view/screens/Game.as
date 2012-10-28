package view.screens 
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.game.*;
	import view.util.Assets;
	import view.util.ContentRequester;

	
	public class Game extends ContentRequester
	{	
		public static const USER_IS_READY:String = "userIsReady";
		
		private var currentScreenWidth:Number;
		private var currentScreenHeight:Number;
		
		private var tableManager:TableManager;
		
		private var readyBtn:Button;
		private var victoryBtn:Button;
		private var defeatBtn:Button;
		private var errorTextField:TextField;
		
		public function Game() 
		{
			
		}
		
		override public function init(initData:Object):void
		{
			currentScreenWidth = Starling.current.stage.stageWidth;
			currentScreenHeight = Starling.current.stage.stageHeight;
			const separatorY:int = currentScreenHeight * 0.02; 
						
			var btnTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(180, 30, 0xCCCCCC));
			readyBtn = new Button(btnTexture, "Ready");
			readyBtn.x = (currentScreenWidth - readyBtn.width) * .5;
			readyBtn.y = (currentScreenHeight - readyBtn.height) * .5;
			readyBtn.addEventListener(Event.TRIGGERED, readyBtnTriggered);
			addChild(readyBtn);
			
			victoryBtn = new Button(btnTexture, "Victory!");
			victoryBtn.x = (currentScreenWidth - victoryBtn.width) * .5;
			victoryBtn.y = (currentScreenHeight - victoryBtn.height) * .5;
			victoryBtn.addEventListener(Event.TRIGGERED, victoryBtnTriggered);
			victoryBtn.visible = false;
			addChild(victoryBtn);
			
			defeatBtn = new Button(btnTexture, "Defeat!");
			defeatBtn.x = (currentScreenWidth - defeatBtn.width) * .5;
			defeatBtn.y = (currentScreenHeight - defeatBtn.height) * .5;
			defeatBtn.addEventListener(Event.TRIGGERED, defeatBtnTriggered);
			victoryBtn.visible = false;
			addChild(defeatBtn);
			
			errorTextField = new TextField(300, 60, "Error: ");
			errorTextField.color = 0xFF0000;
			errorTextField.x = (currentScreenWidth - errorTextField.width) * .5;
			errorTextField.y = readyBtn.y + readyBtn.height + separatorY;
			errorTextField.visible = false;
			
			tableManager = new TableManager();
			tableManager.visible = false;
			tableManager.drawGrid(currentScreenWidth, currentScreenHeight);
			
			addChild(tableManager);
			tableManager.x = (currentScreenWidth - tableManager.width) * .5;
			tableManager.y = (currentScreenHeight - tableManager.height) * .5;
			
			tableManager.generatePools();
			
			addChild(errorTextField);
			
			isInit = true;
		}
		
		public function newGame():void
		{
			readyBtn.visible = true;
			tableManager.visible = false;
		}
		
		public function startGame():void
		{
			readyBtn.visible = false;
			tableManager.visible = true;
		}
		
		public function resetGame():void
		{
			tableManager.resetAllPieces();
		}
		
		override public function showErrorMessage(errorMessage:String):void
		{
			this.errorTextField.text = errorMessage;
			this.errorTextField.visible = true;
		}
		
		private function readyBtnTriggered(e:Event):void
		{
			dispatchEvent(new Event(USER_IS_READY, true));
		}
		
		public function showVictory():void
		{
			victoryBtn.visible = true;
		}
		
		private function victoryBtnTriggered(e:Event):void
		{
			victoryBtn.visible = false;
		}
		
		public function showDefeat():void
		{
			defeatBtn.visible = true;
		}
		
		private function defeatBtnTriggered(e:Event):void
		{
			defeatBtn.visible = false;
		}
	}

}