import utest.Assert;
import utest.Async;
import js.jquery.Helper.J as JQ;
import js.Browser.document as doc;
import keyboard.KeyCode;

class TestKeyBoard extends utest.Test{

	var KB:keyboard.KeyBoardManager;
	public function setup(){
		KB= keyboard.KeyBoardManager.getInstance();
		var note= new keyboard.KeyNote();
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
 	JQ(doc).on("keydown",function(e) {
    Assert.equals(P,e.which); // put a sensible test here
    async.done();
  	});
 	simulateKeyPress(P);
	}

	function testKB(async:utest.Async){
		KB.addListener(P ,()->{
			
			Assert.isTrue(true); // put a sensible test here
    		async.done();
		});
		
		createEvent(P);
	}

	function testSignal(async:utest.Async){
		KB.addListener(M,()->{
			Assert.isTrue(true);
			KB.signal.handle(function(s){
				Assert.equals("M",String.fromCharCode(Std.parseInt(s)));
				async.done();
				return true;
			});
			return true;
			
		});
		createEvent.bind(M);
	}


	function simulateKeyPress(character:keyboard.KeyCode) {
	var e = new js.jquery.Event('keydown');
  	 e.which=character;
	JQ(doc).trigger(e);
	}

	function createEvent(kc:KeyCode){
		trace( "createEvent" +kc);
		var event = new js.html.KeyboardEvent("keyup",{keyCode:kc});
		doc.dispatchEvent(event);
	}
}