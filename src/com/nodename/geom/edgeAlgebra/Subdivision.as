package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	// A subdivision of a manifold M is a partition S of M into three finite collections of disjoint parts:
	// the vertices, the edges, and the faces
	public final class Subdivision implements IDisposable
	{
		private var _edgeRecords:Vector.<EdgeRecord>;
		
		public function dispose():void
		{
			_edgeRecords = null;
		}
		
		public function Subdivision()
		{
			_edgeRecords = new Vector.<EdgeRecord>();
		}
		
		public function addEdgeRecord(edgeRecord:EdgeRecord):Subdivision
		{
			_edgeRecords.push(edgeRecord);
			return this;
		}
		
		public function isDualOf(other:Subdivision):Boolean
		{
			// return (for every edge e in this, e.dual is in other, and vice versa);
			return true;
		}
	}
}