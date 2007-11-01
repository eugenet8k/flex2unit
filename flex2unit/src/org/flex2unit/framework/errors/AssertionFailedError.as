package org.flex2unit.framework.errors {
	/** 
	 * Error thrown if an assertion fails.
	 */
	public class AssertionFailedError extends Error {
	
		public function AssertionFailedError(message : String) {
			super(message);
		}
	
	}
}