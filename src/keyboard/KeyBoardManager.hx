package keyboard;
import keyboard.KeyCode;
using tink.CoreApi;

import js.html.KeyboardEvent;

typedef Funk= Void->Void;

@:forward("split")
abstract ModKeyString(String) from String to String {

    @:from
    public static function toString(m:ModKey):ModKeyString{
        return '${m.key}--${m.mod}';
    }

    @:to
    public static function fromString(m:ModKeyString):ModKey{
         var splited=m.split("--");
         return cast {key:cast Std.parseInt(splited[0]),mod: cast Std.parseInt(splited[1])}
    }

}

class KeyBoardManager{

 var listeners:Map<ModKeyString,Funk>= new Map();
 var listenersOnce:Map<ModKeyString,Funk>= new Map();

 public var enabled:Bool=true;
 public static var signal:Signal<String>;
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
public function addListener(key:KeyCode,func:Funk,?mod:Mod):KeyBoardManager{
    var touch:ModKey={key:key, mod:null};
    if( mod!=null)
        touch.mod=mod;
    
    listeners.set(touch,func);
    listen();
    trace(listeners);
    return this;
}
public function addOnce(key:KeyCode,func:Funk,?mod:Mod):KeyBoardManager{
    var touch:ModKey={key:key};
    if( mod!=null)
        touch.mod=mod;
    listenersOnce.set(touch,func);
    listenOnce();
    return this;
}


public function addListenerOut(key:KeyCode,func:Funk,forkey:KeyCode){
    throw 'not implmented yed';
}

public function removeListener(?touch:ModKey,?func:Funk){
    removeInMap(listeners,touch,func);
    listen();
}

public function removeAll(){
    for( n in listeners.keys())
    removeListener(n);
    restart();
}



function getModifier(e:KeyboardEvent):ModKey{

    var code:KeyCode = e.keyCode;
    if( !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey )
        return {key:code,mod:null};
    if(e.altKey)
        return {key:code,mod:Mod.Alt};
    if(e.ctrlKey)
        return {key:code,mod:Mod.Control};
    if(e.metaKey)
        return {key:code,mod:Mod.Meta};
    if(e.shiftKey)
        return {key:code,mod:Mod.Shift};
   
    //default
    return {key:code,mod:null}

}
var mok:js.html.KeyboardEvent->Void;
public function listen(){
    restart();
     mok=function(e:KeyboardEvent){
         trace("key code="+ e.keyCode);
            var ki:KeyCode = e.keyCode;
            if (ki==null || ki==0) throw "nope key";
            var code=getModifier(e);
            var caller=listeners.get(code);
            
            st.trigger(Std.string(code));
            var allkeys=listeners.get({key:KeyCode.AllKeys,mod:null});

            if( allkeys!=null){
                allkeys();//callAllkeys
            }
            if (caller!=null){
                trace( "called");
            caller();  // it's a call
            }
            
        }
    js.Browser.document.addEventListener("keyup",mok);
    
}
public function listenOnce(){
    restart();
     mok=function(e){
         trace("key code="+ e.keyCode);
         var ki:KeyCode = e.keyCode;
         if (ki==null || ki==0) throw "nope key";
         var code=getModifier(e);
            var caller=listenersOnce.get(code);
            st.trigger(Std.string(code));
            var allkeys=listenersOnce.get({key:KeyCode.AllKeys});
            if( allkeys!=null){
                allkeys();//callAllkeys
            }
            if (caller!=null){
            
            caller();  // it's a call
            caller=null;
            listenersOnce.remove(code);
            
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