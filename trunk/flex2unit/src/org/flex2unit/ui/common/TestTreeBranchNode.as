package org.flex2unit.ui.common
{
	import org.flex2unit.framework.interfaces.ITest;
	import mx.controls.Tree;
	import mx.collections.ArrayCollection;

	public class TestTreeBranchNode extends TestTreeNode
	{
		
		public function TestTreeBranchNode(label:String, test:ITest, owner:Tree)
		{
			super(label, test, owner);
		}
		
		public override function get children() : ArrayCollection {
			return super.children;
		}
		
	}
}