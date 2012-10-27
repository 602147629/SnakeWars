package view.screens 
{
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.ContentRequester;
	
	public class FirstScreen extends ContentRequester
	{
		[Embed(source = "/assets/touch_marker.png")]
		private static const PlayBtn:Class;
		
		private var playBtn:Button;
		private var nameTextField:TextField;
		
		public function FirstScreen() 
		{
			
		}
		
		override public function init(initData:Object):void
		{
			const btnTexture:Texture = Texture.fromBitmap(new PlayBtn());
			playBtn = new Button(btnTexture, "Play");
			playBtn.x = (Starling.current.stage.stageWidth - playBtn.width) * .5;
			playBtn.y = (Starling.current.stage.stageHeight - playBtn.height) * .5;
			addChild(playBtn);
			
			nameTextField = new TextField(100, 20, "Please enter your name");
			nameTextField.x = (Starling.current.stage.stageWidth - nameTextField.width) * .5;
			nameTextField.y = playBtn.y + playBtn.height + 20;
			addChild(nameTextField);
		}
		
	}

}