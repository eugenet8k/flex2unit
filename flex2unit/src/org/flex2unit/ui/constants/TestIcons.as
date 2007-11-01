package org.flex2unit.ui.constants {
	/**
	 * @author Maxym Hryniv
	 */
	public class TestIcons {
		
		[Embed("../images/fail.png")]
		public static const FAIL : Class;
	
		[Embed("../images/pass.png")]
		public static const SUCCESS : Class;
	
		[Embed("../images/none.png")]
		public static const NONE : Class;
		
		[Embed("../images/info.png")]
		public static const INFO : Class;
		
		public static function getResultIcon(success : Boolean) : Class {
			return success ? SUCCESS : FAIL;
		}
	}
}