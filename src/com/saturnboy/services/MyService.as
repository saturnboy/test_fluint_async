package com.saturnboy.services {
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	
	public class MyService {
		private var _backend:MockBackend;
		
		public function MyService() {
			_backend = new MockBackend();
		}

		public function getSomething(result:Function, fault:Function):AsyncToken {
			//call the gxe service
			var token:AsyncToken = _backend.getSomething();

			//wireup handlers for result & fault, and send the token as passThrough data
			token.addResponder(new AsyncResponder(result, fault, token));

			return token;
		}
	}
}