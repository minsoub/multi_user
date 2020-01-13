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
				<c:param name="left_depth_1" value="7"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub7_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;멀티미디어센터&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">공지사항</b>
				</div>
				<div class="nav-title">공지사항</div>
			</div>
			
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){funFrmPagingSubmit()}">
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			
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
											<dd style="width: 240px;"><c:out value="${noticeDetail.reg_Date }"></c:out></dd>
										</dl>
										
										<dl class="insert_ready3">
											<dt class="must-option"><label for="content" id="content_label">제작요청 내용</label></dt>
											<dd class="must-option2-dd"><pre style="white-space: pre-line;word-wrap: break-word;">${noticeDetail.content}</pre></dd>
										</dl>
									</div>
									<div class="btn-zone">
										<ul>
											<li><input type="button" name="srchDescription2" class="search_btn" style="cursor: pointer;" onclick="javascript:funGoPageDetail('/notice.do')" value="목록"></li>
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
	load_fnc('0', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />