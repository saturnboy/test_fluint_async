package com.saturnboy.tests {
	import net.digitalprimates.fluint.tests.TestSuite;

	public class MySuite extends TestSuite {
		public function MySuite() {
			addTestCase(new TestMyService());
		}
	}
}