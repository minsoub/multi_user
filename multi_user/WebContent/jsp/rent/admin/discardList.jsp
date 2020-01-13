<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
	.tabList:hover{background-color: lightblue; cursor: pointer;}
</style>
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="8"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
				<c:param name="left_depth_3" value="4"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
				</div>
				<div class="nav-title">장비현황-폐기목록</div>
			</div>
			<form id="frm" name="frm" method="post" onSubmit="return false;">
			<input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
			<input type="hidden" name="pageNo" id="pageNo"  value="1"/>
			</form>
            		
			<div class="basic-list2">
				<table id="listTable" summary="">
					<caption>탭정보</caption>
					<thead>
						<tr>
							<th scope="col" ${gbcd == 'all' ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} onclick="javascript:discardList('all')">전체</th>
							<c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col" ${gbcd == codeList.GBCD ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} onclick="javascript:discardList('${codeList.GBCD}')">${codeList.GBNM}</th>
							</c:forEach>
						</tr>
					</thead>
				</table>
			</div>
            		
			<div class="basic-list2" style="margin-top:5px;">
				<table id="listTable" summary="">
					<caption>대여가능수</caption>
					<colgroup>
						<col style="width:5%">
						<col style="width:8%">
						<col style="width:12%">
						<col style="width:15%">
						<col style="">
					</colgroup>
					<thead>
						<tr>
                       		<th scope="col">번호</th>
							<th scope="col">설비관리번호</th>
                            <th scope="col">설비고유번호</th>
                            <th scope="col">모델명</th>
                            <th scope="col">특징(상세설명)</th>                       					
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list}" varStatus="x">
						<tr>
                            <td>${list.no}</td>
							<td>${list.eqnm}</td>
                            <td>${list.eqsn}</td>
                            <td>${list.mdnm}</td>
                            <td>${list.eqdet}</td>                       
						</tr>
						</c:forEach>
						<c:if test="${fn:length(list) == 0}">
						<tr>
							<td align="center" colspan="5">등록된 데이터가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
            <div class="basic-list2">
            	<c:import url="/resource/common/include/paging.jsp" />
                <div class="btn-zone">
                    <ul>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/equipList.do';" value="장비현황목록"></li>
                    </ul>
                </div>
            </div>




		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
});

function discardList(code){
	var frm = document.frm;
	$("#gbcd").val(code);
	$("#pageNo").val("1");
	frm.submit();
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />