package org.flex2unit.framework {
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import org.flex2unit.framework.errors.AssertionFailedError;
	import org.flex2unit.framework.errors.ComparisonFailureError;
	import org.goverla.reflection.overload.Overload;
	
	/** 
	 * Base class containing static assert methods.
	 */
	public class Assert {
	
		public function Assert() {
		}
	
		public function assertEquals(... args) : void {
			var overload : Overload = new Overload(this);
			overload.addHandler([String, Object, Object], assertEqualsWithMessage);
			overload.addHandler([Object, Object], assertEqualsWithoutMessage);
			overload.forward(args);
		}
	
		private function assertEqualsWithMessage(message : String, expected : Object, actual : Object ) : void {
			if (expected != actual) {
				throw new ComparisonFailureError(message, expected, actual);
			}
		}
	
		private function assertEqualsWithoutMessage(expected : Object, actual : Object) : void {
			assertEqualsWithMessage("", expected, actual);
		}
		
		public function assertNotSame(... args) : void {
			var overload : Overload = new Overload(this);
			overload.addHandler([String, Object, Object], assertNotSameWithMessage);
			overload.addHandler([Object, Object], assertNotSameWithoutMessage);
			overload.forward(args);
		}
	
		private function assertNotSameWithMessage(message : String, expected : Object, actual : Object ) : void {
			if (expected == actual) {
				throw new ComparisonFailureError(message, expected, actual);
			}
		}
	
		private function assertNotSameWithoutMessage(expected : Object, actual : Object) : void {
			assertNotSameWithMessage("", expected, actual);
		}
	
	 	public function assertTrue(... args) : void {
			var newArguments : Array = insertToArguments(args, true);
			assertEquals.apply(this, newArguments);
		}
	
		public function assertFalse(... args) : void {
			var newArguments : Array = insertToArguments(args, false);
			assertEquals.apply(this, newArguments);
		}
	
		public function assertNull(... args) : void {
			var newArguments : Array = insertToArguments(args, null);
			assertEquals.apply(this, newArguments);
		}
	
		public function assertNotNull(... args) : void {
			var overload : Overload = new Overload(this);
			overload.addHandler([String, Object], assertNotNullWithMessage);
			overload.addHandler([Object], assertNotNullWithoutMessage);
			overload.forward(args);		
		}
	
		private function assertNotNullWithMessage(message : String, object : Object) : void	{
			if (object==null) {
				var formatStringWithMessage : String = "{0}<br /><b>Object can not be null:</b> {1}";
				var formatStringWithoutMessage : String = "<b>Object can not be null:</b> {1}";
				var formatString : String = (message == null) ? formatStringWithoutMessage : formatStringWithMessage;
				fail(StringUtil.substitute(formatString, [message, object]));
			}
		}
	
		private function assertNotNullWithoutMessage(object : Object) : void {
			assertNotNullWithMessage("", object);
		}
		
		public function fail(failMessage : String) : void	{
			throw new AssertionFailedError(failMessage);
		}
	
		private static function insertToArguments(args : Array, value : Object) : Array {
			var list : ArrayCollection = new ArrayCollection(args);
			if (list.getItemAt(0) is String) {
				list.addItemAt(value, 1);
			} else {
				list.addItemAt(value, 0);
			}
			return list.toArray();
		}
		
	}
	
}