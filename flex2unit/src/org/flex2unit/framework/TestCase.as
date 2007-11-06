package org.flex2unit.framework {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.events.SubTestFinishEvent;
	import org.flex2unit.framework.events.SubTestStartEvent;
	import org.flex2unit.framework.events.TestFinishEvent;
	import org.flex2unit.framework.events.TestStartEvent;
	import org.flex2unit.framework.interfaces.ITest;
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.events.EventSender;
	import org.goverla.utils.ReflectUtil;
	
	public class TestCase extends Assert implements ITest {
	
		private static var DEFAULT_DELAY : Number = 100;
		
		private static var TEST_METHOD_PREFIX : String = "test";
		
		protected var _subTests : ArrayCollection; 	
	
		private var _isRunning : Boolean; 	
	
		protected var _result : TestResult; 	
	
		protected var _currentIndex : Number;
		
		private var _name : String;
		
		private var _start : EventSender = new EventSender(TestStartEvent);
		
		private var _finish : EventSender = new EventSender(TestFinishEvent);
		
		private var _subTestStart : EventSender = new EventSender(SubTestStartEvent);
		
		private var _subTestFinish : EventSender = new EventSender(SubTestFinishEvent);
		
		public function TestCase(name : String = null) {
			super();
			_name = (name != null) ? name : ReflectUtil.getTypeName(this);
			_subTests = new ArrayCollection();
			_isRunning = false;
			
			refreshTestMethods();
		}
		
		public function run(result : TestResult) : void {
			if(!_isRunning) {
				_isRunning = true;
				_result = (result != null) ? result : new TestResult();
				start.sendEvent(new TestStartEvent(this, _result));
				runFirstSubTest();
			}
		}
		
		public function countTestCases() : Number	{
			return 1;
		}
		
		public function get name() : String {
			return _name;
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

		public function get tests() : ArrayCollection {
			return _subTests;
		}
		
		public function setUp() : void {
		}
		
		public function tearDown() : void {
		}
		
		protected function runNextSubTest() : void {
			_currentIndex++;
			if(_currentIndex < _subTests.length) {
				var timer : Timer = new Timer(DEFAULT_DELAY);
				timer.addEventListener(TimerEvent.TIMER, onTimer);
				timer.start();
			} else {
				finishTest();
			}
		}
		
		private function runFirstSubTest() : void {
			_currentIndex = -1;
			runNextSubTest();
		}
		
	
		private function runSubTest(test : ITest) : void {
			var currentResult : TestResult = new TestResult();
			
			test.run(currentResult);
			_result.addResult(currentResult);
		}
		
		private function onTimer(event : TimerEvent) : void {
			if(_currentIndex < _subTests.length) {
				runSubTest(ITest(_subTests.getItemAt(_currentIndex)));
				runNextSubTest();
			}
		}
		
		protected function finishTest() : void {
			_isRunning = false;
			finish.sendEvent(new TestFinishEvent(this, _result));
		}
		
		protected function refreshTestMethods() : void {
			_subTests = new ArrayCollection();
			
			var methods : ArrayCollection = ReflectUtil.getMethodsByInstance(this);
			
			for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(methods); iterator.hasNext();) {
				var methodName : String = String(iterator.next());
				if(methodName.indexOf(TEST_METHOD_PREFIX) == 0) {
					var test : MethodTestCase = new MethodTestCase(this, this[methodName]);
					test.start.addListener(onSubTestStart);
					test.finish.addListener(onSubTestFinish);
					_subTests.addItem(test);
				}
			}
		}
		
		private function onSubTestStart(event : TestStartEvent) : void {
			subTestStart.sendEvent(new SubTestStartEvent(this, _result, event));
		}
		
		private function onSubTestFinish(event : TestFinishEvent) : void {
			subTestFinish.sendEvent(new SubTestFinishEvent(this, _result, event));
		}
		
	}
}