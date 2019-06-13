package tablet;
#if js
import js.Browser.document;
#end

typedef PenApi={
    pointerType:String,
    pressure:Int,
    isEraser:Bool
}
class Tablet{

var plugin:Plugin;
 public function new () {
     #if js
     plugin = cast document.querySelector(
        'object[type=\'application/x-wacomtabletplugin\']');
    if (plugin ==null) {
        plugin = cast document.createElement('object');
        plugin.type = 'application/x-wacomtabletplugin';
        plugin.style.position = 'absolute';
        plugin.style.top = '-1000px';
        document.body.appendChild(plugin);
    }
    #end
    
}

public static function supported():Bool{
    #if js
   if (  untyped(window.PointerEvent) !=null) return true;
   return false;
    #end
    return false;
}



public function pen(){

    return this.plugin.penAPI;
}
public function pressure(){
    var pen = this.plugin.penAPI;
    return (pen!=null && pen.pointerType!=null) ? pen.pressure : 1;
}
public function isEraser():Bool{
    var pen = this.plugin.penAPI;
    return (pen!=null) ? pen.isEraser : false;
}

}

class Plugin extends js.html.Element{
    public var type:String;
    public var penAPI:PenApi;
}