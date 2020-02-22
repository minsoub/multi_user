<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<c:param name="left_depth_1" value="12"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub7_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;게시판&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">공지사항</b>
				</div>
				<div class="nav-title">공지사항</div>
			</div>
			
				<form id="frm" name="frm" method="post">
			    <input type="hidden" id="bbsid" name="bbsid" value="${noticeDetail.bbsid}" />
				<input type="hidden" id="num" name="num" value="${noticeDetail.num }">
				<input type="hidden" id="freq" name="freq" value="${noticeDetail.freq }">
				<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }" />
			
				<div class="basic-list">
					<div class="insrtfrom-framebox">
						<div class="insert-step1-box">
							<div class="form-step1">
								<fieldset>
								<legend>공지사항</legend>
									<div class="row-group">
										
										<dl class="insert_ready3">
											<dt class="must-option"><label for="subject" id="subject_label">제목</label></dt>
											<dd class="must-option2-dd"><c:out value="${noticeDetail.subject }"></c:out></dd>
										</dl>
										<dl class="insert_ready3">
											<dt class="must-option" style="width:15%;"><label for="writer" id="writer_label">등록자</label></dt>
											<dd style="width: 240px;"><c:out value="${noticeDetail.writer }"></c:out></dd>
											<dt class="must-option"><label for="reg_date" id="reg_date_label">등록일</label></dt>
											<dd style="width: 240px;"><c:out value="${noticeDetail.reg_date }"></c:out></dd>
										</dl>
										
										<dl class="insert_ready3">
											<dt class="must-option"><label for="content" id="content_label">내용</label></dt>
											<dd class="must-option2-dd">
												<div style="with:800pt; heigth:600px; table-layout:fixed; word-break:break-all;">
													<pre style="white-space: pre-line;word-wrap: break-word;">${noticeDetail.content}</pre>
												</div>	
											</dd>
										</dl>
										
									<dl class="insert_ready" id="attatchArea">
										<dt class="must-option"><label>첨부파일</label></dt>
										<dd style="width:97%">
											<div style="position: relative;">
												<c:if test="${fn:length(noticeDetail.attachList) > 0}">
													<c:forEach var="item" items="${noticeDetail.attachList }" varStatus="status">
													<div>
														<a href="javascript:void(0);return false;" onclick="goDown('${item.freq}')">${item.filename }</a>
													</div>
													</c:forEach>
												</c:if>
											</div>
										</dd>
									</dl>
																			
									</div>
									<div class="btn-zone">
										<ul>
										<c:if test="${isGetAdmin != null}">
											<li><input type="submit" class="search_btn" value="수정" onclick="goUpdate(); return false;"></li>
											<li><input type="submit" class="search_btn" value="삭제" onclick="goDelete(); return false;"></li>
										 </c:if>
											<li><input type="button" name="srchDescription2" class="search_btn" style="cursor: pointer;" onclick="javascript:goList();" value="목록"></li>
										</ul>
									</div>
								</fieldset>
							</div>
						</div>
					</div>
				</div>		
			</form>
				
			<c:import url="/resource/common/include/paging.jsp" />	
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('5', '0', '0'); //menu script
});

function goUpdate(){
	$('#frm').attr('action', '/memoModify.do');
	$('#frm').submit();
}
function goList(){
	$('#frm').attr('action', '/notice.do');
	$('#frm').submit();
}
function goDown(val){
	$('#freq').val(val);
	$('#frm').attr('action', '<%=Constants.COMMON_DOWNLOAD_ASP_CALL %>');
	$('#frm').submit();
}
function goDelete(){
	var params = {
		"num" : $('#num').val(),
		"bbsid" : $('#bbsid').val(),
		"freq" : '0'
	}
	
	if(confirm('삭제하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/deleteMemo.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result != '-1'){
					alert('삭제되었습니다.');
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
</script>
<c:import url="/resource/common/include/bottom.jsp" />