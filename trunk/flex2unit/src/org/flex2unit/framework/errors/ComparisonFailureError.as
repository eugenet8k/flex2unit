package org.flex2unit.framework.errors {
	
	import mx.utils.StringUtil;
	
	import org.goverla.core.utils.XMLUtil;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class ComparisonFailureError extends AssertionFailedError {
		
		private var _message : String;
		
		private var _expected : Object;
	
		private var _actual : Object;
		
		public function ComparisonFailureError(message : String, expected : Object, actual : Object) {
			super(message);
			_message = message;
			_actual = actual;
			_expected = expected;
			refreshMessage();
		}
		
		public function get expected() : Object {
			return _expected;
		}
	
		public function get actual() : Object {
			return _actual;
		}
	
		private function refreshMessage() : void {
			var validExpected : String = XMLUtil.createTextNode(String(expected)).toString();
			var validActual : String = XMLUtil.createTextNode(String(actual)).toString();
			var maxLength : Number = Math.max(validExpected.length, validActual.length);
			for (var i : Number = 0; i<maxLength; i++) {
				if (validExpected.charAt(i) != validActual.charAt(i)) {
					validExpected = validExpected.substring(0, i) + "<font color='#FF0000'><b>" + validExpected.substring(i) + "</b></font>";
					validActual = validActual.substring(0, i) + "<font color='#FF0000'><b>" + validActual.substring(i) + "</b></font>";
					break;
				}
			}
			var formatStringWithMessage : String = "{0}<br /><b>Expected:</b>&nbsp;{1}<br /><b>Actual:</b>&nbsp;{2}";
			var formatStringWithoutMessage : String = "<b>Expected:</b>&nbsp;{1}<br /><b>Actual:</b>&nbsp;{2}";
			var formatString : String = (_message == null) ? formatStringWithoutMessage : formatStringWithMessage;
			message = StringUtil.substitute(formatString, [_message, validExpected, validActual]);
		}
	
	}
	
}