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
						<c:param name="left_depth_1" value="2"></c:param>
						<c:param name="left_depth_2" value="6"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">OA교육장</b>
					</div>
					<div class="nav-title">OA교육장</div>
				</div>
				<div class="sub-nav-title">OA교육장 이용신청 내역</div>

				<div class="basic-list">
					<div class="insrtfrom-framebox">
						<div class="insert-step1-box">
							<div class="form-step1">
							<fieldset>
								<legend>OA교육장 이용신청 내역</legend>
								<div class="row-group">
										<form id="frm" name="frm" method="post">
											<input type="hidden" id="date" name="date" value="${date}" />
											<dl class="insert_ready">
												<dt class="must-option"><label>직원번호</label></dt>
												<dd style="width: 200px;">${oaDto.sabun }</dd>
											</dl>											
											<dl class="insert_ready">
												<dt class="must-option"><label>성명</label></dt>
												<dd style="width: 200px;">${oaDto.user_name }</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>연락처</label></dt>
												<dd style="width: 200px;">${oaDto.user_tel }</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>이용시간</label></dt>
												<dd style="width: 500px;">${year}년 ${month}월 ${day}일 ${time}시 
													<strong style="letter-spacing:1px;">(<span id="hour_txt" style="color:red;">1</span><span style="color:#000;">시간 이용</span>)</strong>
												</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>이용목적</label></dt>
												<dd>${oaDto.subject}</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>인원</label></dt>
												<dd style="width: 200px;">${oaDto.people_cnt} 명</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>상태</label></dt>
												<dd style="width: 300px;">
													<c:if test="${oaDto.aprv_status eq 'A'}">승인</c:if>
													<c:if test="${oaDto.aprv_status eq 'D'}">거부</c:if>
													<c:if test="${oaDto.aprv_status eq 'R'}">대기</c:if>
												</dd>
											</dl>											
										</form>
								</div>
								<div class="btn-zone">
									<ul>
										<c:if test="${oaDto.sabun eq empno}">
											<li><input type="submit" class="search_btn" value="예약취소" onclick="goDelete(); return false;"></li>
										</c:if>
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
<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
});

function goDelete(){
	var params = {
		"rsrv_id" : "${oaDto.rsrv_id}",
		"aprv_status" : "C"
	}
	
	if(confirm('취소 하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/deleteOA.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result != "-1") {
					alert('취소 되었습니다.');
					goList();
				}else {
					alert("취소하는데 에러가 발생하였습니다!!!");
				}
			},
			error : function(e){
			}
		})
	}
}

function goList(){
	$('#frm').attr('action', '/oalist.do');
	$('#frm').submit();
}


</script>
<c:import url="/resource/common/include/bottom.jsp" />