package org.fUnit.framework {
	
	import org.fUnit.framework.errors.AssertionFailedError;

	public class AssertTest extends TestCase {
		
		public function testTrue() : void {
			assertTrue(true);
		}
	
		public function testFalse() : void {
			assertFalse(false);
		}
	
		public function testEquals() : void {
			assertEquals(1, 1);
		}
		
		public function testNotSame() : void {
			assertNotSame(2, 1);
		}
	
		public function testNull() : void {
			assertNull(null);
		}
	
		public function testNotNull() : void {
			assertNotNull(new Object());
		}
	
		public function testFailTrue() : void {
			var catched : Boolean = false;
			try {
				assertTrue(false);
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
	
		public function testFailFalse() : void {
			var catched : Boolean = false;
			try {
				assertFalse(true);
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
	
		public function testFailEquals() : void {
			var catched : Boolean = false;
			try {
				assertEquals(new Object(), new Object());
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
	
		public function testFailNull() : void {
			var catched : Boolean = false;
			try {
				assertNull(new Object());
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
	
		public function testFailNotNull() : void {
			var catched : Boolean = false;
			try {
				assertNotNull(null);
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
	
		public function testFail() : void {
			var catched : Boolean = false;
			try {
				fail("sdscs");
			} catch (error : AssertionFailedError)	{
				catched = true;
			}
			assertTrue(catched);
		}
		
	}
	
}