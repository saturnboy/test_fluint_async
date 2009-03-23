package com.saturnboy.tests {
	import com.saturnboy.services.MyService;

	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	import net.digitalprimates.fluint.async.TestResponder;
	import net.digitalprimates.fluint.tests.TestCase;

	public class TestMyService extends TestCase {
		private var _service:MyService;

		public function TestMyService() {
			super();
		}

		override protected function setUp():void {
			super.setUp();
			_service = new MyService();
		}

		override protected function tearDown():void {
			super.tearDown();
			_service = null;
		}

		public function testGetSomething():void {
			//call service with dummy callback
			var token:AsyncToken = _service.getSomething(dummyResult, dummyFault);

			//create async test responder
			var responder:IResponder = asyncResponder(
					new TestResponder(testHandler, faultHandler), 1000, token);

			//wire test responder as 2nd callback
			token.addResponder(responder);
		}

		private function testHandler(result:Object, passThroughData:Object):void {
			assertEquals('something', result.result.name);
		}
		private function faultHandler(error:Object, passThroughData:Object):void {
			fail('Fault');
		}

		private function dummyResult(result:Object, token:Object):void {
			trace('dummy result');
		}
		private function dummyFault(result:Object, token:Object):void {
			trace('dummy fault');
		}
	}
}