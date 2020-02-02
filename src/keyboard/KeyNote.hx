package keyboard;

import js.html.*;
import js.Browser.document as doc;
using tink.CoreApi;
import keyboard.KeyCode;
enum NoteType{
	Simple;
	Sticky;
}

class KeyNote{
	static var lay:js.html.DivElement;
	static var txt:js.html.ParagraphElement;
	static var sticked:Bool=false;
	static var timed:haxe.Timer;
	public function new(){
		keyboard.KeyBoardManager.signal.handle(onTime);
	}

	function onTime(touch:String){
		//trace( "onTime");
		//var char=String.fromCharCode(touch.key);
		//char=(char !="" )? char : touch.key;
		//new postite.Note().notify("touched" + char,Simple);
		//display("touched" + char,Simple);
		return true;
	}

}