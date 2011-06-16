package flexUnitTests
{
	import com.nodename.geom.edgeAlgebra.QuadEdge;
	
	import org.flexunit.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.strictlyEqualTo;

	// These tests must hold for a QuadEdge newly created by makeEdge()
	public class MakeEdgeTests
	{		
		// newEdge will not be a loop, but _newEdgeRot will:
		private var _newEdge:QuadEdge;
		private var _newEdgeRot:QuadEdge;
		
		[Before]
		public function setUp():void
		{
			_newEdge = QuadEdge.makeEdge();
			_newEdgeRot = _newEdge.rot();
		}
		
		[After]
		public function tearDown():void
		{
			// TODO
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
		public function newEdge_OriginVertexDiffersFromDestVertex():void
		{
			assertThat(_newEdge.originVertex, not(strictlyEqualTo(_newEdge.destVertex)));
		}
		
		[Test]
		public function newEdge_LeftFaceEqualsRightFace():void
		{
			assertThat(_newEdge.leftFace, strictlyEqualTo(_newEdge.rightFace));
		}		
		
		[Test]
		public function newEdge_LNextEqualsRNext():void
		{
			assertThat(_newEdge.lNext(), strictlyEqualTo(_newEdge.rNext()));
		}		
		
		[Test]
		public function newEdge_LNextEqualsSym():void
		{
			assertThat(_newEdge.lNext(), strictlyEqualTo(_newEdge.sym()));
		}		
		
		[Test]
		public function newEdge_ONextEqualsOPrev():void
		{
			assertThat(_newEdge.oNext(), strictlyEqualTo(_newEdge.oPrev()));
		}		
		
		[Test]
		public function newEdge_ONextEqualsEdge():void
		{
			assertThat(_newEdge.oNext(), strictlyEqualTo(_newEdge));
		}
		
		[Test]
		public function newEdgeRot_OriginVertexEqualsDestVertex():void
		{
			assertThat(_newEdgeRot.originVertex, strictlyEqualTo(_newEdgeRot.destVertex));
		}
		
		[Test]
		public function newEdgeRot_LeftFaceDiffersFromRightFace():void
		{
			assertThat(_newEdgeRot.leftFace, not(strictlyEqualTo(_newEdgeRot.rightFace)));
		}	
		
		[Test]
		public function newEdgeRot_LNextEqualsRNext():void
		{
			assertThat(_newEdgeRot.lNext(), strictlyEqualTo(_newEdgeRot.rNext()));
		}		
		
		[Test]
		public function newEdgeRot_LNextEqualsEdge():void
		{
			assertThat(_newEdgeRot.lNext(), strictlyEqualTo(_newEdgeRot));
		}	
		
		[Test]
		public function newEdgeRot_ONextEqualsOPrev():void
		{
			assertThat(_newEdgeRot.oNext(), strictlyEqualTo(_newEdgeRot.oPrev()));
		}		
		
		[Test]
		public function newEdgeRot_ONextEqualsSym():void
		{
			assertThat(_newEdgeRot.oNext(), strictlyEqualTo(_newEdgeRot.sym()));
		}
	}
}