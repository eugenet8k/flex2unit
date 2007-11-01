package org.flex2unit.framework.events
{
	import flash.events.Event;
	import org.flex2unit.framework.interfaces.ITest;
	import org.flex2unit.framework.TestResult;

	public class TestEvent extends Event
	{
		
		private var _test : ITest;
		
		private var _result : TestResult;
		
		public function TestEvent(type:String, test : ITest, result : TestResult)
		{
			super(type);
			
			_test = test;
			_result = result;
		}
		
		public function get test() : ITest {
			return _test;
		}
		
		public function get result() : TestResult {
			return _result;
		}
		
	}
}