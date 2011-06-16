package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// This class represents a vertex or a face in the graph
	public final class Node implements IDisposable
	{
		// in ccw order:
		//private var _edgeRecords:Vector.<EdgeRecord>;
		
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
			//_edgeRecords = null;
			_leavingEdges = null;
			_enteringEdges = null;
			_ccwEdges = null;
			_cwEdges = null;
		}
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function Node(edgeRecord:EdgeRecord, r:uint, f:uint)
		{
			index = NEXT_INDEX++;
			//_edgeRecords = new Vector.<EdgeRecord>();
			_leavingEdges = new Vector.<QuadEdge>();
			_enteringEdges = new Vector.<QuadEdge>();
			_ccwEdges = new Vector.<QuadEdge>();
			_cwEdges = new Vector.<QuadEdge>();
			
			addEdgeRecord(edgeRecord, r, f);
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
		
		public function get dual():Node
		{
			return null;
			
			/*var edge:QuadEdge;
			if (_r % 2 == 0)
			{
				// I'm a face
			edge = _edgeRecords[0].ccwEdgeOf(_r, _f);
			return edge.dual.originVertex;
			}
			
			edge = _edgeRecords[0].leavingEdgeOf(_r, _f);
			return edge.dual.leftFace;*/
		}
	}
}
