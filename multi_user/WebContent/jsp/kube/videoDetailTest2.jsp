<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Cache-Control" content="no-cache"/> 
		<meta http-equiv="Expires" content="0"/>
		<meta http-equiv="Pragma" content="no-cache"/>
        <title>GMPlayer Sample</title>
    <script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="/resource/common/kube_video/js/browser.js"></script>
    <script type="text/javascript">
		/*
		
			1. objDetectBrowser() - 브라우저 체크 함수
			2. GMPlayerCreationComplete() - 플레이어 로딩 함수
			3. GMPlayerConfig() - 플레이어 재상정보 전달 함수
			4. getCrossDomain() - 크로스도메인 리턴 함수 ( *크로스 도메인 설정 필수, 미설정시 정상적인 재생 불가 ) 
			5. object Tag의 GMPlayer.swf파일의 경로를 2군데 전부 설정해주어야 함

		*/

        var gmplayer = null; //플레이어 객체
		//var url = "rtmp://110.93.135.133/bbstv-live/livestream";
		//var url_high = "rtmp://1.234.22.185:1935/vod/mp4:E7420CF5C8F4465B88F642C2559C72CE.mp4";
		//var url_high = "rtmp://210.178.100.113:1935/Proxy2/dee7b88062ba0a947440ac95ecc7cfdc161a92bc07afb15681573cbe71fd614a6a69d8f1d290d411196a101c0b798f8238a7df25ece6558e76bd164f4662e8e4";
		
		var url_high = "<%= Constants.KUBE_UPLOAD_ASP_IP %>${fn:replace(videoInfo.pds_log_path, '.mp4', '_0.mp4')}"; // 영상 url
		var url = "<%= Constants.KUBE_UPLOAD_ASP_IP %>${videoInfo.pds_log_path}";
		
        $(function() {
            objDetectBrowser(); // 브라우져 버전 체크	
            
            $("#currentTime").click(function(){
            	var time = getCurrentTime();
            	console.log(time);
            });
            
            $("#setPlayTime").click(function(){
            	var p_time = $("#p_playTime").val();
            	setCurrentTime(p_time);
            });
        });

        // 플레이어 로딩 완료
        function GMPlayerCreationComplete() {
            if (browser != "IE") { // IE11 및 크롬, 사파리, 파이어 폭츠 
                gmplayer = $("embed[name=GMPlayer]").get(0);
				
				if(gmplayer == null || gmplayer == "undefined"){
				  gmplayer = document.getElementById("GMPlayer");
				}
		
            } else { // IE10 이하
                gmplayer = document.getElementById("GMPlayer");
            }

			gmplayer.GMPlayerInit();
        }

		function playTime(time, status){ // 재생시작, 일시정지, 정지  이벤트마다 플레이어에서 호출하는 함수 (return 값으로 현재 재생되고있는 영상의 플레이시간을 받음)
			//console.log("time : " + time);
			//console.log("status : " + status);
		}
		
		function getCurrentTime(){ // 현재 재생되고 있는 영상의 플레이 시간을 받는 함수(플레이어에 요청)
			var time = 0;
		
        	if(gmplayer != null && gmplayer != "undefined"){
        		time =  gmplayer.getPlayTime(); // 플레이어에 요청하는 함수
        	}
        	
        	return time;
        }
        
        function setCurrentTime(time){
        	if(gmplayer != null && gmplayer != "undefined"){
        		gmplayer.setPlayTime(time); // 영상 시작지점 설정
        	}
        }
        
        function playComplete(){
        	console.log("complete");
        	gmplayer.setPlayTime(0);
        }

        //플레이어 재생 정보 전달
        function GMPlayerConfig() {
			
            return{
				playURL : url, // 영상 url
				playURL_high : url_high,
				autoPlay : true,
				titleImage : '',
				playerWidth : '600',
				playerHeight : '400',
				smi : false,
				smiurl : '',
				isLogo : true,
				logoImage : '<%= Constants.WEB_URL %>/resource/common/kube_video2/image/logo.png',
				eduComplete : true, // seek바 이벤트 관련 (false : seek바 이동 X , true : seek바 이동 O)
				playTime : '27' // 이어보기 시간설정 ( 처음시작 : 0 )
            }
        }
        
        // 크로스 도메인 URL 정보 호출
        function getCrossDomain(){
        	return "http://192.168.100.140:8091/crossdomain.xml";
        }
        
    </script> 
    </head>
    <body>
        <div id="test" style="width:600px; height:400px;">
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"
                    id="GMPlayer"
                    codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
                <param name="movie" value="GMPlayer.swf" /> <!-- 플레이어 swf  경로 설정 -->
                <param name="quality" value="high" />
                <param name="bgcolor" value="#869ca7" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="wmode" value="opaque" />
                <param name="allowFullScreen" value="true" />
                <!-- 플레이어 swf  경로 설정 -->
                <embed src="/resource/common/kube_video/GMPlayer.swf" quality="high" bgcolor="#869ca7" 
                       width="100%" height="100%" name="GMPlayer" align="middle"
                       play="true"
                       loop="false"
                       quality="high"
                       wmode ="opaque"
                       allowScriptAccess="sameDomain"
                       allowFullScreen ="true"
                       type="application/x-shockwave-flash"
                       pluginspage="http://www.adobe.com/go/getflashplayer" >
                </embed>
            </object>
        </div>
        
        <input type="button" id="currentTime" value="영상 시간 가져오기" /><br/>
        <input type="text" id="p_playTime" /><input type="button" id="setPlayTime" value="재생시점설정" />
    </body>
</html>