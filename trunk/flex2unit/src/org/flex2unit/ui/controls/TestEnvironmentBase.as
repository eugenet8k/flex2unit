package org.flex2unit.ui.controls {
	
	import mx.collections.ArrayCollection;
	import mx.containers.Box;
	import mx.controls.Button;
	import mx.controls.Tree;
	import mx.events.ListEvent;
	import mx.utils.StringUtil;
	
	import org.flex2unit.framework.MethodTestCase;
	import org.flex2unit.framework.TestCase;
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.events.SubTestFinishEvent;
	import org.flex2unit.framework.events.SubTestStartEvent;
	import org.flex2unit.framework.events.TestFinishEvent;
	import org.flex2unit.framework.events.TestStartEvent;
	import org.flex2unit.framework.interfaces.ITest;
	import org.flex2unit.ui.common.TestTreeBranchNode;
	import org.flex2unit.ui.common.TestTreeNode;
	import org.flex2unit.ui.constants.TestIcons;
	import org.goverla.collections.ListCollectionViewIterator;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class TestEnvironmentBase extends Box {
		
		public var _startButton : Button;
	
		public var _clearButton : Button;
		
		public var _testTree : Tree;
		
		[Bindable]
		public var _testResultMessage : String;
		
		public var _test : ITest;
		
		[Bindable]
		protected var dataProvider : ArrayCollection;		
		
		public function TestEnvironmentBase() {
			super();
		}
		
		public function set test(value : ITest) : void {
			_test = value;
			buildTree();
		}
	
		private function buildTree() : void {
			
			var rootNode : TestTreeNode = new TestTreeNode("all", null, _testTree);
			
			_testTree.dataProvider = buildTreeNode(rootNode, _test);
			
		}
		
		private function buildTreeNode(parentNode : TestTreeNode, test : ITest) : TestTreeNode {
			
			var currentNode : TestTreeNode;
			
			if (test is MethodTestCase) {
				currentNode = new TestTreeNode(test.name, test, _testTree);
			}
			else {
				currentNode = new TestTreeBranchNode(test.name, test, _testTree);
			}
			
 			var index : uint = 1;
			
			if (parentNode.hasChildren) {
				index = _testTree.dataDescriptor.getChildren(parentNode).length;
			} 
			
 			if (!_testTree.dataDescriptor.addChildAt(parentNode, currentNode, index)) {
				throw Error("Tree: adding child failed");
			}
			
			var childsTest : ArrayCollection = ArrayCollection(_testTree.dataDescriptor.getChildren(parentNode)); 
			
			_testTree.setItemIcon(currentNode, TestIcons.NONE, TestIcons.NONE);
			if(test is TestCase) {
				var testCase : TestCase = TestCase(test);
				for (var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(testCase.tests); iterator.hasNext();) {
					var subTest : ITest = ITest(iterator.next());
					buildTreeNode(currentNode, subTest);
				}
			} 
			
			return currentNode;
		} 
		
		protected function onInitialize() : void {
			_testTree.addEventListener(ListEvent.ITEM_CLICK, onTestTreeCellPress);
			clearOutput();
		}
		
		private function onTestTreeCellPress(event : ListEvent) : void {
			var selectedItem : TestTreeNode = TestTreeNode(_testTree.selectedItem);
			var testResult : TestResult = selectedItem.result;
			if(testResult != null) {
				showTestResult(testResult);
			}
		}
		
		protected function onClearButtonClick() : void {
			clearOutput();
		}
	
		protected function onStartButtonClick() : void {
			var nodes : Array = _testTree.selectedItems;
	
			for (var i : Number = 0; i < nodes.length; i++) {
				var selectedItem : TestTreeNode = TestTreeNode(nodes[i]);
				if (selectedItem.test != null) {
					runTest(selectedItem.test);
				} else {
					runTest(_test);
				}
			}
		}
		
		private function showTestResult(testResult : TestResult) : void {
			if (testResult.message != null) {
				_testResultMessage = testResult.message;
			}
		}
		
		private function outputItem(icon : Class, message : String) : void {
			dataProvider.addItem({icon : icon, message : message});
		}
		
		private function outputStart(test : ITest) : void {
			var testName : String = test.name;
			var formatString : String = "{0} has started";
			var icon : Class = TestIcons.INFO;
			var message : String = StringUtil.substitute(formatString, [testName]);
			outputItem(icon, message);
		}
		
		private function outputFinish(test : ITest, testResult : TestResult) : void {
			var testName : String = test.name;
			var success : Boolean = testResult.success();
			var result : String = success ? "successfully" : "with errors";
			var formatString : String = "{0} has finished {1}";
			var icon : Class = TestIcons.getResultIcon(success);
			var message : String = StringUtil.substitute(formatString, [testName, result]);
			outputItem(icon, message);
		}
		
		private function onTestStart(event : TestStartEvent) : void {
			var test : ITest = ITest(event.test);
			outputStart(test);
		}
	
		private function onTestFinish(event : TestFinishEvent) : void {
			var test : ITest = event.test;
			var testResult : TestResult = event.result;
			outputFinish(test, testResult);
			showTestResult(testResult);
			_startButton.enabled = true;
			_clearButton.enabled = true;
			
			test.start.removeListener(onTestStart);
			test.finish.removeListener(onTestFinish);
			test.subTestStart.removeListener(onSubTestStart);
			test.subTestFinish.removeListener(onSubTestFinish);
		}
	
		private function onSubTestStart(event : SubTestStartEvent) : void {
			outputStart(event.subTest);
		}
	
		private function onSubTestFinish(event : SubTestFinishEvent) : void {
			outputFinish(event.subTest, event.subTestResult);
		}
		
		private function clearOutput() : void {
			dataProvider = new ArrayCollection();
		}
	
		private function runTest(test : ITest) : void {
			_startButton.enabled = false;
			_clearButton.enabled = false;
			test.start.addListener(onTestStart);
			test.finish.addListener(onTestFinish);
			test.subTestStart.addListener(onSubTestStart);
			test.subTestFinish.addListener(onSubTestFinish);
			test.run(new TestResult());
		}
		
	}
	
}