package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;
	
	import org.hamcrest.object.nullValue;

	// The EdgeRecord represents eight QuadEdges: the four oriented and directed versions of an undirected edge and of its dual
	internal final class EdgeRecord implements IDisposable
	{
		private var _edges:Vector.<Vector.<QuadEdge>>;
		private var _rings:Vector.<Vector.<Node>>;

		
		public function ring(rotation:int, f:uint):Node
		{
			return _rings[(rotation + 4) % 4][(f + 2) % 2];
		}
		
		
		/*public function edgeONext(edge:QuadEdge, exponent:int):QuadEdge
		{
			for (var i:uint = 0; i < exponent; i++)
			{
				var rotation:uint = edge.r;
				var f:uint = edge.orientation;
				edge = _nextEdges[(rotation + f) % 4].rot(f).flip(f);
			}
			return edge;
		}*/
		
		public function quadEdge(rotation:int, f:int):QuadEdge
		{
			return _edges[(rotation + 4) % 4][(f + 2) % 2];
		}
			
		public function get e0():QuadEdge
		{
			return quadEdge(0, 0);
		}
		
		
		public function dispose():void
		{
			_edges = null;
			_rings = null;
		}
		
		public function EdgeRecord()
		{
			construct();
		}
		
		private function construct():void
		{
			var index:uint;
			
			_rings = new Vector.<Vector.<Node>>(4, true);

			for (index = 0; index < 4; index++)
			{
				_rings[index] = Vector.<Node>([
					new Node(index, 0, index == 2 ? ring(0, 0) : null),
					new Node(index, 1, index == 2 ? ring(0, 1) : null)
				]);
			}
			
			_edges = new Vector.<Vector.<QuadEdge>>(4, true);
			
			for (index = 0; index < 4; index++)
			{
				_edges[index] = Vector.<QuadEdge>([
					new QuadEdge(this, index, 0),
					new QuadEdge(this, index, 1)
				]);
			}
				
			for (var orientation:uint = 0; orientation < 2; orientation++)
			{
				quadEdge(0, orientation).oNextRef = quadEdge(0, orientation);
				quadEdge(1, orientation).oNextRef = quadEdge(3, orientation);
				quadEdge(2, orientation).oNextRef = quadEdge(2, orientation);
				quadEdge(3, orientation).oNextRef = quadEdge(1, orientation);
			}
		}
		
		public function toString():String
		{
			return "{EdgeRecord:" +
				"\n" + _edges[0][0] +
				"\n" + _edges[0][1] +
				"\n" + _edges[1][0] +
				"\n" + _edges[1][1] +
				"\n" + _edges[2][0] +
				"\n" + _edges[2][1] +
				"\n" + _edges[3][0] +
				"\n" + _edges[3][1] +
			"\n}";
		}
		
	}
}