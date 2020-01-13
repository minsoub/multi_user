<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="2" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="3"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub3_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;전광판게시&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용안내</b>
				</div>
				<div class="nav-title">이용안내</div>
			</div>
	
			<div class="basic-list">
<h2>게시신청</h2>
<pre>
<font style="font-family: NanumGothic;">
전광판 플래쉬 시간 : 최대 10초 이내
엘리베이터 플래쉬 시간 : 최대 10초 이내
엘리베이터 동영상 게시물(전체화면) 시간: 최대 30초 이내
게시시간은 최소 3일~ 최대 3개월까지 신청자가 요청하는 기간동안 가능합니다.
</font>
</pre>
<br/>
<h2>게시신청절차</h2>
<pre>
<font style="font-family: NanumGothic;">
전광판 및 엘리베이터 디스플레이 장치의 원활한 운영을 위하여 운영부서와 게시시간 조정 시
적극적인 협조를 부탁드립니다. 
</font>
</pre>
<br/>			
				<img alt="" src="/resource/images/sub/sub3_img.png">
			
			</div>
		
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('3', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />