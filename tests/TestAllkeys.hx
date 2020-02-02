import utest.Assert;
import utest.Async;
import js.jquery.Helper.J as JQ;
import js.Browser.document as doc;
import keyboard.KeyCode;

class TestAllKeys extends utest.Test{

	var KB:keyboard.KeyBoardManager;
	public function setup(){
		KB= keyboard.KeyBoardManager.getInstance();
		var note= new keyboard.KeyNote();
		//J(doc).on("keydown",fun);
		//simulateKeyPress("n".code);
    }
    
    @:timeout(250)
    public function testAllKeys(async:utest.Async){
        KB.addListener(AllKeys,function(){
            trace( "popopo");
            Assert.isTrue(1==1);
            async.done();
        });
        TestKeyBoard.createEvent(L);
    }
}