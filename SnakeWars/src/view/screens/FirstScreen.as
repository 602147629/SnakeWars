package view.screens 
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.Assets;
	import view.util.ContentManipulator;
	import view.util.ContentRequester;
	import feathers.controls.TextInput;
	
	public class FirstScreen extends ContentRequester
	{	
		public static const GOTO_LOBBY:String = "gotoLobby";
		
		private var playBtn:Button;
		private var nameTextField:TextField;
		private var errorTextField:TextField;
		private var textInput:TextInput;
		
		private var userName:String = "Name";
		
		public function FirstScreen() 
		{
			
		}
		
		override public function init(initData:Object):void
		{
			const btnTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(120,30, 0xCCCCCC));
			const currentStageWidth:int = Starling.current.stage.stageWidth;
			const currentStageHeight:int = Starling.current.stage.stageHeight;
			const separatorY:int = currentStageHeight * 0.02; 
		
			
			nameTextField = new TextField(120, 20, "Enter your name");
			nameTextField.x = (currentStageWidth - nameTextField.width) * .5;
			nameTextField.y = (currentStageHeight - nameTextField.height) * .5
			addChild(nameTextField);
			
			const textInputQuad:Quad = new Quad(nameTextField.width, nameTextField.height, 0xdddddd);
			textInputQuad.x = nameTextField.x;
			textInputQuad.y = nameTextField.y + nameTextField.height + separatorY;
			addChild(textInputQuad);
			
			textInput = new TextInput();
			textInput.width = textInputQuad.width;
			textInput.height = textInputQuad.height;
			textInput.x = textInputQuad.x;
			textInput.y = textInputQuad.y;
			textInput.text = "Name";
			textInput.onChange.add(textInputOnChange);
			addChild(textInput);
			
			playBtn = new Button(btnTexture, "Play");
			playBtn.x = (currentStageWidth - playBtn.width) * .5;
			playBtn.y = textInputQuad.y + textInputQuad.height + separatorY;
			playBtn.addEventListener(Event.TRIGGERED, onPlayHandler);
			addChild(playBtn);
			
			errorTextField = new TextField(300, 60, "Error:");
			errorTextField.color = 0xFF0000;
			errorTextField.x = (currentStageWidth - errorTextField.width) * .5;
			errorTextField.y = nameTextField.y - errorTextField.height - separatorY;
			errorTextField.visible = false;
			addChild(errorTextField);
			
			isInit = true;
		}
		
		public function get UserName():String
		{
			return this.userName;
		}
		
		private function textInputOnChange(textInput:TextInput):void
		{
			this.userName = textInput.text;
		}
		
		private function onPlayHandler(e:Event):void
		{
			// Select Username
			selectUsername();
		}
		
	}

}