package org.flex2unit.framework.events
{
	import flash.events.Event;
	
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.interfaces.ITest;

	public class TestStartEvent extends TestEvent
	{
		
		private static const TEST_START_EVENT : String = "testStart";
		
		public function TestStartEvent(test : ITest,  result : TestResult)
		{
			super(TEST_START_EVENT, test, result);
		}
		
	}
}