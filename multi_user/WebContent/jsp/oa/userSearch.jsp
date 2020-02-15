<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
    .tabList:hover{background-color: lightblue; cursor: pointer;}
</style>
<body>

            <div class="sub-nav-title" style="margin-top: 20px;">사용자 검색</div>

            <div class="basic-list">
            <form id="frm" name="frm" action="/commonUserSearch.do" method="post">
            <input type="hidden" name="seq" value="0">
                <%-- 조회용 --%>
				<div class="search-box mt0">
					<div class="form-group">
						<legend>검색영역</legend>
						<div>
							<input type="text" name="searchString" id="searchString"  style="width:120px;height:15px;margin-left: 7px;font-size:12px;color:#666;">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:btnSearFrm();" value="검색">
						</div>
					</div>				
				</div>
                <%-- 조회용 --%>
				<div class="basic-list">
				<table id="listTable" summary="">
					<caption>게시판 테이블</caption>
					<colgroup>
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">직원번호</th>
							<th scope="col">성명</th>
							<th scope="col">메일주소</th>
							<th scope="col">전화번호</th>
							<th scope="col">부서명</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody>		
					<c:forEach var="item" items="${noticeList}" varStatus="status">			
						<tr>
							<td class="subject">${item.empno}</td>
							<td class="date-td">${item.name}</td>
							<td>${item.mailno}</td>
							<td class="ref-td">${item.telno}</td>
							<td class="like-td">${item.dept_name}</td>
							<td><input type="button" name="srchDescription" class="search_btn" onclick="javascript:UserSelect('${item.empno}', '${item.name}', '${item.mailno}', '${item.dept_name}', '${item.telno}');" value="선택"></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</div>	                

                <div class="btn-zone">
                   <ul>
                      <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.self.close();" value="닫기"></li>
                   </ul>
                </div>
			</form>
            </div>

</body>
    
<script type="text/javascript">       
	function UserSelect(empno, name, mailno, dept_name, telno)
	{
		$(opener.document).find("#reg_id").val(empno);
		$(opener.document).find("#reg_nm").val(name);
		$(opener.document).find("#reg_email").val(mailno);
		$(opener.document).find("#reg_dept_nm").val(dept_name);
		$(opener.document).find("#reg_tel").val(telno);
		self.close();
	}
    function btnSearFrm() {
   		frm.submit();
	}

</script>
