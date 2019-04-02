import utest.Assert;
import utest.Async;
import js.jquery.Helper.*;
import js.Browser.document as doc;
import interact.KeyCode as K;
class TestKeyBoard extends utest.Test{

	var KB:interact.KeyBoardManager;
	public function setup(){
		KB= interact.KeyBoardManager.getInstance();
		var note= new interact.Keynote();
		//J(doc).on("keydown",fun);
		//simulateKeyPress("n".code);
	}

	public function testOne()
		Assert.isTrue(1==1);

	// public function testJquery(){
	// 	var body=J(doc.body);
	// 	Assert.is(body,js.html.BodyElement);

	// }

	function testSomething(async:utest.Async) {
  // do your async goodness and remember to call `done()` at the end.
 	J(doc).on("keydown",function(e) {
    Assert.equals(K.P,e.which); // put a sensible test here
    async.done();
  	});
 	simulateKeyPress(K.P);
	}

	function testKB(async:utest.Async){
		KB.addListener(K.P ,()->{
			
			Assert.isTrue(true); // put a sensible test here
    		async.done();
		});
		
		createEvent(K.P);
	}

	function testSignal(async:utest.Async){
		KB.addListener(K.M,()->{
			Assert.isTrue(true);
			KB.signal.handle(function(s){
				Assert.equals("M",String.fromCharCode(Std.parseInt(s)));
				async.done();
				return true;
			});
			return true;
			
		});
		createEvent.bind(K.M);
	}


	function simulateKeyPress(character:interact.KeyCode) {
	var e = new js.jquery.Event('keydown');
  	 e.which=character;
	J(doc).trigger(e);
	}

	function createEvent(kc:K){
		trace( "createEvent" +kc);
		var event = new js.html.KeyboardEvent("keyup",{keyCode:kc});
		doc.dispatchEvent(event);
	}
}