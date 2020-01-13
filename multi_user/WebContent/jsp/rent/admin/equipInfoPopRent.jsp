<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

	<table id="listTable">
	<colgroup>
		 <col style="width:5%">
		 <col style="width:20%">
		 <col style="width:10%">
		 <col style="width:20%">
		 <col style="width:10%">
		 <col style="width:20%">
		 <col style="width:15%">
	</colgroup>
	<thead>
		<tr>
		<th>번호</th>
		<th>부서</th>
		<th>신청자</th>
		<th>부서</th>
		<th>사용자</th>
		<th>대여기간</th>
		<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${rentUserList}" var="rentUserList" varStatus="status">
		<tr onclick="goRecView('${rentUserList.APPNO}')" style="cursor:pointer;">
			<td>${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
			<td>${rentUserList.APPSS}</td>
			<td>${rentUserList.APPENM }</td>
			<td>${rentUserList.DEPT1NM}</td>
			<td>${rentUserList.APPUENM}</td>
			<td>${rentUserList.STRDT} ~ ${rentUserList.ENDDT}</td>
			<td>
				<c:choose>
					<c:when test="${rentUserList.STATUS eq 3 }">대여예정</c:when>
					<c:when test="${rentUserList.STATUS eq 4 }">대여중</c:when>
					<c:when test="${rentUserList.STATUS eq 6 }">반납완료</c:when>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
	</tbody>
    </table>
<c:import url="/resource/common/include/paging.jsp" />

<script type="text/javascript">
	function goRecView(val){
		var popWin = window.open('about:blank', 'rent_Detail', 'scrollbars=1, resizable=1');
		
		popWin.location.href = "/admin/recView.do?appno="+val+"&rfid_empno=";
	}
</script>

