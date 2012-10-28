package view.util 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	public class Assets 
	{
		
		public function Assets() 
		{
			
		}
		
		// Get a rectangle inside a BitmapData object
		public static function getRectangleBitmap(width:int, height:int, color:uint, alpha:Number = 1):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(width, height, false);
			var rectangle:Shape = new Shape();
			var rectangleSprite:Sprite = new Sprite();
			
			rectangle.graphics.beginFill(color,alpha);
			rectangle.graphics.drawRect(0, 0, width, height);
			rectangle.graphics.endFill();
			
			rectangleSprite.addChild(rectangle);
			bitmapData.draw(rectangleSprite);
			
			return bitmapData;
		}
		
		// Get a circle inside a BitmapData object
		public static function getCircleBitmap(size:int, color:uint, alpha:Number = 1):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(size, size, false);
			var circle:Shape = new Shape();
			var circleSprite:Sprite = new Sprite();
			const circleCoord:int = size / 2;
			
			circle.graphics.beginFill(color,alpha);
			circle.graphics.drawCircle(circleCoord, circleCoord, size/2);
			circle.graphics.endFill();
			
			circleSprite.addChild(circle);
			bitmapData.draw(circleSprite);
			
			return bitmapData;
		}
		
		// Get a tile inside a BitmapData object
		public static function getTileBitmap(width:int, height:int, color:uint, alpha:Number = 1):BitmapData
		{
			const borderSize:int = 1;
			
			var bitmapData:BitmapData = new BitmapData(width, height, false);
			var tile:Shape = new Shape();
			var tileSprite:Sprite = new Sprite();
			
			tile.graphics.beginFill(color, alpha);
			tile.graphics.drawRect(0, 0, width, height);
			tile.graphics.endFill();
			
			tile.graphics.beginFill(0xFFFFFF, alpha);
			tile.graphics.drawRect(borderSize, borderSize, width - borderSize*2, height - borderSize*2);
			tile.graphics.endFill();
			
			tileSprite.addChild(tile);
			bitmapData.draw(tileSprite);
			
			return bitmapData;
		}
	}

}