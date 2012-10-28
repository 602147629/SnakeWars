package model.game 
{
	
	public class Table 
	{
		private const rows:int = 64;
		private const cols:int = 64;
		
		public function Table() 
		{
			
		}
		
		public function get Rows():int
		{
			return this.rows;
		}
		
		public function get Cols():int
		{
			return this.cols;
		}
	}

}