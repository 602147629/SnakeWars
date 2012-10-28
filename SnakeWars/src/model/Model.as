package model 
{
	
	import model.network.*;
	import starling.events.*;
		
	public class Model extends EventDispatcher
	{		
		
		public static var instance:Model;
		private static var allowInstantiation:Boolean = false;
		
				
		public static var CONNECT_AND_AUTH_OK:String = "connectAndAuthOk";
		
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
		
		public function startNetworkInteraction(desiredUsername:String)
		{
			addNetworkEventListeners();
			network.init(desiredUsername);
		}
		
		private function addNetworkEventListeners()
		{
			network.addEventListener(Network.LOGIN_SUCCESFUL, loginSuccesfulHandler);
		}
		
		private function loginSuccesfulHandler(e:Event)
		{
			dispatchEvent(new Event(Model.CONNECT_AND_AUTH_OK));
		}
		
		
	}

}