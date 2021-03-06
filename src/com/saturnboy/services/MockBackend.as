package com.saturnboy.services {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class MockBackend {
		public function MockBackend() {
		}

		public function getSomething():AsyncToken {
			var token:AsyncToken = new AsyncToken(null);
			var result:Object = { name:'something', list:[1,2,3] };

			//simulate backend delay via timer
			var t:Timer = new Timer(500, 1);

			//send result to all of the token's responders
			t.addEventListener(TimerEvent.TIMER_COMPLETE,
				function(e:TimerEvent):void {
					for each(var responder:IResponder in token.responders) {
						responder.result(new ResultEvent(ResultEvent.RESULT, false, true, result));
					}
					t = null;
					token = null;
				}, false, 0, true);

			t.start();

			return token;
		}
	}
}