<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<div class="popup_view_box1">
<h3 style="color:#fff">운영자 추가</h3>
	<form id="frm" name="frm" method="post" onkeydown="javascript:if(event.keyCode == 13){return false;}">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	    <div class="searchArea_con" style="margin-top:35px">
	        <fieldset>
	            <div class="search-box">		
	                <div class="form-group">
	                <legend>검색영역</legend>	 
	                <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" placeholder="이름" value="${paging.srh_keyword }" style="width: 180px;height:15px;margin-left: 8px;font-size:12px;color:#666;" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit2(location.href);}">
	                <input type="button" style="cursor: pointer;" class="search_btn" value="검색" onclick="javascript:funFrmPagingSubmit2(location.href);" />
	                </div>
	            </div>
	        </fieldset>
	    </div>
	    <div class="basic-list">
	        <table id="listTable" summary="">
	            <caption>게시판 테이블</caption>
	                <colgroup>
	                <col style="width: 15%" class="no-td">
	                <col style="width: 20%">
	                <col style="">
	                <col style="width: 20%">
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th scope="col" class="like-td">이름</th>
	                        <th scope="col" class="like-td">사번</th>
	                        <th scope="col" class="no-td">부서명</th>
	                        <th scope="col" class="like-td">직급</th>
	                    </tr>
	                </thead>
					<tbody>
						<c:forEach var="userList" items="${userList }">						
		                    <tr style="cursor: pointer;" onclick="javascript:funSaAct(this, '${userList.empno}', 'C')">
		                        <td class="like-td">${userList.name }</td>
		                        <td class="like-td">${userList.empno }</td>
		                        <td class="no-td">${userList.dept_name1 } ${userList.dept_name2 }</td>
		                        <td class="like-td">${userList.jikyee }</td>
		                    </tr>
	                    </c:forEach>
					</tbody>
	        </table>
	    </div>
	</form>
    <c:import url="/resource/common/include/kube_paging.jsp" />

</div>
</html>
<script>
function funCancel(){
	window.self.close();
}

function funSaAct(obj, empno, g){
	var alert_msg = '';
 
	if(confirm($(obj).children().eq(0).text() + '님을 운영자로 등록하시겠습니까?')){
		var param = {'empno' : empno, 'act_gubun' : g}
		
	    $.ajax({
	       url: "/kube/insertDeleteKubeSa.do",
	       type: "POST",
	       data: param,
	       dataType: "json",
	       success: function(msg) {
	    	   var tmp_result = $.trim(msg);
				
	    	   if(tmp_result != 'false'){
					
	    		   alert('등록 되었습니다.');
	    		   opener.location.replace(opener.location.href);
	    		   funSubmit(location.href);
		    		   
	    		   return true;
				}else{
	    		   alert("오류가 발생 했습니다");
	    		   
	    		   return false;
				}
	 		}
		});
	}
}
</script>