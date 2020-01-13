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
				<c:param name="left_depth_1" value="11"></c:param>
				<c:param name="left_depth_2" value="2"></c:param>
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
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;미세먼지 현황&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">사업소별 현황 (1024 * 768)</b>
				</div>
				<div class="nav-title">사업소별 현황 (1024 * 768)</div>
				<div class="nav_title_sub">사업소를 선택하시면 해당 사업소의 미세먼지 현황을 확인할 수 있습니다.</div>
			</div>
		
			<div class="businessList">
				<c:forEach var="item" items="${locationGroup}" varStatus="status">
					${status.index % 4 == 0 ? '<ul style=\'margin-top: 10px;\'>' : ''}
						<li onclick="javascript:window.open('http://<%= Constants.callDustWebUrl %>${item.url}','_duststatus', 'width=1024,height=768')" style="cursor: pointer;">
							${item.name }
						</li>
					${status.index % 4 == 3 ? '</ul>' : ''}
				</c:forEach>
			</div>
		<!--content end-->
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('5', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />