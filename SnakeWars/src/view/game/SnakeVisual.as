package view.game 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import view.util.Assets;
	
	public class SnakeVisual extends Sprite
	{
		public const SNAKE_KILLED:String = "snakeKilled";
		
		private var snakeImage:Image;
		private var pointWherePlaced:Point;
		private var countText:TextField;
		
		public var snakeCount:int;
		
		public function SnakeVisual(texture:Texture) 
		{
			snakeImage = new Image(texture);
			snakeImage.x -= snakeImage.width * .5;
			snakeImage.y -= snakeImage.height * .5;
			addChild(snakeImage);
			
			snakeCount = 1;
			countText = new TextField(20, 20, snakeCount.toString());
			countText.x = snakeImage.x + snakeImage.width;
			countText.y = snakeImage.y - snakeImage.height;
			addChild(countText);
		}
		
		public function get PointWherePlaced():Point
		{
			return this.pointWherePlaced;
		}
		
		public function set PointWherePlaced(value:Point):void
		{
			this.pointWherePlaced = value;
		}
		
		public function addPoints(points:int):void
		{
			this.snakeCount += points;
			this.countText.text = snakeCount.toString();
		}
		
		public function substractPoints(points:int):void
		{
			this.snakeCount -= points;
			this.countText.text = snakeCount.toString();
			
			if (snakeCount <= 0)
				killSnake();
		}
		
		public function killSnake():void
		{
			dispatchEvent(new Event(SNAKE_KILLED, false));
		}
		
	}

}