package view.game 
{
	import flash.geom.Point;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class TileVisual extends Sprite
	{
		private var tileBtn:Button;
		private var tileTexture:Texture;
		
		private var center:Point;
		
		public function TileVisual() 
		{
			
		}
		
		public function init(tileTexture:Texture):void
		{
			tileBtn = new Button(tileTexture, "", tileTexture);
			addChild(tileBtn);
		}
		
		public function get Center():Point
		{
			return this.center;
		}
		
		public function set Center(value:Point):void
		{
			this.center = value;
		}
		
	}

}