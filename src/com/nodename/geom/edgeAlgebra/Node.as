package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// This class represents a vertex or a face in the graph
	public final class Node implements IDisposable
	{
		// in ccw order:
		
		private var _edgeLists:EdgeLists;
		
		private var _leavingEdges:Vector.<QuadEdge>;
		private var _enteringEdges:Vector.<QuadEdge>;
		private var _ccwEdges:Vector.<QuadEdge>;
		private var _cwEdges:Vector.<QuadEdge>;
		
		private var _r:uint;
		public function get r():uint 
		{
			return _r;
		}
		private var _f:uint;
		public function get orientation():uint 
		{
			
			return _f;
		}
		
		public function dispose():void
		{
			_edgeLists = null;
			_leavingEdges = null;
			_enteringEdges = null;
			_ccwEdges = null;
			_cwEdges = null;
		}
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function Node(edgeRecord:EdgeRecord, r:uint, f:uint, cloneOf:Node=null)
		{
			index = NEXT_INDEX++;
			_edgeLists = cloneOf ? cloneOf._edgeLists : new EdgeLists();
			
			_leavingEdges = _edgeLists.leavingEdges;
			_enteringEdges = _edgeLists.enteringEdges;
			_ccwEdges = _edgeLists.ccwEdges;
			_cwEdges = _edgeLists.cwEdges;
			
			addEdgeRecord(edgeRecord, r, f);
		}
		
		public function equals(other:Node):Boolean
		{
			return other._edgeLists == this._edgeLists;
		}
		
		public function toString():String
		{
			return "[Node " + index + ": r " + _r + " f " + _f + "]";
		}
		
		public function addEdgeRecord(edgeRecord:EdgeRecord, r:uint, f:uint):Node
		{
			//_edgeRecords.push(edgeRecord);
			_r = r;
			_f = f;
			return this;
		}
		
		public function addLeavingEdge(edge:QuadEdge):Node
		{
			_leavingEdges.push(edge);
			return this;
		}
		
		public function addEnteringEdge(edge:QuadEdge):Node
		{
			_enteringEdges.push(edge);
			return this;
		}
		
		public function addCcwEdge(edge:QuadEdge):Node
		{
			_ccwEdges.push(edge);
			return this;
		}
		
		public function addCwEdge(edge:QuadEdge):Node
		{
			_cwEdges.push(edge);
			return this;
		}
		
		public function nextLeavingEdge(edge:QuadEdge, exponent:uint):QuadEdge
		{
			return nextEdge(edge, exponent, _leavingEdges);
		}
		
		public function nextEnteringEdge(edge:QuadEdge, exponent:uint):QuadEdge
		{
			return nextEdge(edge, exponent, _enteringEdges);
		}
		
		public function nextCcwEdge(edge:QuadEdge, exponent:uint):QuadEdge
		{
			return nextEdge(edge, exponent, _ccwEdges);
		}
		
		public function nextCwEdge(edge:QuadEdge, exponent:uint):QuadEdge
		{
			return nextEdge(edge, exponent, _cwEdges);
		}
		
		private function nextEdge(edge:QuadEdge, exponent:uint, list:Vector.<QuadEdge>):QuadEdge
		{
			const edgeIndex:int = list.indexOf(edge);
			if (edgeIndex == -1)
			{
				throw new Error("edge is not in list");
			}
			const nextIndex:uint = (edgeIndex + exponent) % list.length;
			return list[nextIndex];
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
import com.nodename.geom.edgeAlgebra.QuadEdge;

class EdgeLists
{
	public var leavingEdges:Vector.<QuadEdge>;
	public var enteringEdges:Vector.<QuadEdge>;
	public var ccwEdges:Vector.<QuadEdge>;
	public var cwEdges:Vector.<QuadEdge>;
	
	public function EdgeLists()
	{
		leavingEdges = new Vector.<QuadEdge>();
		enteringEdges = new Vector.<QuadEdge>();
		ccwEdges = new Vector.<QuadEdge>();
		cwEdges = new Vector.<QuadEdge>();
	}
}