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
						<c:param name="left_depth_2" value="3"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스 요청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">업무 자료실</b>
					</div>
					<div class="nav-title">업무 자료실</div>
				</div>
				<div class="sub-nav-title">업무 자료실</div>

				<div class="basic-list">
					<div class="insrtfrom-framebox">
						<div class="insert-step1-box">
							<div class="form-step1">
							<fieldset>
								<legend>자료실</legend>
								<div class="row-group">
									<form id="frm" name="frm" method="post">
										<input type="hidden" id="notice_Seq" name="notice_Seq" value="${resultDetail.notice_Seq }">
										<input type="hidden" id="attatch_Seq" name="attatch_Seq" value="0" />
										<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }" />
										<dl class="insert_ready">
											<dt class="must-option"><label>업무</label></dt>
											<dd style="width: 200px;">
												<p class="inputDesign">
													${
														resultDetail.notice_Gbn eq 'P' ? 'PPT' :
														resultDetail.notice_Gbn eq 'I' ? '이미지' :
														resultDetail.notice_Gbn eq 'V' ? '영상' :
														resultDetail.notice_Gbn eq 'F' ? '플래시' : ''
													}
												</p>
											</dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label>작업명</label></dt>
											<dd style="width: 200px;">${resultDetail.notice_Title }</dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label>내용</label></dt>
											<dd>
												<textarea class="textarea-style" rows="10" cols="88" id="notice_Content" name="notice_Content" style="width: 618px;" readonly="readonly"><c:out value="${resultDetail.notice_Content}" escapeXml="false" /></textarea>
											</dd>
										</dl>
									</form>
									<dl class="insert_ready" id="attatchArea">
										<dt class="must-option"><label>첨부파일</label></dt>
										<dd style="width:97%">
											<div style="position: relative;">
												<c:if test="${fn:length(resultDetail.attatchList) > 0}">
													<c:forEach var="item" items="${resultDetail.attatchList }" varStatus="status">
													<div>
														<a href="javascript:void(0);return false;" onclick="goDown('${item.attatch_Seq}')">${item.attatch_OrgName }</a>
													</div>
													</c:forEach>
												</c:if>
											</div>
										</dd>
									</dl>
								</div>
								<div class="btn-zone">
									<ul>
										<li><input type="submit" class="search_btn" value="수정" onclick="goUpdate(); return false;"></li>
										<li><input type="submit" class="search_btn" value="삭제" onclick="goDelete(); return false;"></li>
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
	$('#frm').attr('action', '/admin/noticeUpdate.do');
	$('#frm').submit();
}

function goDelete(){
	var params = {
		"notice_Seq" : $('#notice_Seq').val(),
		"attatch_Seq" : 0
	}
	
	if(confirm('삭제하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/admin/removeNotice.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result >= 0){
					alert('삭제되었습니다.');
					location.href="/admin/noticeList.do"
				}
			},
			error : function(e){
			}
		})
	}
}

function goDown(val){
	$('#attatch_Seq').val(val);
	$('#frm').attr('action', '<%=Constants.MULTI_DOWNLOAD_ASP_CALL %>');
	$('#frm').submit();
}

function goList(){
	$('#frm').attr('action', '/admin/noticeList.do');
	$('#frm').submit();
}


</script>
<c:import url="/resource/common/include/bottom.jsp" />