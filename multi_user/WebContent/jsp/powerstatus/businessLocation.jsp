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
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;전력수급현황&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">사업소별 현황</b>
				</div>
				<div class="nav-title">사업소별 현황</div>
				<div class="nav_title_sub">사업소를 선택하시면 해당 사업소의 전력수급현황을 확인할 수 있습니다.</div>
			</div>
		
			<div class="businessList">
				<c:forEach var="item" items="${locationGroup}" varStatus="status">
					<c:if test="${status.index % 4 == 0}">
						<c:if test="${!status.first}">
							</ul>
						</c:if>
						<ul style="margin-bottom: 10px;">
					</c:if>
						
						<c:if test="${item.dept_code == '4600' }">
							<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/view/${item.url}.action?location=${item.location_code}', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;line-height: 25px;">
								<span style="position: absolute;padding: 13px 0px 0px 30px;">대전세종충남<br />본부</span>
							</li>
						</c:if>
						<c:if test="${item.dept_code != '4600' }">
							<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/view/${item.url}.action?location=${item.location_code}', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
							${item.name}
							</li>
						</c:if>
					<c:if test="${status.last}">
						</ul>
					</c:if>
				</c:forEach>
				<ul style="margin-top: 10px;">
					<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/conturyelecview/conturyelecview.action', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
					남서울본부
					</li>	
					<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/conturyelecview/conturyelecviewDeagu.action', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
					대구본부
					</li>	
					<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/conturyelecview/conturyelecviewGyungi.action', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
					경기본부
					</li>	
					<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/conturyelecview/conturyelecviewGyungbuk.action', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
					경북본부
					</li>
				</ul>
				<ul style="margin-top: 10px;">
					<li onclick="javascript:window.open('http://<%= Constants.callPowerWebUrl %>/conturyelecview/conturyelecviewGyungnam.action', '_powerstatus', 'width=1024,height=768')" style="cursor: pointer;">
					경남본부
					</li>
				</ul>
			</div>

		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('5', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />