package model.game 
{
	import flash.geom.Point;

	
	public class Snake 
	{
		private var head:SnakeNode;
		private var last:SnakeNode;
		
		public function Snake() 
		{
			
		}
		
		public function isEmpty() 
		{
			return (head == null);
		}
		
		public function enqueue(point:Point):void
		{
			var node:SnakeNode = new SnakeNode();
			node.position = point;
			node.next = null;
			if (isEmpty())
			{
				head = node;
				last = node;
			}
			else
			{
				last.next = node;
				last = node;
			}
			
		}
		
		public function dequeue():Point
		{
			if (isEmpty()) 
			{
				trace("Error: \n\t Objects of type Queue must contain data before being dequeued.");
				return new Point();
			}
			
			var point:Point = head.position;
			head = head.next;
			return point;
		}
		
		public function peak():Point
		{
			if (isEmpty())
			{
				trace("Empty");
				return new Point();
			}
			
			return last.position;
		}
	}

}