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
				<c:param name="left_depth_1" value="9"></c:param>
			</c:import> 
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
				</div>
				<div class="nav-title">사용자 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6"><a href="javascript:;">영상 관리</a></li>
                    <li id="4" class="active"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post">
            <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	            <div class="sub-nav-title-sm" style="float:left">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>	
	            <div class="searchArea_con" style="float:right">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<legend>검색영역</legend>	 
							<input type="text" title="검색바" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword }" placeholder="사용자명, 부서" style="width: 180px;height:15px;margin-left: 8px;font-size:12px;color:#666;" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit2(location.href);}">
							<input type="button" style="cursor: pointer;" class="search_btn" value="검색" onclick="javascript:funFrmPagingSubmit2(location.href);" />
							<p class="inputDesign" style="display: inline-block; vertical-align: middle;margin-left: 10px;margin-right: -10px;">
							<select name="selOrder" style="width:130px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
								<option value="name asc" ${paging.selOrder == 'name asc' ? 'selected' : '' }>이름순</option>
								<option value="upload_cnt desc" ${paging.selOrder == 'upload_cnt desc' ? 'selected' : '' }>업로드순</option>
								<option value="download_cnt desc" ${paging.selOrder == 'download_cnt desc' ? 'selected' : '' }>다운로드순</option>
								<option value="comment_cnt desc" ${paging.selOrder == 'comment_cnt desc' ? 'selected' : '' }>댓글순</option>
							</select> 
						</div>
					</div>
					</fieldset>
				</div>
				
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 15%" class="no-td">
							<col style="">
							<col style="width: 15%">
							<col style="width: 15%">
							<col style="width: 15%">
							<col style="width: 15%" >
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td">사용자명</th>
								<th scope="col" class="like-td">부서</th>
								<th scope="col" class="like-td">직급</th>
	                            <th scope="col" class="like-td">영상업로드</th>
								<th scope="col" class="like-td">영상다운로드</th>
	                            <th scope="col" class="ref-td">댓글수</th>
							</tr>
						</thead>
						<tbody>		
							<c:forEach var="userList" items="${userList }" >				
								<tr>
									<td class="no-td">${userList.name }</td>
									<td class="like-td">${userList.dept_name1 }<br/>${userList.dept_name2 }</td>
		                            <td class="like-td">${userList.jikyee }</td>
									<td class="like-td"><fmt:formatNumber value="${userList.upload_cnt}" pattern="#,###,###,###" /></td>
									<td class="like-td"><fmt:formatNumber value="${userList.download_cnt}" pattern="#,###,###,###" /></td>
									<td class="like-td"><fmt:formatNumber value="${userList.comment_cnt}" pattern="#,###,###,###" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </form>
            <c:import url="/resource/common/include/kube_paging.jsp" />
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

$('.equip > li').click(function (){
	var menu = $(this).attr('id');
	var linkUrl = '/kubeMainMgmt.do';
	
	if(menu == 2){
    	linkUrl = '/kubeCategoryMgmt.do';
	}else if(menu == 3){
		linkUrl = '/kubeReportMgmt.do';
	}else if(menu == 4){
		linkUrl = '/kubeUserMgmt.do';
	}else if(menu == 5){
		linkUrl = '/kubeSaMgmt.do';
	}else if(menu == 6){
		linkUrl = '/kubeVideoMgmt.do';
	}
	
	goUrl(linkUrl);
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />