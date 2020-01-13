<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_pop_meta.jsp" />
<style>
.btn_orange {
    background-color: #ff8400;
    color: #fff;
    font-size: 14px;
    padding: 6px 23px;
    border-radius: 2px;
    cursor: pointer;
    border: none;
    text-align:center;
    vertical-align:middle;
}
</style>
<body>
<div class="popup_view_box1" style="background-image: url('/resource/kube_images/top_bg.png');">
<h3 style="color:#fff">운영자 추가</h3>
	<form id="frm" name="frm" method="post" onkeydown="javascript:if(event.keyCode == 13){return false;}">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	    <div class="searchArea_con" style="margin-top:35px">
	        <fieldset>
	            <div class="search-box">		
	                <div class="form-group">
	                <legend>검색영역</legend>	 
	                <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" placeholder="이름" value="${paging.srh_keyword }" style="width: 180px;height:15px;margin-left: 8px;font-size:12px;color:#666;" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit2(location.href);}">
	                <button type="button" onclick="javascript:funFrmPagingSubmit2(location.href);" class="btn_orange">SEARCH</button>
	                </div>
	                <div class="form-group"> 
	                	<input type="radio" name="adm_gubun" value="N" style="margin-left: 15px;" checked="checked"> 선택안됨
	                	<input type="radio" name="adm_gubun" value="S" style="margin-left: 10px;"> 전체 운영자
	                	<input type="radio" name="adm_gubun" value="E" style="margin-left: 10px;"> e-러닝 운영자
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
	                        <th style="background-color: #edfafc">이름</th>
	                        <th style="background-color: #edfafc">사번</th>
	                        <th style="background-color: #edfafc">부서명</th>
	                        <th style="background-color: #edfafc">직급</th>
	                    </tr>
	                </thead>
					<tbody>
						<c:forEach var="userList" items="${userList }">						
		                    <tr style="cursor: pointer;" onclick="javascript:funSaAct(this, '${userList.empno}', 'C')">
		                        <td>${userList.name }</td>
		                        <td>${userList.empno }</td>
		                        <td>${userList.dept_name1 } ${userList.dept_name2 }</td>
		                        <td>${userList.levelnm }</td>
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
	var tmp_adm_chk = $('input[name=adm_gubun]:checked').val();
	
 	if(tmp_adm_chk == 'N'){
 		alert('등록하실 운영자 권한을 선택하시기 바랍니다.');
 		$('input[name=adm_gubun]')[0].focus();
 		return false;
 	}else if(tmp_adm_chk == 'S'){
 		alert_msg = "전체 운영자";
 	}else if(tmp_adm_chk == 'E'){
 		alert_msg = "e-러닝 운영자";
 	}

	if(confirm($(obj).children().eq(0).text() + '님을 ' + alert_msg + '로 등록하시겠습니까?')){
		var param = {'empno' : empno, 'act_gubun' : g, 'adm_gubun' : tmp_adm_chk}
		
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