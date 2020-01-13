<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />

<body>


<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
				<c:param name="left_depth_2" value="5"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<form id="frm" name="frm" method="post">
			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
					</div>
					<div class="nav-title">관리자</div>
				</div>
	            
	            <div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 10%">
							<col style="width: 15%">
							<col style="width: 10%">
							<col >
							<col style="width: 15%" >
	                        <col style="width: 20%" >
							<col style="width: 10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="like-td">운영자명</th>
								<th scope="col" class="like-td">부서</th>
	                            <th scope="col" class="like-td">직급</th>
								<th scope="col" class="like-td">이메일</th>
	                            <th scope="col" class="like-td">전화번호(내선)</th>
	                            <th scope="col" class="like-td">핸드폰번호</th>
								<th scope="col" class="no-td">삭제</th>
							</tr>
						</thead>
						<tbody>		
							<c:forEach var="saList" items="${saList }" varStatus="status">
								<tr>
									<td class="like-td">${saList.name }</td>
		                            <td class="like-td">${saList.dept_name }</td>
									<td class="like-td">${saList.levelnm }</td>
									<td class="like-td">${saList.mailno }@kepco.co.kr</td> 
									<td class="like-td">${saList.telno }</td> 
		                            <td class="like-td">${saList.hp }</td> 
									<td class="no-td" style="cursor: pointer;text-decoration: underline;" onclick="javascript:funSaAct('${saList.empno}', 'D');">삭제</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(saList) == 0}">
								<tr><td colspan="7">검색 결과가 없습니다.</td></tr>
							</c:if>		
						</tbody>
					</table>
				</div>
	            
	            <div class="btn-zone">
	                <ul>
	                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSaAct('', 'C');" value="등록"></li>
	                </ul>
	            </div>
	        	<c:import url="/resource/common/include/paging.jsp" />
			</div>
			<!--content end-->
		</form>
	</div>
</div>

<script type="text/javascript"> 
$(document).ready(function() {
	load_fnc('9', '0', '0'); //menu script
});

function funSaAct(empno, g){
	var alert_msg = '';
 
	if(g == 'C'){ 
		window.open('/promote/promoteAdminRegPop.do', 'reg_sa_pop','width=800px,height=900px,left=250px,top=50px,scrollbars=yes,resizable=yes');		
	}else if(g == 'D'){
		if(confirm('해당 운영자를 삭제하시겠습니까?')){
			var param = {'empno' : empno, 'act_gubun' : g}
			
		    $.ajax({
		       url: "/promote/insertDeletePromoteAdmin.do",
		       type: "POST",
		       data: param,
		       dataType: "json",
		       success: function(msg) {
		    	   var tmp_result = $.trim(msg);
					
		    	   if(tmp_result != 'false'){
						
		    		   alert('삭제 되었습니다.');
		    		   
		    		   location.replace(location.href);
			    		   
		    		   return true;
					}else{
		    		   alert("오류가 발생 했습니다");
		    		   
		    		   return false;
					}
		 		}
			});
		}
	}
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />