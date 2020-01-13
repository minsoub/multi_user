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
            <li id="3" class="active"><a href="javascript:;">신고영상 관리</a></li>
            <li id="6"><a href="javascript:;">영상 관리</a></li>
            <li id="4"><a href="javascript:;">사용자 관리</a></li>
            <li id="5"><a href="javascript:;">운영자 관리</a></li>
            <li id="7"><a href="javascript:;">e-러닝 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="re_seq" name="re_seq">
	<input type="hidden" id="re_gubun" name="re_gubun">
	<input type="hidden" id="re_status" name="re_status">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">

    <div class="m_title_02" style="margin:20px 0 10px 0">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>
    <table class="table-list" style="margin-top:10px">
        <colgroup>
            <col style="width: 1px">
			<col style="width: 10%">
			<col style="width: 10%">   
			<col style="">
			<col style="width: 9%">  
			<col style="width: 11%">
			<col style="width: 8%">
			<col style="width: 13%">
        </colgroup>
        <thead>
            <tr>
                <th></th>
				<th>분류</th>
				<th>신고사유</th>
				<th>신고대상</th>
                <th>신고자</th>
                <th>신고일시</th>
                <th>원본확인</th>
                <th>처리</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach var="reportList" items="${reportList }">			
				<tr>
					<td rowspan="2"></td>
					<td>   
						<c:if test="${reportList.re_gubun == '1'}">
							영상             
						</c:if>
						<c:if test="${reportList.re_gubun == '2'}">
							댓글
						</c:if>
					</td>       
					<td>${reportList.code_desc }</td>       
                    <td style="text-align: left;">${reportList.target_desc }</td>
					<td>${reportList.name }</td>
					<td>${cha:todate(reportList.reg_date, '-', '2') }</td>
					<td><button type="button" onclick="javascript:window.open('/kube/watch/${cha:seqEncode(reportList.vi_seq) }?code_seq=${reportList.code_seq2 }&p_code_seq=${reportList.code_seq1 }','reportDetail','')" class="btn_orange img_pointer">열기</button></td> 
					<td>
						<c:if test="${reportList.re_status == '0' }">
				        	<button type="button" class="btn_black img_pointer" onclick="javascript:funUpdateReport(this, '${reportList.re_seq}', '${reportList.re_gubun}', '2');">해제</button>
				            <button type="button" class="btn_black img_pointer" onclick="javascript:funUpdateReport(this, '${reportList.re_seq}', '${reportList.re_gubun}', '3');">삭제</button>
						</c:if>
						<%--1은 현재 기능 없음. 사용자에서 취소할 수도 있어서 코드만 만들어 둠  17.10.01 --%>
						<c:if test="${reportList.re_status == '1' }">
							신고취소(사용자)    
						</c:if>
						<c:if test="${reportList.re_status == '2' }">
							<!-- 신고해제(관리자) -->
							<font color="blue">신고해제</font>
						</c:if>
						<c:if test="${reportList.re_status == '3' }">
							<!-- 삭제처리(관리자) -->
							<font color="red">삭제처리</font>
						</c:if> 
					</td>
				</tr>
				<tr>
					<td colspan="7" style="text-align: left; background-color: #f7f7f7; padding-left: 15px;word-wrap: break-word;"><pre>${fn:trim(reportList.re_desc) }</pre></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(reportList) == 0}">
		  		<tr><td colspan="8">신고 목록이 없습니다.</td></tr>
		    </c:if>
        </tbody>
    </table>
	</form>
    <c:if test="${fn:length(reportList) != 0}">	                  
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

function funUpdateReport(obj, re_seq, g, s){
	
	var alert_msg = '';

	if(s == '2'){
		alert_msg = '신고 대상에 대한 신고 사항을 해제하시겠습니까?';
	}else if(s == '3'){
		if(g == '1'){
			alert_msg = '신고 대상을 삭제하시겠습니까?\n삭제 된 영상은 사용자에게 노출되지 않습니다.';
		}else if(g == '2'){
			alert_msg = '신고 대상을 삭제하시겠습니까?\n상위 댓글을 삭제하시면 하위 댓글(대댓글)도 사용자에게 노출되지 않습니다.';
		}
	}

	if(confirm(alert_msg)){
		var param = {'re_seq' : re_seq, 're_gubun' : g, 're_status' : s}
		
	    $.ajax({
	       url: "/kube/updateReport.do",
	       type: "POST",
	       data: param,
	       dataType: "json",
	       success: function(msg) {
	    	   var tmp_result = $.trim(msg);
				
	    	   if(tmp_result != 'false'){
					
	    		   alert('처리 되었습니다.');
	    		   
	    		   goPage2($('#pageNo').val());
		    		   
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