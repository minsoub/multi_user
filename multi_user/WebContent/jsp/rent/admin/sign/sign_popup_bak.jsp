<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<% response.setHeader("X-UA-Compatible", "IE=Edge"); %>
<!DOCTYPE html>
<html>
<head>
<!-- this, preferably, goes inside head element: -->
<!--[if lt IE 9]>
<script type="text/javascript" src="flashcanvas.js"></script>
<![endif]-->
<title>사용자용 팝업</title>
</head>
<body>
<div>
<div style="float: left;">Sign</div>
<div id="signature" style="border:2px solid #4d6aa6;width:80%;height:30%;margin-top: 50%;margin-left: 8%;"></div>
</div>       
<a href="javascript:;" onclick="javascript:sendSignImgData();" style="text-align: right;">확인</a>
<script src="/resource/common/js/jquery-1.9.1.js"></script>
<script>
/*  @preserve
jQuery pub/sub plugin by Peter Higgins (dante@dojotoolkit.org)
Loosely based on Dojo publish/subscribe API, limited in scope. Rewritten blindly.
Original is (c) Dojo Foundation 2004-2010. Released under either AFL or new BSD, see:
http://dojofoundation.org/license for more information.
*/
(function($) {
	var topics = {};
	$.publish = function(topic, args) {
	    if (topics[topic]) {
	        var currentTopic = topics[topic],
	        args = args || {};
	
	        for (var i = 0, j = currentTopic.length; i < j; i++) {
	            currentTopic[i].call($, args);
	        }
	    }
	};
	$.subscribe = function(topic, callback) {
	    if (!topics[topic]) {
	        topics[topic] = [];
	    }
	    topics[topic].push(callback);
	    return {
	        "topic": topic,
	        "callback": callback
	    };
	};
	$.unsubscribe = function(handle) {
	    var topic = handle.topic;
	    if (topics[topic]) {
	        var currentTopic = topics[topic];
	
	        for (var i = 0, j = currentTopic.length; i < j; i++) {
	            if (currentTopic[i] === handle.callback) {
	                currentTopic.splice(i, 1);
	            }
	        }
	    }
	};  
})(jQuery);

</script>
<script src="/resource/common/js/jSignature.js"></script>
<script>
	var $sigdiv;       
	
    $(document).ready(function() {
    	$sigdiv = $("#signature").jSignature()
    });
    
    function sendSignImgData(){
    	opener.signImageSync($sigdiv.jSignature('getData', 'default'));
    }
</script>		
</body>
</html> 