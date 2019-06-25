import utest.Assert;
import utest.Async;
import js.jquery.Helper.J as JQ;
import js.Browser.document as doc;
import keyboard.KeyCode;

@:access(keyboard.KeyBoardManager)
class TestKeyBoard extends utest.Test {
	var KB:keyboard.KeyBoardManager;

	public function setup() {
		KB = keyboard.KeyBoardManager.getInstance();
		var note = new keyboard.KeyNote();
		// J(doc).on("keydown",fun);
		// simulateKeyPress("n".code);
	}

	public function teardown(){
		trace( "restart");
		KB.removeAll();
		trace( Lambda.count(KB.listeners));
	}

	public function testOne()
		Assert.isTrue(1 == 1);

	// public function testJquery(){
	// 	var body=J(doc.body);
	// 	Assert.is(body,js.html.BodyElement);
	// }


	// je mets ce test au debut sinin tous les tests repondent au signal
/*
@:timeout(250)
	function testSignal(async:utest.Async) {
		
		KB.addListener(S, () -> {
			Assert.isTrue(true);
			async.done();			
		});

		KB.signal.handle(function(s) {
			
			Assert.equals("S", String.fromCharCode(Std.parseInt(s)));
			//async.done();
			return true;
		});

		createEvent(S);
	
	}
	*/
	function testSomething(async:utest.Async) {
		// do your async goodness and remember to call `done()` at the end.
		JQ(doc).on("keydown", function(e) {
			Assert.equals(P, e.which); // put a sensible test here
			async.done();
		});
		simulateKeyPress(P);
	}

	@:timeout(250)
	function testKB(async:utest.Async) {
		KB.addListener(P, (k) -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		});

		createEvent(P);
	}
	

	@:timeout(250)
	function testKB2(async:utest.Async) {
		
		KB.addListener(R, (?k) -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		});
	
		createEvent(R);
		
	}

	

	public static function simulateKeyPress(character:keyboard.KeyCode) {
		var e = new js.jquery.Event('keydown');
		e.which = character;
		JQ(doc).trigger(e);
	}

	public static function createEvent(kc:KeyCode) {
		trace("createEvent  " + kc);
		var event = new js.html.KeyboardEvent("keyup", {keyCode: kc});
		doc.dispatchEvent(event);
	}
}
