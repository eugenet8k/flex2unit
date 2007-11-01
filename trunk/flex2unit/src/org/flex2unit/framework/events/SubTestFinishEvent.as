package org.flex2unit.framework.events
{
	import flash.events.Event;
	
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.interfaces.ITest;

	public class SubTestFinishEvent extends SubTestEvent
	{
		
		public function SubTestFinishEvent(test : ITest, result : TestResult, testEvent : TestEvent)
		{
			super(test, result, testEvent);
		}

	}
}