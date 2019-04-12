package keyboard;

import js.html.*;
import js.Browser.document as doc;
using tink.CoreApi;

enum NoteType{
	Simple;
	Sticky;
}

class Keynote{
	static var lay:js.html.DivElement;
	static var txt:js.html.ParagraphElement;
	static var sticked:Bool=false;
	static var timed:haxe.Timer;


	public function new(){
		keyboard.KeyBoardManager.getInstance().signal.handle(onTime);
	}

	function onTime(s:String){
		trace( "onTime");
		var char=String.fromCharCode(Std.parseInt(s));
		char=(char !="" )? char : s;
		new postite.Note().notify("touched" + char,Simple);
		//display("touched" + char,Simple);
		return true;
	}

}