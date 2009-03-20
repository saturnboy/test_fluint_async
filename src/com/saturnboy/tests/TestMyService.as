package com.saturnboy.tests {
	import com.saturnboy.services.MyService;
	
	import mx.rpc.AsyncToken;
	
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
			var token:AsyncToken = _service.getSomething(dummyResult, handleFault);
			
			//attach test callback via Fluint's async callback helper
			token.addResponder(asyncResponder(new TestResponder(handleGetSomething, handleFault), 1000, token));
		}
		private function handleGetSomething(data:Object, passThroughData:Object):void {
			var result:Object = data.result;
			assertEquals('something', result.name);
			assertEquals(3, result.list.length);
			assertEquals([1,2,3].join(','), result.list.join(','));
		}

		private function dummyResult(data:Object, passThroughData:Object):void {
			trace('Dummy');
		}
		private function handleFault(error:Object, passThroughData:Object):void {
			fail('Fault');
		}
	}
}