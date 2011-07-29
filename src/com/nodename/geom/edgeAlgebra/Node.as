package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// This class represents either a vertex or a face of the graph
	public final class Node implements IDisposable
	{
		// node roles:
		public static const RIGHT_FACE:uint = 0;
		public static const DEST_VERTEX:uint = 1;
		public static const LEFT_FACE:uint = 2;
		public static const ORIGIN_VERTEX:uint = 3;
		
		private var _uniqueNode:Object;
		
		private var _r:uint;
		private var _f:uint;
		
		public function dispose():void
		{
			_uniqueNode = null;
		}
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function Node(r:uint, f:uint, cloneOf:Node=null)
		{
			index = NEXT_INDEX++;
			_uniqueNode = cloneOf ? cloneOf._uniqueNode : {};
			
			_r = r;
			_f = f;
		}
		
		public function equals(other:Node):Boolean
		{
			return other._uniqueNode == this._uniqueNode;
		}
		
		public function toString():String
		{
			return "[Ring " + index + ": r " + _r + " f " + _f + "]";
		}
		
		// TODO revisit this. It passes all current tests but it's not done
		public function dual(edge:QuadEdge):Node
		{
			var result:Node = null;
			var dual:QuadEdge = edge.dual;
			const myRelationshipToEdge:uint = (_r - edge.r + 4) % 4;
			switch (myRelationshipToEdge)
			{
				case RIGHT_FACE:
					result = _f == 0 ? dual.destVertex : dual.originVertex;
					//result = dual.destVertex;
					break;
				case DEST_VERTEX:
					result = dual.rightFace;
					break;
				case LEFT_FACE:
					result = _f == 0 ? dual.originVertex : dual.destVertex;
					//result = dual.originVertex;
					break;
				case ORIGIN_VERTEX:
					result = dual.leftFace;
					break;
			}
			
			return result;
		}
	}
}
