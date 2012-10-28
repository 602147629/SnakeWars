package view.game 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import view.util.Assets;
	
	public class SnakeVisual extends Sprite
	{
		private var snakeImage:Image;
		private var pointWherePlaced:Point;
		
		public function SnakeVisual(texture:Texture) 
		{
			snakeImage = new Image(texture);
			snakeImage.x -= snakeImage.width * .5;
			snakeImage.y -= snakeImage.height * .5;
			addChild(snakeImage);
		}
		
		public function get PointWherePlaced():Point
		{
			return this.pointWherePlaced;
		}
		
		public function set PointWherePlaced(value:Point):void
		{
			this.pointWherePlaced = value;
		}
		
	}

}