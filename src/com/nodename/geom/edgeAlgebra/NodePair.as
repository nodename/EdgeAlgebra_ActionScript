package com.nodename.geom.edgeAlgebra
{
	internal final class NodePair
	{
		private var _nodes:Vector.<Node>;
		
		public function dispose():void
		{
			_nodes = null;
		}
		
		public function NodePair(node0:Node, node1:Node)
		{
			_nodes = new Vector.<Node>(2, true);
			_nodes[0] = node0;
			_nodes[1] = node1;
		}
		
		public function node(i:uint):Node
		{
			return _nodes[i % 2];
		}
	}
}