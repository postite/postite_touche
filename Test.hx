import utest.Runner;
import utest.ui.Report;
import js.jquery.Helper.*;
import js.Browser.document as doc;
class Test {
	
	public function new() {
		trace("hello");
	}

	static public function main() {
		J(doc).ready(e->{
			trace( "yo");
		var runner = new Runner();
    	//runner.addCase(new TestKeyBoard());
    	runner.addCase(new TestAllKeys());
    	//runner.addCase(new TestCase2());
    	Report.create(runner);
    	runner.run();
    	});
    	
    	
  	//J("document").ready(doIt);
	}

	public static function doIt(e){
		J(doc).on("keydown",e->trace("olé"));
		simulateKeyPress("n".code);
		trace( "doIt");
		trace( J('document'));
	}
	 static function simulateKeyPress(character) {
   var e = new js.jquery.Event('keydown');
   e.which=character;
	J(doc).trigger(e);
	

}
}