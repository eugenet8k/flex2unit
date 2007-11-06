package org.flex2unit.framework {
	
	import org.flex2unit.framework.errors.AssertionFailedError;
	import org.flex2unit.framework.events.SubTestFinishEvent;
	import org.flex2unit.framework.events.SubTestStartEvent;
	import org.flex2unit.framework.events.TestFinishEvent;
	import org.flex2unit.framework.events.TestStartEvent;
	import org.flex2unit.framework.interfaces.ITest;
	import org.goverla.events.EventSender;
	import org.goverla.utils.ReflectUtil;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class MethodTestCase implements ITest {
		
		private var _context : TestCase;
	
		private var _method : Function;
	
		private var _result : TestResult;
		
		private var _start : EventSender = new EventSender(TestStartEvent);
		
		private var _finish : EventSender = new EventSender(TestFinishEvent);
		
		private var _subTestStart : EventSender = new EventSender(SubTestStartEvent);
		
		private var _subTestFinish : EventSender = new EventSender(SubTestFinishEvent);
		
		public function MethodTestCase(context : TestCase, method : Function) {
			_context = context;
			_method = method;
		}
		
		public function get start() : EventSender {
			return _start;
		}

		public function get finish() : EventSender {
			return _finish;
		}

		public function get subTestStart() : EventSender {
			return _subTestStart;
		}

		public function get subTestFinish() : EventSender {
			return _subTestFinish;
		}

		public function run(result : TestResult) : void {
			_result = result;
			start.sendEvent(new TestStartEvent(this, _result));
			try {
				_context.setUp();
				_method();
			} catch (error : AssertionFailedError) {
				_result.addFailure(this, error);
			} catch (error : Error) {
				_result.addError(this, error);
			} finally {
				_context.tearDown();
			}
			finish.sendEvent(new TestFinishEvent(this, _result));
		}
	
		public function countTestCases() : Number {
			return 1;
		}
		
		public function get name() : String {
			return ReflectUtil.getMethodName(_context, _method);
		}
		
	}
}