package view 
{
	import starling.display.Sprite;
	import view.util.ContentManipulator;

	
	public class View extends Sprite
	{
		protected var contentManipulator:ContentManipulator;
		
		// events
		public static var USERNAME_SELECTED:String = "usernameSelected";		
		
		public function View() 
		{
			
		}
		
		public function init():void
		{
			contentManipulator = new ContentManipulator();
			contentManipulator.init();
			addChild(contentManipulator);
		}
		
		// requests
		public function goToLobbyScreen()
		{
			
		}
		
		public function showError(errorMessage:String)
		{
			
		}
		
		public function goToGameScreen()
		{
			
		}
		
		
	}

}