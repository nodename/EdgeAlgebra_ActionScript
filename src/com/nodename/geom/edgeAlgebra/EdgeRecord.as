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
		
		private var _edgePairs:Vector.<EdgePair>;
		private var _nodePairs:Vector.<NodePair>;

		
		public function node(rotation:uint, f:uint):Node
		{
			return _nodePairs[rotation % 4].node(f);
		}
		
		
		
		public function edgeONext(edge:QuadEdge, exponent:int):QuadEdge
		{
			for (var i:uint = 0; i < exponent; i++)
			{
				var rotation:uint = edge.r;
				var f:uint = edge.orientation;
				edge = _edgePairs[(rotation + f) % 4].next.rot(f).flip(f);
			}
			return edge;
		}
		
		public function quadEdge(rotation:uint, f:uint):QuadEdge
		{
			return _edgePairs[rotation % 4].quadEdge(f);
		}
			
		public function get e0():QuadEdge
		{
			return quadEdge(0, 0);
		}
		
		
		public function dispose():void
		{
			_edgePairs = null;
			_nodePairs = null;
		}
		
		public function EdgeRecord()
		{
			construct();
		}
		
		private function construct():void
		{
			var index:uint;
			
			_nodePairs = new Vector.<NodePair>(4, true);

			for (index = 0; index < 4; index++)
			{
				var node0:Node = new Node(index, 0, index == LEFT_FACE ? node(RIGHT_FACE, 0) : null);
				var node1:Node = new Node(index, 1, index == LEFT_FACE ? node(RIGHT_FACE, 1) : null);
				_nodePairs[index] = new NodePair(node0, node1);
			}
			
			_edgePairs = new Vector.<EdgePair>(4, true);
			
			for (index = 0; index < 4; index++)
			{
				var edge0:QuadEdge = new QuadEdge(this, index, 0);
				var edge1:QuadEdge = new QuadEdge(this, index, 1);
				_edgePairs[index] = new EdgePair(edge0, edge1);
			}
			
			_nodePairs[ORIGIN_VERTEX].node(0)
				.addLeavingEdge(quadEdge(0, 0));
				
			_nodePairs[ORIGIN_VERTEX].node(1)
				.addLeavingEdge(quadEdge(0, 1));
			
			_nodePairs[DEST_VERTEX].node(0)
				.addLeavingEdge(quadEdge(2, 0));
				
			_nodePairs[DEST_VERTEX].node(1)
				.addLeavingEdge(quadEdge(2, 1));
				
			_nodePairs[RIGHT_FACE].node(0)
				.addLeavingEdge(quadEdge(1, 0));
				
			_nodePairs[RIGHT_FACE].node(1)
				.addLeavingEdge(quadEdge(1, 1));
			
			_nodePairs[LEFT_FACE].node(0)
				.addLeavingEdge(quadEdge(3, 0));
				
			_nodePairs[LEFT_FACE].node(1)
				.addLeavingEdge(quadEdge(3, 1));

			
			for (index = 0; index < 4; index++)
			{
				_edgePairs[index].next = quadEdge(index, 0).oNext();
			}
		}
		
		public function toString():String
		{
			return "{EdgeRecord:\n" + _edgePairs[0] + "\n\n" + _edgePairs[1] + "\n\n" + _edgePairs[2] + "\n\n" + _edgePairs[3] + "}";
		}
		
	}
}