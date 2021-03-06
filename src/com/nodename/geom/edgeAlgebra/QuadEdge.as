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
		
		public static function splice(a:QuadEdge, b:QuadEdge):void
		{
			const aNext:QuadEdge = a.oNext();
			const bNext:QuadEdge = b.oNext();
			const alpha:QuadEdge = aNext.rot();
			const beta:QuadEdge = bNext.rot();
			const alphaNext:QuadEdge = alpha.oNext();
			const betaNext:QuadEdge = beta.oNext();
			
			a.oNextRef = bNext;
			b.oNextRef = aNext;
			alpha.oNextRef = betaNext;
			beta.oNextRef = alphaNext;
		}
		
		private var _edgeRecord:EdgeRecord;
		public function quadEdge(rotation:uint, orientation:uint):QuadEdge 
		{
			return _edgeRecord.quadEdge(rotation, orientation);
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
		public function get originVertex():Node { return _edgeRecord.ring(_r + 3, _f); }
		public function get destVertex():Node { return _edgeRecord.ring(_r + 1, _f); }
		
		// orientation: leftFace and rightFace
		public function get leftFace():Node { return _edgeRecord.ring(_r + 2 + 2 * _f, _f); }
		public function get rightFace():Node { return _edgeRecord.ring(_r + 2 * _f, _f); }
		
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
			
			oNextRef = null;
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
		
		public var oNextRef:QuadEdge;
		
		public function oNext(exponent:int=1):QuadEdge
		{
			if (exponent < 0)
			{
				return oPrev(-exponent);
			}
			
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the QuadEdge immediately following this one counterclockwise in the ring of edges out of originVertex
				edge = edge.oNextRef;
			}
			return edge;
		}
		
		public function dNext(exponent:int=1):QuadEdge
		{
			if (exponent < 0)
			{
				return dPrev(-exponent);
			}
			
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the QuadEdge immediately following this one counterclockwise in the ring of edges into destVertex
				edge = edge.sym().oNext().sym();
			}
			return edge;
		}
		
		public function lNext(exponent:int=1):QuadEdge
		{
			if (exponent < 0)
			{
				return lPrev(-exponent);
			}
			
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the next counterclockwise QuadEdge with the same left face
				edge = edge.rot(-1).oNext().rot();
			}
			return edge;
		}
		
		public function rNext(exponent:int=1):QuadEdge
		{
			if (exponent < 0)
			{
				return rPrev(-exponent);
			}
			
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the next clockwise QuadEdge with the same right face
				edge = edge.rot().oNext().rot(-1);
			}
			return edge;
		}
		
		
		public function oPrev(exponent:int=1):QuadEdge
		{
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the QuadEdge immediately following this one clockwise in the ring of edges out of originVertex
				edge = edge.rot().oNext().rot();
			}
			return edge;
		}
		
		public function dPrev(exponent:int=1):QuadEdge
		{
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the QuadEdge immediately following this one clockwise in the ring of edges into destVertex
				edge = edge.rot(-1).oNext().rot(-1);
			}
			return edge;
		}
		
		public function lPrev(exponent:int=1):QuadEdge
		{
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the next clockwise QuadEdge with the same left face
				edge = edge.oNext().sym();
			}
			return edge;
		}
		
		public function rPrev(exponent:int=1):QuadEdge
		{
			var edge:QuadEdge = this;
			while (exponent--)
			{
				// find the next clockwise QuadEdge with the same right face
				edge = edge.sym().oNext();
			}
			return edge;
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