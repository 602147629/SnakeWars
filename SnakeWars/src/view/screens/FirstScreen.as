package view.screens 
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.Assets;
	import view.util.ContentRequester;
	import feathers.controls.TextInput;
	
	public class FirstScreen extends ContentRequester
	{
		[Embed(source = "/assets/touch_marker.png")]
		private static const PlayBtn:Class;
		
		private var playBtn:Button;
		private var nameTextField:TextField;
		private var errorTextField:TextField;
		private var textInput:TextInput;
		
		private var userName:String = "";
		
		public function FirstScreen() 
		{
			
		}
		
		override public function init(initData:Object):void
		{
			const btnTexture:Texture = Texture.fromBitmapData(Assets.getRectangleBitmap(120,30, 0xCCCCCC));
			const currentStageWidth:int = Starling.current.stage.stageWidth;
			const currentStageHeight:int = Starling.current.stage.stageHeight;
			var separatorY:int = currentStageWidth * 0.02; 
		
			
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
			addChild(textInput);
			
			playBtn = new Button(btnTexture, "Play");
			playBtn.x = (currentStageWidth - playBtn.width) * .5;
			playBtn.y = textInputQuad.y + textInputQuad.height + separatorY;
			addChild(playBtn);
			
			errorTextField = new TextField(200, 40, "Error:");
			errorTextField.color = 0xFF0000;
			errorTextField.x = (currentStageWidth - errorTextField.width) * .5;
			errorTextField.y = nameTextField.y - errorTextField.height - separatorY;
			errorTextField.visible = false;
			addChild(errorTextField);
		}
		
	}

}