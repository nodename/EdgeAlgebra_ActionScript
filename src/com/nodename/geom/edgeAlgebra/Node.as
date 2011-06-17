package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// This class represents either a vertex of the primal graph and a face in the dual graph, or vice versa
	public final class Node implements IDisposable
	{
		// These are my leaving edges in my role as a vertex
		// in ccw order:
		private var _leavingEdges:Vector.<QuadEdge>;
		
		private var _r:uint;
		private var _f:uint;
		
		public function dispose():void
		{
			_leavingEdges = null;
		}
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function Node(r:uint, f:uint, cloneOf:Node=null)
		{
			index = NEXT_INDEX++;
			_leavingEdges = cloneOf ? cloneOf._leavingEdges : new Vector.<QuadEdge>();
			
			_r = r;
			_f = f;
		}
		
		public function equals(other:Node):Boolean
		{
			return other._leavingEdges == this._leavingEdges;
		}
		
		public function toString():String
		{
			return "[Node " + index + ": r " + _r + " f " + _f + "]";
		}
		
		public function addLeavingEdge(edge:QuadEdge):Node
		{
			_leavingEdges.push(edge);
			return this;
		}
		
		public function nextLeavingEdge(edge:QuadEdge, exponent:uint):QuadEdge
		{
			const edgeIndex:int = _leavingEdges.indexOf(edge);
			if (edgeIndex == -1)
			{
				throw new Error("edge is not in ring");
			}
			const nextIndex:uint = (edgeIndex + exponent) % _leavingEdges.length;
			return _leavingEdges[nextIndex];
		}
		
		public function dual(edge:QuadEdge):Node
		{
			var result:Node = null;
			var dual:QuadEdge = edge.dual;
			const myRelationshipToEdge:uint = (_r - edge.r + 4) % 4;
			switch (myRelationshipToEdge)
			{
				case EdgeRecord.RIGHT_FACE:
					result = dual.destVertex;
					break;
				case EdgeRecord.DEST_VERTEX:
					result = dual.rightFace;
					break;
				case EdgeRecord.LEFT_FACE:
					result = dual.originVertex;
					break;
				case EdgeRecord.ORIGIN_VERTEX:
					result = dual.leftFace;
					break;
			}
			
			return result;
		}
	}
}
