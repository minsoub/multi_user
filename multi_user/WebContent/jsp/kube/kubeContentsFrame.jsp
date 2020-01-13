<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
		<head>
			<title></title>
			<meta charset = "UTF-8">
			<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		  	<meta name="viewport" content="width=device-width, initial-scale=1">
			<link rel="stylesheet" href="/resource/common/kube_video/css/jquery-ui.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/video.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/control.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/menu.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/quiz.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/addfunc.css">
			<link rel="stylesheet" href="/resource/common/kube_video/css/track.css">

			<c:set var="subTitle" value="${fn:split(result.videoPath, '/')}" />
			<c:set var="subTitleName" value="${fn:replace(subTitle[fn:length(subTitle)-1], '.mp4' , '')}" />
			<c:set var="snakeImagePath" value="${fn:replace(result.videoPath, 'mp4' , 'jpg')}" />
			
			<link rel="stylesheet" href="<%= Constants.WEB_URL %>/kubeFnc/${subTitleName }/jumpup/css/jumpup.css">
			
			<meta name="apple-mobile-web-app-capable" content="yes" />
			<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		</head>
		<script>
		var gmPlayTime = ${result.playTime};
		var gmEduComplete = ${result.gmEduComplete};
		var videopath = '<%= Constants.KUBE_UPLOAD_ASP_IP %>${result.videoPath }';
		var thumbPath = '<%= Constants.KUBE_UPLOAD_ASP_IP %>${result.thumbPath }';
		var subTitlePath = '<%=Constants.WEB_URL %>/kubeFnc/${subTitleName}/vtt/${subTitleName}.vtt';
		var channel = '${result.channel}';
		var snakeImgPath = '<%= Constants.KUBE_UPLOAD_ASP_IP %>/${snakeImagePath}';
		</script>
		
		
	<body>
		<div class="contents" id="contents">
			<div class="mobile_play_btn">
				<img src="/resource/common/kube_video/image/control/mobile_play_btn.png" alt="">
			</div>
			<video class="video1" id="video1" playsinline="true" >
				<!-- <track label="korean" kind="subtitles" srclang="kr" src="./vtt/KA01_01.vtt" type="text/vtt" /> -->
			</video>
			<div class="controller">
				<div class="nextAlert"></div>
				<div class="scriptWrap">
					<span class="ScriptPart">
						<span class="teller"></span><span class="scriptTxt"></span>
					</span>
				</div>
				<div class="speedWrap">
					<div class="speedTitle">SPEED</div>
					<div class="speedLine"></div>
					<div class="speedPart speed1">0.8x</div>
					<div class="speedPart speed2 toggle">1.0x</div>
					<div class="speedPart speed3">1.2x</div>
					<div class="speedPart speed4">1.5x</div>
					<div class="speedPart speed5">2.0x</div>
				</div>
				<div class="qualityWrap">
					<div class="qualityTitle">QUALITY</div>
					<div class="qualityLine"></div>
					<div class="qualityPart qualityLow">저화질</div>
					<div class="qualityPart qualityHigh toggle">고화질</div>
				</div>
				<div class="titmeLineThumbnailWrap"><img class="titmeLineThumbnail" ><span class=" ThumbnailTime">00:00</span></div>
				<div class="timeLineWrap"><div class="timeLineProgress"></div><div class="timeLine"></div></div>
				<div class="left"><button class="button left playPause play"></button><div class="tooltips playTool">재생</div></div>
				<div class="left"><button class="button replay"></button><div class="tooltips">다시보기</div></div>
				<div class="left"><button class="button left sound"></button><div class="tooltips">소리</div></div>
				<div class="soundLineWrap"><div class="soundLineProgress"></div><div class="soundLine"></div></div>
				<div class="left timeBox"><span class="curTime">00:00</span><span class="slash">/</span><span class="totTime">00:00</span></div>
				<div class="right"><button class="button left fullscreen"></button><div class="tooltips fullTool">전체화면</div></div>
				<div class="right"><button class="button left setUp"></button><div class="tooltips">배속</div></div>
				<div class="right"><button class="button left script"></button><div class="tooltips">자막</div></div>
				<div class="right"><button class="button left quality"></button><div class="tooltips">화질변경</div></div>
				<div class="right"><button class="button left mobile_down"></button><div class="tooltips">영상다운</div></div>
			</div>
		</div>
		<script type="text/javascript" src="/resource/common/kube_video/js/jquery-1.12.3.min.js"></script>
		<script type="text/javascript" src="/resource/common/kube_video/js/jquery-ui.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/jquery.ui.touch-punch.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/jquery.ui.touch-punch.min.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/init/application.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/init/config.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/print.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/video.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/menu.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/quiz.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/audio.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/controller.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/button.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/scroll.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/script.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/init.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/popup.js"></script>
		<script language="javascript" src="/resource/common/kube_video/js/part/setAddfunc.js"></script>
		
		
		<script language="javascript" src="<%= Constants.WEB_URL %>/kubeFnc/${subTitleName }/jumpup/js/jumpup.js"></script>
	</body>
</html>