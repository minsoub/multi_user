<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="5"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub5_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;전력수급현황&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">내 사업소 현황</b>
				</div>
				<div class="nav-title">내 사업소 현황</div>
				<div class="nav_title_sub">전력수급현황이 등록되지 않은 사업소는 전국전력수급현황이 표출됩니다.</div>
			</div>
			<iframe id="ifr" src="${acc_url }" class="power_zoom_iframe" width="1024px;" height="768px;" style="border: 0;"></iframe>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('5', '0', '0'); //menu script
	
	setInterval(function(){
		document.getElementById("ifr").src = document.getElementById("ifr").src;	
	},20000);
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />