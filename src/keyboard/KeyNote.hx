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
		display("touched" + char,Simple);
		return true;
	}

	public function note(msg:String, noteType:NoteType){
		noteType=(noteType!=null)? noteType : Simple;
		display(msg,noteType);
	}
	function display(msg,noteType:NoteType){
		#if debug trace("display"); #end
		switch noteType{

			case Simple:
				displaySimple(msg);

			case Sticky:
				displaySticky(msg);

		}


		
		
	}

	function displaySimple(msg){

		removeLast();
		timed= new haxe.Timer(1000);
		
		createLayout();
		doc.body.appendChild(lay);
		updateMsg(msg);
	}

	function displaySticky(msg){

		//removeLast();
		
		if (!sticked)
		createLayout();
		updateMsg(msg);

		//timed.run=removeLast;

	}

	function updateMsg(msg){
		txt.innerHTML=msg;
	}

	static function createLayout(){
		lay= cast doc.createElement("div");
		lay.style.backgroundColor="#ddd";
		lay.style.position="absolute";
		lay.style.zIndex="999";
		lay.style.top=lay.style.right="0";
		lay.classList.add("note");
		txt= cast doc.createElement("p");
		lay.appendChild(txt);

		doc.body.appendChild(lay);
	} 
	static function removeLast(){
		if ( lay!=null)
		lay.remove();
		if( timed !=null){
		timed.stop();
		timed=null;
		}	
	}

}