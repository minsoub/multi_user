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

#listTable tr:hover{
	color : #4c7ab7;
}

</style>
<body>
	<div class="topMenu-bg-img-sub"></div>
	<c:import url="/resource/common/include/topMenu.jsp" />
	<c:set value="2" var="left_depth_1"/>
	<div id="contents" class="learn-frame-area">
		<div class="contents-framebox" id="contents_id">
			<!-- leftmenu -->
			<%-- <div class="contents-header-framebox">
				<div class="learn-tit-framebox">
					<c:import url="/resource/common/include/leftMenu_01.jsp">
						<c:param name="left_depth_1" value="8"></c:param>
						<c:param name="left_depth_2" value="5"></c:param>
						<c:param name="left_depth_3" value="10"></c:param>
					</c:import>
				</div>
			</div> --%>
			<!-- leftmenu end-->
			
			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">자료실</b>
					</div>
					<div class="nav-title">EP Log</div>
				</div>
				<div class="sub-nav-title">EP Log</div>
				<form id="frm" name="frm" method="post">
					<input type="hidden" name="ep_LogSeq" id="ep_LogSeq" value="0" />
					<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }" />
					<div class="searchArea_con">
						<fieldset>
							<div class="search-box">
								<div class="form-group">
									<legend>검색영역</legend>
									<div>
										
									</div>
									<%-- <input type="text" name="searchText" placeholder="제목, 작성자, 내용, 등록일" value="${paging.searchText }" onkeydown="if(event.keyCode==13){ goList(); event.returnValue=false; }" style="width:180px;height:15px;margin-left: 8px;font-size:12px;color:#666;">
									<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:goList();" value="검색"> --%>
								</div>
							</div>
						</fieldset>
					</div>
				</form>
				<div class="basic-list2" style="margin-top:5px;">
					<table id="listTable">
						<caption>EP Log 목록</caption>
						<colgroup>
							<col style="width:10%">
							<col style="width:10%">
							<col style="width:30%">
							<col style="width:30%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">결재구분</th>
								<th scope="col">결재문서</th>
								<th scope="col">결재자/기안자</th>
								<th scope="col">전송일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${resultSet }" varStatus="status">
								<tr onclick="goDetail(${item.ep_LogSeq})" style="cursor: pointer;">
									<td>${totalCnt - (paging.pageStartNo + status.count) +1}</td>
									<td>${item.ep_SignType }</td>
									<td>${item.ep_DocData }</td>
									<td style="text-align: left;padding-left:10px;">${item.ep_DocApprover }</td>
									<td>${item.ep_SendDate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="basic-list2">
					<c:import url="/resource/common/include/paging.jsp" />
					<div class="btn-zone">
						<ul>
							<li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/noticeWrite.do';" value="등록"></li>
						</ul>
					</div>
				</div>
			</div>
			<!--content end-->
		</div>
	</div>
</body>
<script type="text/javascript">
	function goDetail(val){
		$('#ep_LogSeq').val(val);
		$('#frm').attr('action', '/admin/epLogDetail.do');
		$('#frm').submit()
	}
	
	function goList(val){
		$('#pageNo').val(val);
		$('#frm').attr('action', '/admin/noticeList.do');
		$('#frm').submit()
	}
</script>
<c:import url="/resource/common/include/bottom.jsp" />