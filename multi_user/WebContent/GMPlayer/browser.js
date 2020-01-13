
var browser = "";

function objDetectBrowser() {
    var strUA;    
    strUA = navigator.userAgent;   
    
    if(navigator.appName == 'Netscape' && strUA.indexOf("Trident/7.0") != -1){ // IE 10이상
        browser = "IE11";
    }else if(strUA.indexOf("MSIE") != -1){
        browser = "IE";
    }else if(strUA.indexOf("Chrome") != -1){
        browser = "Chrome";
    }else if(strUA.indexOf("Safari") != -1){
        browser = "Safari"
    }
}


