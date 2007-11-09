package org.flex2unit.framework {
	
	import org.flex2unit.framework.events.SubTestFinishEvent;
	import org.flex2unit.framework.events.SubTestStartEvent;
	import org.flex2unit.framework.events.TestFinishEvent;
	import org.flex2unit.framework.events.TestStartEvent;
	import org.flex2unit.framework.interfaces.ITest;
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.reflection.Overload;
	
	public class TestSuite extends TestCase {
		
		public function TestSuite(name : String) {
			super(name);
			_result = new TestResult();
		}
		
		public override function countTestCases() : Number {
			var result : Number = 0;
			for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(_subTests); iterator.hasNext();) {
				var test : ITest = ITest(iterator.next());
				result += test.countTestCases();
			}
			return result;
		}
		
		override protected function runNextSubTest() : void {
			_currentIndex++;
			if(_currentIndex < _subTests.length) {
				var test : ITest = ITest(_subTests.getItemAt(_currentIndex));
				test.run(new TestResult());			
			} else {
				finishTest();
			}
		}
	
		/**
		 * added in optimisation purposes to avoid invocation of super refreshTestMethods
		 */
		override protected function refreshTestMethods() : void {
		}
	
		public function addTest(test : Object) : TestSuite {
			var overload : Overload = new Overload(this);
			overload.addHandler([Class], addTestForClass);
			overload.addHandler([ITest], addTestForTest);
			return TestSuite(overload.forward(arguments));
		}
	
		private function addTestForTest(test : ITest) : TestSuite {
			_subTests.addItem(test);
			test.start.addListener(onTestStart);
			test.finish.addListener(onTestFinish);
			test.subTestStart.addListener(onSubTestStart);
			test.subTestFinish.addListener(onSubTestFinish);
			return this;
		}
	
		private function addTestForClass(testClass : Class) : TestSuite	{
			addTest(new testClass());
			return this;
		}
		
		private function onTestStart(event : TestStartEvent) : void {
			subTestStart.sendEvent(new SubTestStartEvent(this, _result, event));
		}

		private function onTestFinish(event : TestFinishEvent) : void {
			_result.addResult(event.result);
			subTestFinish.sendEvent(new SubTestFinishEvent(this, _result, event));
			runNextSubTest();
		}

		private function onSubTestStart(event : SubTestStartEvent) : void {
			subTestStart.sendEvent(new SubTestStartEvent(this, _result, event.subTestEvent));
		}
	
		private function onSubTestFinish(event : SubTestFinishEvent) : void {
			subTestFinish.sendEvent(new SubTestFinishEvent(this, _result, event.subTestEvent));
		}
	
	}
	
}