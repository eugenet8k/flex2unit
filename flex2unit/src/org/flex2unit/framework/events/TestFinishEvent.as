package org.flex2unit.framework.events
{
	import flash.events.Event;
	
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.interfaces.ITest;
	
	public class TestFinishEvent extends TestEvent
	{
		
		private static const TEST_FINISH_EVENT : String = "testFinish"; 
		
		public function TestFinishEvent(test : ITest,  result : TestResult)
		{
			super(TEST_FINISH_EVENT, test, result);
		}
		
	}
}