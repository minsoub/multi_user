<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">마이페이지</div> 
    
    <div class="tab_box">
        <ul class="equip">
            <li><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
            <li><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
            <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
            <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
            <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
            <li class="active"><a href="/kube/mypage/customizeMenu.do">메뉴 관리</a></li>
        </ul>
    </div>

    <form id="frm" name="frm" method="post">
    <input type="hidden" id="m_gubun" name="m_gubun" value="${kubeLeftMenuList[0].m_gubun}" />
	    <div class="m_title_02" style="margin:40px 0 10px 0">메뉴 노출 설정</div>
	    <table class="table-view">
	        <colgroup>
	            <col width="15%" />
	            <col />
	        </colgroup>
	        <c:set var="categoryCnt" value="0" />
	        <c:set var="categoryChkCnt" value="0" />
	        <c:forEach var="category" items="${kubeLeftMenuList}" varStatus="status">
				<c:if test="${category.p_code_seq == 0}">
                	<c:if test="${status.index != 0}">
                    	<c:if test="${categoryCnt == 0}">
                    		<tr>
  						</c:if>
						<c:set var="categoryCnt" value="0" />
						<c:set var="categoryChkCnt" value="0" />
								</td>
							</tr>
                     </c:if>
                     
					<th>${category.code_desc }</th>
					<td class="checks" style="padding: 0px 7px 15px 20px">
				</c:if>
				<c:if test="${category.p_code_seq == 0}"><br /></c:if>
		        <c:if test="${category.p_code_seq != 0}">
		        	<c:set var="categoryChkCnt" value="${categoryChkCnt + 1}" />
		        	<c:if test="${kubeLeftMenuList[0].m_gubun == 'COMMON_MENU'}">
						<input type="checkbox" id="${category.code_seq}" name="chkMenu" checked="checked" value="${category.code_seq}">&nbsp;&nbsp;<label for="${category.code_seq}">${category.sub_code_desc }</label>
					</c:if>
					<c:if test="${kubeLeftMenuList[0].m_gubun == 'USER_MENU'}">
						<input type="checkbox" id="${category.code_seq}" name="chkMenu" ${category.use_flag == 1 ? 'checked' : ''} value="${category.code_seq}">&nbsp;&nbsp;<label for="${category.code_seq}">${category.sub_code_desc }</label>
					</c:if>
					<c:if test="${categoryChkCnt % 4 == 0}"><br /><br /></c:if>
					<c:set var="categoryCnt" value="${categoryCnt + 1}" />
				</c:if>
	            <c:if test="${status.last }">
					</tr>
				</c:if>
				
	        </c:forEach>
	    </table>
	    
	    <div class="fl_right" style="margin:15px 0">
	        <button type="button" onclick="javascript:funSaveMenu();" class="btn_black img_pointer">저장</button> 
	    </div>         
    </form>
</div>
<script type="text/javascript">
$(document).ready(function() {
});

function funSaveMenu(){
	
	var chkCnt = 0;
	
	$('input[name=chkMenu]').each(function(){
		if($(this).is(":checked")){
			chkCnt = chkCnt + 1;
		} 
	})
	
	if(chkCnt == 0){
		alert('1개 이상의 메뉴를 설정해야 합니다.');
		return false;
	}
	
	if(confirm('선택된 카테고리만 좌측 메뉴에 노출됩니다.\n해당 설정으로 저장하시겠습니까?')){
		dataString = $("#frm").serialize();

	    $.ajax({
	       type: "POST",
	       url: "/kube/mypage/insertMyCustomMenu.do",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
	    	   
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
	    		   alert('저장 되었습니다');
	    		   location.replace(document.location.href);
				   
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
<c:import url="/resource/common/include/kube_bottom.jsp" />