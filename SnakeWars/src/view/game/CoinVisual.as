package view.game 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class CoinVisual extends Sprite
	{
		private var image:Image;
		private var pointWherePlaced:Point;
		
		public function CoinVisual(texture:Texture) 
		{
			image = new Image(texture);
			image.x -= image.width * 0.5;
			image.y -= image.height * 0.5;
			addChild(image);
		}
		
		public function get PointWherePlaced():Point
		{
			return this.pointWherePlaced;
		}
		
		public function set PointWherePlaced(value:Point):void
		{
			pointWherePlaced = value;
		}
	}

}