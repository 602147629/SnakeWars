package model 
{
	
	import model.network.*;
	import flash.events.*;
		
	public class Model extends EventDispatcher
	{		
		
		public static var instance:Model;
		private static var allowInstantiation:Boolean = false;
		
		public var DESIRED_USERNAME:String = "";
				
		public var network:Network = new Network();
		
		public function Model():void {
			if (!allowInstantiation) {
			throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
		}
		
		public static function getInstance():Model {
			
			if (instance == null) 
			{
				allowInstantiation = true;
				instance = new Model();
				allowInstantiation = false;
			}
			
			return instance;
		}		
		
		public function startNetworkInteraction()
		{
			network.init();
		}
		
		
	}

}