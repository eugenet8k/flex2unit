package org.flex2unit.ui.common {
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.controls.treeClasses.TreeListData;
	
	import org.flex2unit.framework.TestResult;
	import org.flex2unit.framework.events.TestFinishEvent;
	import org.flex2unit.framework.interfaces.ITest;
	import org.flex2unit.ui.constants.TestIcons;
	
	/**
	 * @author Maxym Hryniv
	 */
	public class TestTreeNode extends TreeListData {
		
		protected var _test : ITest;
		
		protected var _result : TestResult;
		
		public function TestTreeNode(label : String, test : ITest, owner : Tree) {
			
			super(label, label, owner);
			
			_test = test;
			if(test != null) {
				test.finish.addListener(onTestFinished);
			}
		}
		
		protected function onTestFinished(event : TestFinishEvent) : void {
			_result = event.result;
			var icon : Class = TestIcons.getResultIcon(result.success());
			Tree(owner).setItemIcon(this, icon, icon);
		}
	
		public function get test() : ITest {
			return _test;
		}
		
		public function get result() : TestResult {
			return _result;
		}
		
		//added because of 2.01 bug
		public function get children() : ArrayCollection {
			return _children;
		}
		
		public function set children(value : ArrayCollection) : void {
			_children = value;
		}
		
		private var _children : ArrayCollection = new ArrayCollection();
	
	}
}