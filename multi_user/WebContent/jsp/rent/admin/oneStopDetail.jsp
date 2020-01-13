<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
.btn_yellow {
	background-color: #ff9620;
	color: #fff;
	font-size: 14px;
}

.btn_blue {
	background-color: #08A0CE;
	color: #fff;
	font-size: 14px;
	padding: 0px 5px;
}
</style>
<body>
	<div class="topMenu-bg-img-sub"></div>
	<c:import url="/resource/common/include/topMenu.jsp" />
	<c:set value="2" var="left_depth_1"/>

	<c:set var="empno" value="${sessionScope.SESS_EMPNO }"/>
	<c:set var="userNm" value="${sessionScope.SESS_USER_NAME }"/>
	
	<c:set var="telno" value="${sessionScope.SESS_USER_INFO['telno'] }"/>
	<c:set var="mailno" value="${sessionScope.SESS_USER_INFO['mailno'] }"/>

	<div id="contents" class="learn-frame-area">
		<div class="contents-framebox" id="contents_id">
			<!-- leftmenu -->
			<div class="contents-header-framebox">
				<div class="learn-tit-framebox">
					<c:import url="/resource/common/include/leftMenu_01.jsp">
						<c:param name="left_depth_1" value="8"></c:param>
						<c:param name="left_depth_2" value="5"></c:param>
						<c:param name="left_depth_3" value="10"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">자료실</b>
					</div>
					<div class="nav-title">자료실</div>
				</div>
				<div class="sub-nav-title">자료실</div>

				<div class="basic-list">
					<div class="insrtfrom-framebox">
						<div class="insert-step1-box">
							<div class="form-step1">
							<fieldset>
								<legend>자료실</legend>
								<div class="row-group">
									<input type="hidden" id="ep_LogSeq" name="ep_LogSeq" value="${resultSet.ep_LogSeq }">
									<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }" />
									<dl class="insert_ready" style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>결재구분</label></dt>
										<dd style="width: 200px;">
											<p class="inputDesign">${resultSet.ep_SignType }</p>
										</dd>
									</dl>
									<dl class="insert_ready" style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>결재문서</label></dt>
										<dd style="width: 200px;">${resultSet.ep_DocData }</dd>
									</dl>
									<dl class="insert_ready" style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>결재자</label></dt>
										<dd>${resultSet.ep_DocApprover }</dd>
									</dl>
									<dl class="insert_ready"  style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>발신 데이타</label></dt>
										<dd style="width:97%"><c:out value="${resultSet.ep_SendData }"></c:out></dd>
									</dl>
									<dl class="insert_ready"  style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>수신 데이타</label></dt>
										<dd style="width:97%"><c:out value="${resultSet.ep_ReciveData }"></c:out></dd>
									</dl>
									<dl class="insert_ready"  style="table-layout:fixed;word-break:break-all;">
										<dt class="must-option"><label>발신일</label></dt>
										<dd style="width:97%"><c:out value="${resultSet.ep_SendDate }"></c:out></dd>
									</dl>
								</div>
								<div class="btn-zone">
									<ul>
										<li><input type="button" onclick="goList();" class="search_btn" value="목록"></li>
									</ul>
								</div>
							</fieldset>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--content end-->
		</div>
	</div>
</body>

<script type="text/javascript">

function goList(){
	$('#frm').attr('action', '/admin/epLogList.do');
	$('#frm').submit();
}


</script>
<c:import url="/resource/common/include/bottom.jsp" />