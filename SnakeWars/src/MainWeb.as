package  
{
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import net.hires.debug.Stats;
	import starling.core.Starling;
	import flash.geom.Rectangle;

	public class MainWeb extends Sprite
	{
		private var starling:Starling;
		private var resStats:Stats;
		
		
		public function MainWeb() :void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// App entry point
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			// Add hiResStats to stage for debugging
			this.resStats = new Stats();
			this.addChild(resStats);
			
			// Init starling variables for web
			this.starling = new Starling(MainInterface, this.stage);
			this.starling.enableErrorChecking = false;
			this.starling.start();
		}
		
	}

}