<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">관리자</div> 
    
    <div class="tab_box">
        <ul class="equip">
            <li id="1"><a href="javascript:;">메인화면 관리</a></li>
            <li id="2"><a href="javascript:;">카테고리 관리</a></li>
            <li id="3"><a href="javascript:;">신고영상 관리</a></li>
            <li id="6"><a href="javascript:;">영상 관리</a></li>
            <li id="4" class="active"><a href="javascript:;">사용자 관리</a></li>
            <li id="5"><a href="javascript:;">운영자 관리</a></li>
            <li id="7"><a href="javascript:;">e-러닝 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
    <div class="m_title_02 fl_left" style="margin-bottom:10px">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>
    <div class="fl_right">
	    <label for=""></label>
	    <input type="text" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword }" placeholder="사용자명, 부서" class="textbox" style="width:250px;" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit2(location.href);}"/>
	    <button type="button" onclick="javascript:funFrmPagingSubmit2(location.href);" class="btn_orange img_pointer">SEARCH</button>
    </div>
    <table class="table-list" style="margin-top:10px">
        <colgroup>
            <col width="15%" />
            <col />
            <col width="16%" />
            <col width="16%" />
            <col width="16%" />                                
            <col width="16%" />
        </colgroup>
        <thead>
            <tr>
                <th>사용자명</th>
                <th>부서</th>
                <th>직급</th>
                <th>영상업로드</th>
                <th>영상다운로드</th>
                <th>댓글수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="userList" items="${userList }" >				
				<tr>
					<td>${userList.name }</td>
					<td>${userList.dept_name1 }<br/>${userList.dept_name2 }</td>
                    <td>${userList.levelnm }</td>
					<td><fmt:formatNumber value="${userList.upload_cnt}" pattern="#,###,###,###" /></td>
					<td><fmt:formatNumber value="${userList.download_cnt}" pattern="#,###,###,###" /></td>
					<td><fmt:formatNumber value="${userList.comment_cnt}" pattern="#,###,###,###" /></td>
				</tr>
			</c:forEach>
        </tbody>
    </table>
    </form>
   <c:if test="${fn:length(userList) != 0}">	                  
		<c:import url="/resource/common/include/kube_paging.jsp" />
	</c:if>                      
</div>
<script type="text/javascript">
$(document).ready(function() {
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
	}else if(menu == 7){
		linkUrl = '/kubeElearnStat.do';
	}
	
	goUrl(linkUrl);
});
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />