package model 
{
	
	import model.network.*;
	
	public class Model 
	{		
		var network:Network = new Network();
		
		public function Model() 
		{
			
		}
		
		public function init():void
		{
			network.setGuestLogin();
			network.init();
		}
	}

}