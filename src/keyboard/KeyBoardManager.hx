package keyboard;
import keyboard.KeyCode;
using tink.CoreApi;


typedef Funk =KeyCode->Void;

class KeyBoardManager{

 var listeners:Map<KeyCode,Funk>= new Map();

 public var enabled:Bool=true;
 public var signal:Signal<String>;
 private var st:SignalTrigger<String>;
private function new(){

    st=Signal.trigger();
    signal=st.asSignal();
    
}
static var _instance:KeyBoardManager;
public static function getInstance():KeyBoardManager{
    if (_instance==null)
    _instance=new KeyBoardManager();
    return _instance;

}

public function muteListener(key,func){

}
public function wakeListener(key,func){

}
public function addListener(key:KeyCode,func:Funk){
   
    listeners.set(key,func);
    listen();
    trace(listeners);
}


public function addListenerOut(key:KeyCode,func:Funk,forkey:KeyCode){
    throw 'not implmented yed';
}

public function removeListener(?key:KeyCode,?func:Funk){
    removeInMap(listeners,key,func);
    listen();
}

public function removeAll(){
    for( n in listeners.keys())
    removeListener(n);
    restart();
}

var mok:js.html.KeyboardEvent->Void;
public function listen(){
    restart();
     mok=function(e){
         trace("key code="+ e.keyCode);
            var code:KeyCode = e.keyCode;
            if (code==null || code==0) throw "nope key";
            var caller=listeners.get(code);
            st.trigger(Std.string(code));
            var allkeys=listeners.get(KeyCode.AllKeys);
            if( allkeys!=null){
                allkeys(code);//callAllkeys
            }
            if (caller!=null){

            
            caller(code);  // it's a call
            }
            
        }
    js.Browser.document.addEventListener("keyup",mok);
   
    
}

public function restart(){
    if( mok !=null)
    js.Browser.document.removeEventListener("keyup",mok);
}

static function removeInMap<V,T>(it:Map<V,T>,?key:V,?val:T):Map<V,T>{
        if (key !=null){
            it.remove(key);
            return it;
        }
        if(val != null)
            for ( a in it.keys())
                if( it.get(a) == val)
                removeInMap(it,a);
        
        return it;
        
    }
}