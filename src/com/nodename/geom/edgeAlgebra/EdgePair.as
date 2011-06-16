package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	internal final class EdgePair implements IDisposable
	{
		private var _edges:Vector.<QuadEdge>;
		
		public var next:QuadEdge;
		
		public function dispose():void
		{
			_edges = null;
			next = null;
		}
		
		public function EdgePair(edge0:QuadEdge, edge1:QuadEdge)
		{
			_edges = new Vector.<QuadEdge>(2, true);
			_edges[0] = edge0;
			_edges[1] = edge1;
		}
		
		public function quadEdge(i:uint):QuadEdge
		{
			return _edges[i % 2];
		}
		
		public function toString():String
		{
			return "[EdgePair:\n\t" + _edges[0] + "\n\t" + _edges[1] + "]";
		}
	}
}