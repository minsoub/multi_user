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
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용안내</b>
				</div>
				<div class="nav-title">이용안내</div>
			</div>
	
			<div class="basic-list">
<h2>목적</h2>
<pre>
<font style="font-family: NanumGothic;">
사내 중요 원시미디어 자료를 디지털화하여 정보자원 활용 극대화와 내부고객 만족실현 및 관련 업무 집중처리로 업무혼선 및 
중복 투자 방지
</font>
</pre>
<br/>
<h2>요청절차</h2>
<pre>
<font style="font-family: NanumGothic;">
컨텐츠 제작 요청된 사항은 담당부서의 검토를 통해 제작 가능 한 경우 접수하여 진행상황에 게시됩니다.
컨텐츠 제작은 접수순으로 제작되며, 진행 처리 상태를 웹에 게시됩니다.
컨텐츠 제작이 완료되면  인수인계서를 통하여 제작매체와 원시자료를 요청부서에 인계 합니다.
</font>
</pre>
<br/>			
				<img alt="" src="/resource/images/sub/sub2_img.png">
			</div>
		
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />