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
				<c:param name="left_depth_1" value="3"></c:param>
				<c:param name="left_depth_2" value="5"></c:param>
				<c:param name="left_depth_3" value="5"></c:param>
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
				<div class="nav-title">설정관리</div>
			</div>
            <div class="sub-nav-title">모델관리</div>
            
            <%-- <div style="float: left">
                <ul class="equip" style="width:761px; display: block; margin-bottom: 5px;">
                    <c:forEach items="${codeList}" var="codeList" varStatus="x">
                            <li><a href="javascript:;" onclick="javascript:stanModelList('${codeList.GBCD}')" style="cursor: pointer;" ${gbcd == codeList.GBCD ? 'class="aHover"' : ''}>${codeList.GBNM}</a></li>
                    </c:forEach>
                </ul>
            </div> --%>
            
            <div class="basic-list2" style="width:941px;">
				<table id="listTable">
					<caption>대여가능수</caption>
					<thead>
						<tr>
							<c:forEach var="codeList" items="${codeList}" varStatus="x">
								<th ${gbcd == codeList.GBCD ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} scope="col" onclick="javascript:stanModelList('${codeList.GBCD}')" style="cursor: pointer;">${codeList.GBNM}</th>
							</c:forEach>                   					
						</tr>
					</thead>
				</table>
			</div>
            
            <form name="frm" action="/admin/stanModelList.do" method="get" onsubmit="return false;">
            <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}"/>
            <input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
            <div class="basic-list" style="margin-top:5px;">
				<table id="listTable" summary="">
					<caption>모델관리</caption>
					<colgroup>
						<col style="width:25%">
						<col style="width:25%">
						<col style="">
                        <col style="width:15%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">모델번호</th>
                            <th scope="col">모델명</th>
                            <th scope="col">특징(상세설명)</th>
                            <th scope="col">비고</th>                     					
						</tr>
					</thead>
					<tbody>
						<c:forEach var="stanModelList" items="${stanModelList}" varStatus="x">
							<tr onclick="javascript:window.location='/admin/stanModelRegist.do?gbcd=${gbcd}&mdseq=${stanModelList.MDSEQ}'" style="cursor: pointer;">
								<td>${stanModelList.MDNO}</td>
	                            <td>${stanModelList.MDNM}</td>
	                            <td>${fn:substring(stanModelList.MDTXT, 0, 25)}<c:if test="${fn:length(stanModelList.MDTXT) > 0}">..</c:if></td> 
	                            <td>${stanModelList.MDBG}</td>                     
							</tr>	
						</c:forEach>
						<c:if test="${fn:length(stanModelList) == 0}">
							<tr>
								<td align="center" colspan="4">등록된 데이터가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			
			<c:import url="/resource/common/include/paging.jsp" />
			
            <div class="btn-zone" style="float:left">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/adminList.do'" value="관리자등록" style="width:80px;"></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/code.do'" value="코드관리" style="width:80px;"></li>
                </ul>
            </div>
            <div class="btn-zone">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/stanModelRegist.do?gbcd=${gbcd}'" value="등록" ></li>
                </ul>
            </div>
			</form>
	
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}
	
});

function stanModelList(code){
	var frm = document.frm;
	$("#gbcd").val(code);
	$("#pageNo").val("1");
	frm.submit();
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />