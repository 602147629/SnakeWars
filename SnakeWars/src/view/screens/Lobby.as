package view.screens 
{
	import starling.text.TextField;
	import view.util.ContentRequester;

	
	public class Lobby extends ContentRequester
	{
		private var connTextField:TextField;
		private var errorTextField:TextField;
		
		public function Lobby() 
		{
			
		}

		override public function init(initData:Object):void
		{
			connTextField = new TextField(200, 20, "Connecting...");
			addChild(connTextField);
			
			errorTextField = new TextField(200, 20, "Error: ");
			errorTextField.visible = false;
			addChild(errorTextField);
		}
		
	}

}