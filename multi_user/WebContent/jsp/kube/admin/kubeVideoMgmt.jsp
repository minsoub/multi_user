<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
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
            <li id="6" class="active"><a href="javascript:;">영상 관리</a></li>
            <li id="4"><a href="javascript:;">사용자 관리</a></li>
            <li id="5"><a href="javascript:;">운영자 관리</a></li>
            <li id="7"><a href="javascript:;">e-러닝 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
    <div class="m_title_02 fl_left" style="margin-bottom:10px">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>
    <div class="fl_right" style="font-size: 15px;text-align: right;">
	    게시기간 : <input type="text" name="start_date" readonly="readonly" onfocus="this.blur();" value="${cha:todate(paging.start_date,'-','3')}" class="textbox" style="width: 17%;" />
           	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=start_date]').datepicker('show');"> ~ 
           	<input type="text" name="end_date" readonly="readonly" onfocus="this.blur();" value="${cha:todate(paging.end_date,'-','3')}" class="textbox" style="width: 17%;" /> 
           	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=end_date]').datepicker('show');">
	    <button type="button" onclick="javascript:funFrmPagingSubmit2(location.href);" class="btn_orange img_pointer" style="padding: 4px 23px;margin-left: 3px;">SEARCH</button>
	    <img src="/resource/images/icon_exel.png" style="width: 28px; height: 30px; margin-left: 3px; cursor: pointer;" onclick="javascript:funExportXls();">
    </div>
    <table class="table-list" style="margin-top:10px">
        <colgroup>
            <col />
			<col style="width: 10%">
			<col style="width: 18%">   
			<col style="width: 8%">
			<col style="width: 8%">
			<col style="width: 8%">
			<col style="width: 8%">
			<col style="width: 13%" >     
        </colgroup>
        <thead>
            <tr>
                <th>제목</th>
				<th>카테고리</th>
				<th>게시자</th>
                <th>조회</th>
                <th>댓글</th>
                <th>다운로드</th>
                <th>좋아요</th>
                <th>게시일시</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="videoList" items="${videoList }">			
				<tr style="cursor: pointer;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');">
					<td>${videoList.title }</td>       
					<td>${videoList.p_code_desc }<br />${videoList.code_desc }</td>       
					<td>${videoList.dept_name1 }<br />${videoList.dept_name2 }<br />${videoList.writer }</td>       
					<td><fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"/></td>       
					<td><fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"/></td>
					<td><fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###"/></td>
					<td><fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"/></td>
					<td>${cha:todate(videoList.reg_date, '-', '3') }<br/>${cha:todate(videoList.reg_date, '', '4') }</td>       
				</tr>
			</c:forEach>
        </tbody>
    </table>
    </form>
   <c:if test="${fn:length(videoList) != 0}">	                  
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

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}

var xlsDown = true;

function funExportXls(){
	
	if(xlsDown){
		xlsDown = false;
		
		$('#frm').attr('action','/kubeVideoExportXls.do').attr('method', 'post').attr('target', 'ifrm').submit();
		
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