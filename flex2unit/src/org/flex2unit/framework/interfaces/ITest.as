package org.flex2unit.framework.interfaces {
	
	
	import org.flex2unit.framework.TestResult;
	import org.goverla.events.EventSender;
	
	/** 
	 * A <code>Test</code> can be run, with the results collected.
	 *
	 * @see TestResult
	 */
	public interface ITest
	{
		/** 
		 * Runs the tests, populating the <code>result</code> parameter.
		 * @param The TestResult instance to be populated
		 */
		function run(result : TestResult) : void;
		
		/** 
		 * The number of test cases in this test.
		 * @return A Number representing the count of test cases in this test.
		 */
		function countTestCases() : Number;
		
		/**
		 * @return Test suite name or test class name. 
		 */
		function get name() : String;
		
		function get start() : EventSender;
		
		function get finish() : EventSender;
		
		function get subTestStart() : EventSender;

		function get subTestFinish() : EventSender;
	}
}