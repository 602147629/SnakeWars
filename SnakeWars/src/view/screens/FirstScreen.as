package view.screens 
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.ContentRequester;
	import feathers.controls.TextInput;
	
	public class FirstScreen extends ContentRequester
	{
		[Embed(source = "/assets/touch_marker.png")]
		private static const PlayBtn:Class;
		
		private var playBtn:Button;
		private var nameTextField:TextField;
		private var textInput:TextInput;
		
		private var separatorY:int = 10; 
		
		public function FirstScreen() 
		{
			
		}
		
		override public function init(initData:Object):void
		{	
			nameTextField = new TextField(120, 20, "Enter your name");
			nameTextField.x = (Starling.current.stage.stageWidth - nameTextField.width) * .5;
			nameTextField.y = (Starling.current.stage.stageHeight - nameTextField.height) * .5
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
			
			const btnTexture:Texture = Texture.fromBitmap(new PlayBtn());
			playBtn = new Button(btnTexture, "Play");
			playBtn.x = (Starling.current.stage.stageWidth - playBtn.width) * .5;
			playBtn.y = textInputQuad.y + textInputQuad.height + separatorY;
			addChild(playBtn);
		}
		
	}

}