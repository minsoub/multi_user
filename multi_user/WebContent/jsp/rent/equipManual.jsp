<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="8"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용안내</b>
				</div>
				<div class="nav-title">이용안내</div>
			</div>
	
			<div class="basic-list">
<h2>대여기준</h2>
<pre>
<font style="font-family:NanumGothic;">개인 용도 지급 금지 원칙  /  대여 설비 분실시 대여자 책임 보상  /  장기 대여(1개월 이상)시 내부 결재</font>                 
</pre>
<br/>

<h2>대여 목록(노트북 등 9개 설비)</h2>
<pre>
<img alt="" src="/resource/images/sub/sub8_img1.png" />                
</pre>
<br/>

<h2>대여 신청방법</h2>
<pre>
<font style="font-family:NanumGothic;">본관 3층 멀티미디어 센터
ICT 인프라처 IT 서비스 부 061-6266  /  멀티미디어 센터 061-6383</font>                                    
</pre>
<br/>
<img alt="" src="/resource/images/sub/sub8_img2.png" />
			</div>
		
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />