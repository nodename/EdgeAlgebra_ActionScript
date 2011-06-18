package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// This class represents either a vertex or a face of the graph
	public final class Ring implements IDisposable
	{
		private var _uniqueNode:Object;
		
		private var _r:uint;
		private var _f:uint;
		
		public function dispose():void
		{
			_uniqueNode = null;
		}
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function Ring(r:uint, f:uint, cloneOf:Ring=null)
		{
			index = NEXT_INDEX++;
			_uniqueNode = cloneOf ? cloneOf._uniqueNode : {};
			
			_r = r;
			_f = f;
		}
		
		public function equals(other:Ring):Boolean
		{
			return other._uniqueNode == this._uniqueNode;
		}
		
		public function toString():String
		{
			return "[Ring " + index + ": r " + _r + " f " + _f + "]";
		}
		
		// TODO revisit this. It passes all current tests but it's not done
		public function dual(edge:QuadEdge):Ring
		{
			var result:Ring = null;
			var dual:QuadEdge = edge.dual;
			const myRelationshipToEdge:uint = (_r - edge.r + 4) % 4;
			switch (myRelationshipToEdge)
			{
				case EdgeRecord.RIGHT_FACE:
					result = _f == 0 ? dual.destVertex : dual.originVertex;
					//result = dual.destVertex;
					break;
				case EdgeRecord.DEST_VERTEX:
					result = dual.rightFace;
					break;
				case EdgeRecord.LEFT_FACE:
					result = _f == 0 ? dual.originVertex : dual.destVertex;
					//result = dual.originVertex;
					break;
				case EdgeRecord.ORIGIN_VERTEX:
					result = dual.leftFace;
					break;
			}
			
			return result;
		}
	}
}
