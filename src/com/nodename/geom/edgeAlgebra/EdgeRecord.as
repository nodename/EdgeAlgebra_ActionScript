package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;
	
	import org.hamcrest.object.nullValue;

	// The EdgeRecord represents eight QuadEdges: the four oriented and directed versions of an undirected edge and of its dual
	public final class EdgeRecord implements IDisposable
	{
		// NodeRoles:
		public static const RIGHT_FACE:uint = 0;
		public static const DEST_VERTEX:uint = 1;
		public static const LEFT_FACE:uint = 2;
		public static const ORIGIN_VERTEX:uint = 3;
		
		// EdgeRoles:
		/*public static const CW_EDGE:uint = 0;
		public static const LEAVING_EDGE:uint = 1;
		public static const CCW_EDGE:uint = 2;
		public static const ENTERING_EDGE:uint = 3;*/
		
		private var _edges:Vector.<Vector.<QuadEdge>>;
		private var _rings:Vector.<Vector.<Ring>>;
		private var _nextEdges:Vector.<QuadEdge>;

		
		public function ring(rotation:int, f:uint):Ring
		{
			return _rings[(rotation + 4) % 4][(f + 2) % 2];
		}
		
		
		// not using this yet
		public function edgeONext(edge:QuadEdge, exponent:int):QuadEdge
		{
			for (var i:uint = 0; i < exponent; i++)
			{
				var rotation:uint = edge.r;
				var f:uint = edge.orientation;
				edge = _nextEdges[(rotation + f) % 4].rot(f).flip(f);
			}
			return edge;
		}
		
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
			
			_rings = new Vector.<Vector.<Ring>>(4, true);

			for (index = 0; index < 4; index++)
			{
				_rings[index] = Vector.<Ring>([
					new Ring(index, 0, index == LEFT_FACE ? ring(RIGHT_FACE, 0) : null),
					new Ring(index, 1, index == LEFT_FACE ? ring(RIGHT_FACE, 1) : null)
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

				
			ring(0, 0)
				.addLeavingEdge(quadEdge(1, 0));
				
			ring(0, 1)
				.addLeavingEdge(quadEdge(1, 1));
			
			ring(1, 0)
				.addLeavingEdge(quadEdge(2, 0));
				
			ring(1, 1)
				.addLeavingEdge(quadEdge(2, 1));
			
			ring(2, 0)
				.addLeavingEdge(quadEdge(3, 0));
				
			ring(2, 1)
				.addLeavingEdge(quadEdge(3, 1));
			
			ring(3, 0)
				.addLeavingEdge(quadEdge(0, 0));
				
			ring(3, 1)
				.addLeavingEdge(quadEdge(0, 1));

			_nextEdges = new Vector.<QuadEdge>(4, true);
			for (index = 0; index < 4; index++)
			{
				_nextEdges[index] = quadEdge(index, 0).oNext();
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