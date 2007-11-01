package org.flex2unit.framework.events
{
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.interfaces.ITest;
	
	public class SubTestEvent extends TestEvent
	{
		private var _testEvent : TestEvent;
		
		public function SubTestEvent(test : ITest, result : TestResult, testEvent : TestEvent) {
			super(testEvent.type, test, result);
			
			_testEvent = testEvent;
		}
		
		public function get subTestEvent() : TestEvent {
			return _testEvent;
		}
		
		public function get subTest() : ITest {
			return _testEvent.test;
		}

		public function get subTestResult() : TestResult {
			return _testEvent.result;
		}

	}
}