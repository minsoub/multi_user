<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
    
    <c:if test="${sessionScope.SESS_USER_INFO['kubeAdminGubun'] == 'S'}">
	    <div class="m_title_01" style="margin:10px 0 30px 0">관리자</div> 
	    
	    <div class="tab_box">
	        <ul class="equip">
	            <li id="1"><a href="javascript:;">메인화면 관리</a></li>
	            <li id="2"><a href="javascript:;">카테고리 관리</a></li>
	            <li id="3"><a href="javascript:;">신고영상 관리</a></li>
	            <li id="6"><a href="javascript:;">영상 관리</a></li>
	            <li id="4"><a href="javascript:;">사용자 관리</a></li>
	            <li id="5"><a href="javascript:;">운영자 관리</a></li>
	            <li id="7" class="active"><a href="javascript:;">e-러닝 관리</a></li>
	        </ul>
	    </div>
	</c:if>
	
	<c:if test="${sessionScope.SESS_USER_INFO['kubeAdminGubun'] == 'E'}">
    	<div class="m_title_01" style="margin:10px 0 30px 0">e-러닝 관리자</div>
    </c:if> 
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
    <div class="m_title_02 fl_left" style="margin-bottom:10px">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>
    <div class="fl_right" style="font-size: 15px;text-align: right;">
    	<select name="srh_date" class="selectbox" style="width:120px;">
    		<option value="">--기간구분--</option>
           	<option value="start_datetime" ${paging.srh_date == 'start_datetime' ? 'selected' : ''}>시작일자</option> 
           	<option value="complete_datetime" ${paging.srh_date == 'complete_datetime' ? 'selected' : ''}>수료일자</option> 
        </select>
        <input type="text" id="start_date" name="start_date" readonly="readonly" onfocus="this.blur();" value="${paging.start_date}" class="textbox" style="width: 10%;" />
           	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=start_date]').datepicker('show');"> ~ 
           	<input type="text" id="end_date" name="end_date" readonly="readonly" onfocus="this.blur();" value="${paging.end_date}" class="textbox" style="width: 10%;" /> 
           	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=end_date]').datepicker('show');">
        <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" placeholder="이름, 영상제목" value="${paging.srh_keyword }" class="textbox" style="width:150px;vertical-align: middle;" onkeydown="javascript:if(event.keyCode == 13){funSubmit();}">
    	<select name="complete_flag" class="selectbox" style="width:120px;">
    		<option value="">--수료여부--</option>           
           	<option value="1" ${paging.complete_flag == '1' ? 'selected' : ''}>완료</option> 
           	<option value="0" ${paging.complete_flag == '0' ? 'selected' : ''}>미완료</option> 
        </select>
	    <button type="button" onclick="javascript:funSubmit();" class="btn_orange img_pointer" style="padding: 4px 23px;margin-left: 3px;">SEARCH</button>
	    <img src="/resource/images/icon_exel.png" style="width: 28px; height: 30px; margin-left: 3px; cursor: pointer;" onclick="javascript:funExportXls();">
    </div>
    <table class="table-list" style="margin-top:10px">
        <colgroup>
			<col style="width: 6%">
			<col style="width: 6%">   
			<col style="width: 10%">
            <col />
			<col style="width: 8%"> 
			<col style="width: 8%"> 
			<col style="width: 8%"> 
			<col style="width: 15%">
			<col style="width: 8%"> 
        </colgroup>
        <thead>
            <tr>
                <th>사번</th>
				<th>이름</th>
				<th>소속</th>
                <th>과정명</th>
                <th>시작일시</th>
                <th>수료일시</th>
                <th>수료여부</th>
                <th>과정시간</th>
                <th>진행률</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="statList" items="${statList }">
            	<fmt:formatNumber var="progressPer" value="${statList.play_duration_sec * 100 / statList.totDuration }" pattern="###" />			
				<tr>
					<td>${statList.empno }</td>       
					<td>${statList.name }</td>       
					<td>${statList.dept_name }</td>       
					<td>${statList.title }</td>       
					<td>${statList.start_datetime }</td>       
					<td>${statList.complete_datetime }</td>       
					<td>${statList.complete_flag == '0' ? '미완료' : '완료' }</td>
					<td>${cha:secToHour(statList.play_duration_sec) } / ${cha:secToHour(statList.totDuration) }</td>
					<td>${progressPer }%</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(statList) == 0}">
				<tr><td colspan="9">검색 결과가 없습니다.</td></tr>
			</c:if>
        </tbody>
    </table>
    </form>
   <c:if test="${fn:length(statList) != 0}">	                  
		<c:import url="/resource/common/include/kube_paging.jsp" />
	</c:if>                      
</div>
<iframe id="ifrm" name="ifrm" style="display: none;" ></iframe> 
<script type="text/javascript" src="/resource/common/js/jquery.fileDownload.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("input[name*=_date]").datepicker({
		dateFormat : 'yy-mm-dd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월',
				'5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월',
				'5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금','토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목','금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목','금', '토' ],
		showMonthAfterYear : true,
		changeYear : true,
		changeMonth : true,
		yearSuffix : ' '
	});
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

function funSubmit(){
	if($('select[name=srh_date]').val() != ''){
		if($.trim($('#start_date').val()) == ''
				|| $.trim($('#end_date').val()) == ''){
			alert('기간 설정이 잘못되었습니다.');
			$('#start_date').focus();
			return false;
		}	
	}else{
		if($.trim($('#start_date').val()) != ''
			|| $.trim($('#end_date').val()) != ''){
		alert('검색 기간을 선택해주세요.');
		$('select[name=srh_date]').focus();
		return false;
	}
	}
	
	funFrmPagingSubmit2(location.href);
}


var xlsDown = true;

function funExportXls(){
	
	if('${fn:length(statList)}' == 0){
		alert('검색 결과가 없습니다.');
		return false;
	}
	
	if(xlsDown){
		xlsDown = false;
		
		$('#frm').attr('action','/kubeElearnStatXls.do').attr('method', 'post').attr('target', 'ifrm').submit();
		
		$.fileDownload($("#frm").prop('action'),{
			httpMethod: "POST",  
			data:jQuery("#frm").serialize(),   
			successCallback: function (url) {
				xlsDown = true;
			},
			failCallback: function(responesHtml, url){
				alert('다운로드 오류 발생. 관리자에게 문의 하시기 바랍니다.');
				xlsDown = true;
			}
		}); 
	}else{ 
		alert('${totalCnt}건 다운로드 진행 중 입니다.\n데이터 양이 많을수록 엑셀 처리 속도가 지연됩니다.(약 50건/초)\n화면 이동시 진행중인 다운로드는 취소됩니다.');
	}
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />