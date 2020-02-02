import utest.Assert;
import utest.Async;
import js.jquery.Helper.J as JQ;
import js.Browser.document as doc;
import keyboard.KeyCode;

@:access(keyboard.KeyBoardManager)
class TestModifier extends utest.Test {
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
	// function testSomething(async:utest.Async) {
	// 	// do your async goodness and remember to call `done()` at the end.
	// 	JQ(doc).on("keydown", function(e) {
	// 		Assert.equals(P, e.which); // put a sensible test here
	// 		async.done();
	// 	});
	// 	simulateKeyPress(P);
	// }

	@:timeout(250)
	function testAltKey(async:utest.Async) {
		KB.addListener(P,() -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		},Mod.Alt);

		createEvent(P,Mod.Alt);
   }
   
   @:timeout(300)
	function testControl(async:utest.Async) {	
		KB.addListener(R,() -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		},Mod.Control);
		createEvent(R,Mod.Control);
		
   }
   
   @:timeout(400)
	function testMeta(async:utest.Async) {	
		KB.addListener(R,() -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		},Mod.Meta);
		createEvent(R,Mod.Meta);
		
	}
	

	@:timeout(600)
	function testShift(async:utest.Async) {	
		KB.addListener(R,() -> {
			Assert.isTrue(true); // put a sensible test here
			async.done();
		},Mod.Shift);
		createEvent(R,Mod.Shift);
		
	}

	

	public static function simulateKeyPress(character:keyboard.KeyCode) {
		var e = new js.jquery.Event('keydown');
		e.which = character;
		JQ(doc).trigger(e);
	}

	public static function createEvent(kc:KeyCode,?modifier:Mod) {
     var altKey=false;
     var shiftKey=false;
     var ctrlKey=false;
     var metaKey=false;
     trace(modifier);
     switch(modifier){
         case Alt:altKey=true;
         case Shift:shiftKey=true;
         case Meta:metaKey=true;
         case Control:ctrlKey=true;
         case null:
     }

		trace("createEvent  " + kc);
		var event = new js.html.KeyboardEvent("keyup", {keyCode : kc, altKey:altKey,metaKey:metaKey,ctrlKey:ctrlKey,shiftKey:shiftKey});
      trace(event.ctrlKey);
      doc.dispatchEvent(event);
	}
}
