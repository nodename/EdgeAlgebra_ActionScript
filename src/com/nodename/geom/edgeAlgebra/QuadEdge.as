package com.nodename.geom.edgeAlgebra
{
	import com.nodename.utils.IDisposable;

	public final class QuadEdge implements IDisposable
	{
		public static function makeEdge():QuadEdge
		{
			const edgeRecord:EdgeRecord = new EdgeRecord();
			const subdivision:Subdivision = new Subdivision()
									.addEdgeRecord(edgeRecord);
			
			return edgeRecord.e0;
		}
		
		private var _edgeRecord:EdgeRecord;
		public function get edgeRecord():EdgeRecord 
		{
			return _edgeRecord;
		}
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
			_edgeRecord = null;
		}

		// direction: originVertex and destVertex
		public function get originVertex():Node { return _edgeRecord.node(_r + 3, _f); }
		public function get destVertex():Node { return _edgeRecord.node(_r + 1, _f); }
		
		// orientation: leftFace and rightFace
		public function get leftFace():Node
		{
			return _edgeRecord.node(_r + 2, _f);
		}
		
		public function get rightFace():Node
		{
			return _edgeRecord.node(_r, _f);
		}
		
		//protected static const LOCK:Object = {};
		
		private static var NEXT_INDEX:uint = 0;
		public var index:uint;
		public function QuadEdge(edgeRecord:EdgeRecord, r:uint, f:uint/*, lock:Object*/)
		{
			/*if (lock != LOCK)
			{
				throw new Error("invalid constructor access");
			}*/
			
			index = NEXT_INDEX++;
			_edgeRecord = edgeRecord;
			_r = r;
			_f = f;
		}

		
		public function rot(exponent:int=1):QuadEdge
		{
			return _edgeRecord.quadEdge(_r + (1 + 2 * _f) * exponent, _f);
		}
		
		public function sym(exponent:int=1):QuadEdge
		{
			// return the symmetric QuadEdge: the one with same orientation and opposite direction
			return _edgeRecord.quadEdge(_r + 2 * exponent, _f);
		}
		
		public function flip(exponent:int=1):QuadEdge
		{
			// return the QuadEdge with same direction and opposite orientation
			return _edgeRecord.quadEdge(_r, _f + exponent);
		}
		
		
		
		public function oNext(exponent:int=1):QuadEdge
		{
			// return the QuadEdge immediately following this one counterclockwise in the ring of edges out of originVertex
			return originVertex.nextLeavingEdge(this, exponent);
		}
		
		public function dNext(exponent:int=1):QuadEdge
		{
			// return the QuadEdge immediately following this one counterclockwise in the ring of edges into destVertex
			return destVertex.nextEnteringEdge(this, exponent);
		}
		
		public function lNext(exponent:int=1):QuadEdge
		{
			// return the next counterclockwise QuadEdge with the same left face
			return leftFace.nextCcwEdge(this, exponent);
		}
		
		public function rNext(exponent:int=1):QuadEdge
		{
			// return the next clockwise QuadEdge with the same right face
			return rightFace.nextCwEdge(this, exponent);
		}
		
		
		public function oPrev(exponent:int=1):QuadEdge
		{
			// return the QuadEdge immediately following this one clockwise in the ring of edges out of originVertex
			return oNext(-exponent);
		}
		
		public function dPrev(exponent:int=1):QuadEdge
		{
			// return the QuadEdge immediately following this one clockwise in the ring of edges into destVertex
			return dNext(-exponent);
		}
		
		public function lPrev(exponent:int=1):QuadEdge
		{
			// return the next clockwise QuadEdge with the same left face
			return lNext(-exponent);
		}
		
		public function rPrev(exponent:int=1):QuadEdge
		{
			// return the next clockwise QuadEdge with the same right face
			return rNext(-exponent);
		}
		
		public function get dual():QuadEdge
		{
			return flip().rot();
		}
		
		public function toString():String
		{
			return "[QuadEdge " + index + "(r " + _r + " f " + _f + "): origin: " + originVertex + ", dest: " + destVertex + ", left: " + leftFace + ", right: " + rightFace + "]";
		}
		
	}
}