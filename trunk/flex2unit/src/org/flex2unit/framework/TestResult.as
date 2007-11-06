package org.flex2unit.framework {
	
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.errors.AssertionFailedError;
	import org.flex2unit.framework.interfaces.ITest;
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.utils.Arrays;
	
	/**
	 * A <code>TestResult</code> collects the results of an executing
	 * Test. It is an instance of the Collecting Parameter pattern.
	 * The test framework distinguishes between <i>failures</i> and <i>errors</i>.
	 * A failure is anticipated and checked for with assertions. Errors are
	 * unanticipated problems.
	 *
	 * @see Test
	 */
	public class TestResult {
		
		private var _errors : ArrayCollection;
	
		private var _failures : ArrayCollection;
	
		public function TestResult() {
			_errors = new ArrayCollection();
			_failures = new ArrayCollection();
		}
		
		public function get message() : String {
			var result : String = "";
			result += createMessage(_errors);
			result += createMessage(_failures);
			return result;
		}
	
		public function get errors() : ArrayCollection {
			return _errors;
		}
	
		public function get failures() : ArrayCollection {
			return _failures;
		}
		
		public function addError(test : ITest, error : Error) : void {
			_errors.addItem(error);	
		}
	
		public function addFailure(test : ITest, failure : AssertionFailedError) : void {
			_failures.addItem(failure);
		}
	
		public function addResult(testResult : TestResult) : void {
			Arrays.insertAll(_errors, testResult.errors);
			Arrays.insertAll(_failures, testResult.failures);
		}
	 
	
		public function run( testCase : TestCase ) : void {
			testCase.run(this);
		}
	
	
		public function success() : Boolean {
			return (_errors.length == 0) && (_failures.length == 0);
		}
		
		private function createMessage(errors : ArrayCollection) : String {
			var result : String = "";
			for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(errors); iterator.hasNext(); ) {
				var error : Error = Error(iterator.next());
				result += error.message + "<br /><br />";
			}
			return result;
		}
		
	}
	
}