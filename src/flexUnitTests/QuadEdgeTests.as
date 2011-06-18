package flexUnitTests
{
	import com.nodename.geom.edgeAlgebra.EdgeRecord;
	import com.nodename.geom.edgeAlgebra.Ring;
	import com.nodename.geom.edgeAlgebra.QuadEdge;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.runners.Parameterized;
	import org.hamcrest.core.given;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.strictlyEqualTo;

	// These tests must hold for any QuadEdge
	[RunWith("org.flexunit.runners.Parameterized")]
	public class QuadEdgeTests
	{		
		Parameterized;

		private var _edge:QuadEdge;
		private var _edgeRecord:EdgeRecord;
		private var _rotation:uint;
		private var _orientation:uint;
		
		[Parameters]
		public static function data():Array
		{
			const edge:QuadEdge = QuadEdge.makeEdge();
			const edgeRecord:EdgeRecord = edge.edgeRecord;
			return [
				  [edgeRecord.quadEdge(0, 0)]
				, [edgeRecord.quadEdge(0, 1)]
				, [edgeRecord.quadEdge(1, 0)]
				, [edgeRecord.quadEdge(1, 1)]
				, [edgeRecord.quadEdge(2, 0)]
				, [edgeRecord.quadEdge(2, 1)]
				, [edgeRecord.quadEdge(3, 0)]
				, [edgeRecord.quadEdge(3, 1)]
			];
		}
		
		public function QuadEdgeTests(param:QuadEdge)
		{
			_edge = param;
		}
		
		[Before]
		public function setUp():void
		{
			_edgeRecord = _edge.edgeRecord;
			_rotation = _edge.r;
			_orientation = _edge.orientation;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function dualDefinition_Equation1():void
		{
			assertThat(_edge.dual.dual, strictlyEqualTo(_edge));
		}
		
		[Test]
		public function dualDefinition_Equation2():void
		{
			assertThat(_edge.sym().dual, strictlyEqualTo(_edge.dual.sym()));
		}
		
		[Test]
		public function dualDefinition_Equation3():void
		{
			assertThat(_edge.flip().dual, strictlyEqualTo(_edge.dual.flip().sym()));
		}
		
		[Test]
		public function dualDefinition_Equation4():void
		{
			assertThat(_edge.lNext().dual, strictlyEqualTo(_edge.dual.oNext(-1)));
		}
		
		[Test]
		public function dualDefinition_Face_to_Vertex():void
		{
			const dual:QuadEdge = _edge.dual;
			const left:Ring = _edge.leftFace;
			assertThat(_edge.leftFace.dual(_edge), strictlyEqualTo(_edge.dual.originVertex));
		}
		
		[Test]
		public function dualDefinition_VertexToFace():void
		{
			assertThat(_edge.originVertex.dual(_edge), strictlyEqualTo(_edge.dual.leftFace));
		}
		
		[Test]
		public function rotEqualsFlipDual():void
		{
			assertThat(_edge.rot(), strictlyEqualTo(_edge.flip().dual));
		}
		
		[Test]
		public function rotRotEqualsSym():void
		{
			assertThat(_edge.rot().rot(), strictlyEqualTo(_edge.sym()));
		}
		
		[Test]
		public function edgeFunctionsProperty1():void
		{
			assertThat(_edge.rot(4), strictlyEqualTo(_edge));
		}
		
		[Test]
		public function edgeFunctionsProperty2():void
		{
			assertThat(_edge.rot().oNext().rot().oNext(), strictlyEqualTo(_edge));
		}
		
		[Test]
		public function edgeFunctionsProperty3():void
		{
			assertThat(_edge.rot(2), not((strictlyEqualTo(_edge))));
		}
		
		[Ignore]
		[Test]
		public function edgeFunctionsProperty4():void
		{
			// if Subdivisions s and s' are duals, then s contains edge e iff s' contains e.dual
			Assert.fail("Test method Not yet implemented");
		}
		
		[Ignore]
		[Test]
		public function edgeFunctionsProperty5():void
		{
			// Subdivision s contains edge e iff s contains e.onext
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function flipFunctionsProperty1():void
		{
			assertThat(_edge.flip(2), strictlyEqualTo(_edge));
		}
		
		[Test]
		public function flipFunctionsProperty2():void
		{
			assertThat(_edge.flip().oNext().flip().oNext(), strictlyEqualTo(_edge));
		}
		
		[Test]
		public function flipFunctionsProperty3():void
		{
			// for all n:
			for (var n:int = -10; n < 11; n++)
			{
				assertThat(_edge.flip().oNext(n), not(strictlyEqualTo(_edge)));
			}
		}
		
		[Test]
		public function flipFunctionsProperty4():void
		{
			assertThat(_edge.flip().rot().flip().rot(), strictlyEqualTo(_edge));
		}
		
		[Ignore]
		[Test]
		public function flipFunctionsProperty5():void
		{
			// Subdivision s contains edge e iff s contains e.flip
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function usefulProperty1():void
		{
			assertThat(_edge.flip(-1), strictlyEqualTo(_edge.flip()));
		}
		
		[Test]
		public function usefulProperty2():void
		{
			assertThat(_edge.sym(), strictlyEqualTo(_edge.rot(2)));
		}
		
		[Test]
		public function usefulProperty3():void
		{
			assertThat(_edge.rot(-1), strictlyEqualTo(_edge.rot(3)));
		}
		
		[Test]
		public function usefulProperty4():void
		{
			assertThat(_edge.rot(-1), strictlyEqualTo(_edge.flip().rot().flip()));
		}
		
		[Test]
		public function usefulProperty5():void
		{
			assertThat(_edge.dual, strictlyEqualTo(_edge.flip().rot()));
		}
		
		[Test]
		public function usefulProperty6():void
		{
			assertThat(_edge.oNext(-1), strictlyEqualTo(_edge.rot().oNext().rot()));
		}
		
		[Test]
		public function usefulProperty7():void
		{
			assertThat(_edge.oNext(-1), strictlyEqualTo(_edge.flip().oNext().flip()));
		}
		
		[Test]
		public function usefulProperty8():void
		{
			assertThat(_edge.lNext(), strictlyEqualTo(_edge.rot(-1).oNext().rot()));
		}
		
		[Test]
		public function usefulProperty9():void
		{
			assertThat(_edge.rNext(), strictlyEqualTo(_edge.rot().oNext().rot(-1)));
		}
		
		[Test]
		public function usefulProperty10():void
		{
			assertThat(_edge.dNext(), strictlyEqualTo(_edge.sym().oNext().sym()));
		}
		
		[Test]
		public function leftDefinition():void
		{
			trace(_edge.edgeRecord);
			trace(_edge);
			const leftFace:Ring = _edge.leftFace;
			const rotMinus1:QuadEdge = _edge.rot(-1);
			const originVertex:Ring = rotMinus1.originVertex;
			//assertThat(_edge.leftFace.equals(_edge.rot(-1).originVertex));
			assertThat(leftFace.equals(originVertex));
		}
		
		[Test]
		public function rightDefinition():void
		{
			assertThat(_edge.rightFace.equals(_edge.rot().originVertex));
		}
		
		[Test]
		public function destDefinition():void
		{
			assertThat(_edge.destVertex, strictlyEqualTo(_edge.sym().originVertex));
		}
		
		[Test]
		public function nextProperty1():void
		{
			assertThat(_edge.lNext().leftFace.equals(_edge.leftFace));
		}
		
		[Test]
		public function nextProperty2():void
		{
			assertThat(_edge.rNext().rightFace.equals(_edge.rightFace));
		}
		
		[Test]
		public function nextProperty3():void
		{
			assertThat(_edge.dNext().destVertex.equals(_edge.destVertex));
		}
		
		[Test]
		public function nextProperty4():void
		{
			// NB This one is different from the other three!
			assertThat(_edge.rNext().destVertex.equals(_edge.originVertex));
		}
		
		[Test]
		public function prevProperty1():void
		{
			assertThat(_edge.oPrev(), strictlyEqualTo(_edge.rot().oNext().rot()));
		}
		
		[Test]
		public function prevProperty2():void
		{
			assertThat(_edge.lPrev(), strictlyEqualTo(_edge.oNext().sym()));
		}
		
		[Test]
		public function prevProperty3():void
		{
			assertThat(_edge.rPrev(), strictlyEqualTo(_edge.sym().oNext()));
		}
		
		[Test]
		public function prevProperty4():void
		{
			const a:QuadEdge = _edge.dPrev();
			assertThat(_edge.dPrev(), strictlyEqualTo(_edge.rot(-1).oNext().rot(-1)));
		}
		
		[Test]
		public function oNextDefinition():void
		{
			const otherEdge:QuadEdge = _edgeRecord.quadEdge(_rotation, 0);
			assertThat(given((_orientation == 1),
				(_edge.oNext(), strictlyEqualTo(otherEdge.oNext(-1).flip()))));
		}
		
		[Test]
		public function symDefinition():void
		{
			assertThat(_edge.sym(), strictlyEqualTo(_edgeRecord.quadEdge(_rotation + 2, _orientation)));
		}
		
		[Test]
		public function rotMinus1Definition():void
		{
			assertThat(_edge.rot(-1), strictlyEqualTo(_edgeRecord.quadEdge(_rotation + 3 + 2 * _orientation, _orientation)));
		}
	}
}