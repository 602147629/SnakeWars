package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import net.hires.debug.Stats;
	import starling.core.Starling;
	import flash.geom.Rectangle;
	
	public class Main extends Sprite 
	{
		private var starling:Starling;
		private var resStats:Stats;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				
			// App entry point
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			// Init starling variables for mobile
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			this.starling = new Starling(MainInterface, this.stage);
			this.starling.enableErrorChecking = false;
			this.starling.start();
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			this.starling.stage.stageWidth = this.stage.stageWidth;
			this.starling.stage.stageHeight = this.stage.stageHeight;

			const viewPort:Rectangle = this.starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this.starling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}

		private function stage_deactivateHandler(event:Event):void
		{
			this.starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this.starling.start();
		}
	}
	
}