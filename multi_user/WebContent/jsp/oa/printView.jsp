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
<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
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
						<c:param name="left_depth_1" value="${menu_depth1}"></c:param>
						<c:param name="left_depth_2" value="${menu_depth2}"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub2_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;${title}&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행사항</b>
					</div>
					<div class="nav-title">${title} <small class="sub2">상세내역</small></div>
				</div>

				<ul class="tabNav sub2">
					<li><a href="javascript:goWrite();">출력요청</a></li>
					<li><a href="javascript:goList();" class="active">진행사항</a></li>
				</ul>	
	
				<div class="sub-nav-title">출력요청 상세보기</div>
				<div class="red-f">* 출력물은 종이만 가능합니다.</div>
					
				<div class="basic-list">
					<div class="insrtfrom-framebox">
						<div class="insert-step1-box">
							<div class="form-step1">
							<fieldset>
								<legend>${title}</legend>
								<div class="row-group">
									<form id="frm" name="frm" method="post">
									   <input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
										<input type="hidden" id="seq" name="seq" value="${boardInfo.seq }">
										<input type="hidden" id="freq" name="freq" value="${boardInfo.freq }">
										<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }" />
										<input type="hidden" id="sts1" name="sts1" value="${paging.sts1 }" />
										<input type="hidden" id="sts2" name="sts2" value="${paging.sts2 }" />
										<input type="hidden" id="sts3" name="sts3" value="${paging.sts3 }" />
										<input type="hidden" id="sts4" name="sts4" value="${paging.sts4 }" />
										<input type="hidden" id="sts5" name="sts5" value="${paging.sts5 }" />
										<input type="hidden" id="searchString" name="searchString" value="${paging.searchString }" />
										<input type="hidden" id="searchFromDt" name="searchFromDt" value="${paging.searchFromDt }" />
										<input type="hidden" id="searchToDt"   name="searchToDt"   value="${paging.searchToDt }" />
										<input type="hidden" id="req_type"   name="req_type"   value="${paging.req_type }" />
										
										<dl class="insert_ready">
											<dt class="must-option"><label>신청번호</label></dt>
											<dd style="width: 203px;">${boardInfo.seq}</dd>
											<dt class="must-option"><label>완료일</label></dt>
											<dd style="width: 250px;">${boardInfo.aprv_dt}</dd>
										</dl>
																				
											<dl class="insert_ready">
												<dt class="must-option"><label>신청부서</label></dt>
												<dd style="width: 150px;">${boardInfo.reg_dept_nm}</dd>
												<dt class="must-option"><label>신청자</label></dt>
												<dd style="width: 150px;">${boardInfo.reg_nm}</dd>
											</dl>																					
											<dl class="insert_ready">
												<dt class="must-option"><label>전화번호</label></dt>
												<dd style="width: 150px;">${boardInfo.reg_tel}</dd>

												<dt class="must-option"><label>E-MAIL</label></dt>
												<dd style="width: 150px;">${boardInfo.reg_email}</dd>
											</dl>	
											
											<dl class="insert_ready">
												<dt class="must-option"><label>출력요청일</label></dt>
												<dd style="width:150px;">${boardInfo.prt_req_dt}</dd>
												<dt class="must-option"><label>희망 요청완료일</label></dt>
												<dd style="width:150px;">${boardInfo.want_req_dt}</dd>
											</dl>	
											
																					
											<dl class="insert_ready">
												<dt class="must-option"><label>제목</label></dt>
												<dd style="width: 300px;">${boardInfo.subject}</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>출력종류</label></dt>
												<dd style="width: 150px;">${boardInfo.req_type_nm}</dd>
												<dt class="must-option"><label>출력부수</label></dt>
												<dd style="width: 150px;">${boardInfo.prt_cnt}</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>규격</label></dt>
												<dd style="width: 420px;">${boardInfo.prt_size_nm}  
												   가로 ${boardInfo.prt_size1} cm 
												   세로 ${boardInfo.prt_size2} cm
												</dd>												
											</dl>																					
																																
											<dl class="insert_ready">
												<dt class="must-option"><label>요청사항</label></dt>
												<dd>
													<c:if test="${isGetAdmin != null or SESS_EMPNO eq boardInfo.reg_id}">
														<pre style="white-space: pre-line;word-wrap: break-word;">${boardInfo.content}</pre>
													</c:if>
												</dd>
											</dl>										
										
											<dl class="insert_ready">
												<dt class="must-option"><label>상태</label></dt>
												<dd style="width: 300px;">${boardInfo.aprv_status_nm}</dd>
											</dl>
																					
									</form>
									<dl class="insert_ready" id="attatchArea">
										<dt class="must-option"><label>첨부파일</label></dt>
										<dd style="width:97%">
											<div style="position: relative;">
											<c:if test="${isGetAdmin != null or SESS_EMPNO eq boardInfo.reg_id}">
												<c:if test="${fn:length(boardInfo.attachList) > 0}">
													<c:forEach var="item" items="${boardInfo.attachList }" varStatus="status">
													<div>
														<a href="javascript:void(0);return false;" onclick="goDown('${item.freq}')">${item.filename }</a>
													</div>
													</c:forEach>
												</c:if>
											</c:if>	
											</div>
										</dd>
									</dl>
								</div>
								<div class="btn-zone">
									<ul>
									<!-- 내가 쓴글 또는 관리자인 경우 -->
									<c:if test="${isGetAdmin != null or SESS_EMPNO eq boardInfo.reg_id}">
										<li><input type="submit" class="search_btn" value="수정" onclick="goUpdate(); return false;"></li>									
										<li><input type="submit" class="search_btn" value="신청취소" onclick="goDelete(); return false;"></li>
									</c:if>
									<c:if test="${isGetAdmin != null}">
										<li><input type="submit" class="search_btn" value="접수완료" onclick="goApply('Y'); return false;"></li>									
										<li><input type="submit" class="search_btn" value="완료저장" onclick="goApply('A'); return false;"></li>									
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
function goUpdate(){
	$('#frm').attr('action', '/printUpdate.do');
	$('#frm').submit();
}

function goDelete(){
	var params = {
			"seq" : $('#seq').val(),
			"bbsid" : $('#bbsid').val(),
			"aprv_status" : "C",
			"freq" : 0
	}	
	if(confirm('신청취소 하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/deletePrint.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result >= 0){
					alert('신청취소 되었습니다.');
					goList();
				}
			},
			error : function(e){
			}
		})
	}
}
function goApply(aprv_status) {	
	var params = {
			"seq" : $('#seq').val(),
			"bbsid" : $('#bbsid').val(),
			"aprv_status" : aprv_status,
			"freq" : 0
	}	
	var title = "";
	if (aprv_status == "Y") title = "접수완료 하시겠습니까?";
	if (aprv_status == "A") title = "완료저장 하시겠습니까?";
	
	if(confirm(title)){
		$.ajax({
			type : 'post',
			url : '/printStsUpdate.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result >= 0){
					alert('상태 저장 완료되었습니다.');
					goList();
				}
			},
			error : function(e){
			}
		})
	}	
}

function goDown(val){
	$('#freq').val(val);
	$('#frm').attr('action', '<%=Constants.COMMON_DOWNLOAD_ASP_CALL %>');
	$('#frm').submit();
}

function goList(){
	$('#frm').attr('action', '/printlist.do');
	$('#frm').submit();
}

function goWrite(){
	$('#frm').attr('action', '/printWrite.do');
	$('#frm').submit();	
}


</script>
<c:import url="/resource/common/include/bottom.jsp" />