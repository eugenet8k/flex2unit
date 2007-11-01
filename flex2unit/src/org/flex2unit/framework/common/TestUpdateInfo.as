package org.flex2unit.framework.common {
	import org.flex2unit.framework.interfaces.ITest;
	import org.flex2unit.framework.TestResult;
	/**
	 * @author Maxym Hryniv
	 */
	public class TestUpdateInfo {
		
		private var _test : ITest;
	
		private var _result : TestResult;
		 
		 public function TestUpdateInfo(test : ITest, result : TestResult) {
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