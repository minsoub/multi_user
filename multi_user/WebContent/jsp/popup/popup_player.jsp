<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/resource/common/css/basic.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/main.css" />

<title>Insert title here</title>
</head>
<body>

<div class="popup_player_box">
	<img alt="" src="/resource/images/palyer/player_bg.png">
	<div class="popup_player_sub">
		<ul id="popup_player_ul1">
			<li>동영상 시청소감</li>
			<li><img alt="" src="/resource/images/palyer/codec.png"></li>
		</ul>
		
		<div id="popup_player_scroll">
			<ul>
				<%for(int i=0;i< 10;i++){ %>
				<li>
					<ul>
						<li>EX099116</li>
						<li><img alt="" src="/resource/images/palyer/icon_01.png"></li>
						<li>잘 만들었네요 감성을 울리네요 한국전력 화이팅!!</li>
					</ul>
				</li>
				<%} %>
			</ul>
		</div>
		
		<div id="popup_player_write">
			<ul>
				<li><input class="player_id" type="text"/></li>
				<li>
					<input type="radio" class="player_radio" name="player_icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_01.png">
					<input type="radio" class="player_radio" name="player_icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_02.png">
					<input type="radio" class="player_radio" name="player_icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_03.png">
					<input type="radio" class="player_radio" name="player_icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_04.png">
				</li>
				<li><input class="player_comment" type="text"/></li>
				<li><img alt="" src="/resource/images/palyer/comment.png"></li>
			</ul>
		</div>
		
	</div>
</div>

</body>
</html>