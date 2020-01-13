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
				<c:param name="left_depth_1" value="9"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용안내</b>
				</div>
				<div class="nav-title">이용안내</div>
			</div>
                        
            <div class="basic-list">
                <div>
                    <h2>목적</h2>
                    <span>한전 본관 31층 에너지밸리 홍보시스템의 이용을 체계적인 예약시스템을 통해 중복예약을 방지하고,편리하게 이용하기 위한 시스템입니다.</span>                
                </div>
                <div style="margin-top:40px">
                    <h2>이용대상 및 이용시설</h2>
                    <span>한전 임직원 / 한전 본관 31층 에너지밸리 홍보시스템</span>                
                </div>
                <div style="margin-top:40px">
                    <h2>시스템 신청방법</h2>
                    <img alt="" src="/resource/images/sub/sub10_img.png" />         
                </div>
            </div>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('9', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />