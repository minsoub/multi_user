<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@page import="kr.co.neodreams.multi_user.controller.CommonController"%>
<%@page import="kr.co.neodreams.multi_user.common.StringUtil"%>
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
				<c:param name="left_depth_1" value="6"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub6_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;맞춤형 디스플레이&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">일정관리</b>
				</div>
				<div class="nav-title">일정관리</div>
			</div>
			<c:if test="${success == 'Y' }">
				<iframe src="http://<%= Constants.custom_displayWebUrlPage %>?empno=${empno}&region=${region}" class="schedule_zoom_iframe" width="1024px;" height="900px;" scrolling="no" style="border: 0;"></iframe>
			</c:if>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('6', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />