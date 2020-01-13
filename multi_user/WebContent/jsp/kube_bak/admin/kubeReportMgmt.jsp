<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
			</c:import> 
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
				</div>
				<div class="nav-title">신고영상 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3" class="active"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6"><a href="javascript:;">영상 관리</a></li>
                    <li id="4"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post">
            <input type="hidden" id="code_seq" name="code_seq">
			<input type="hidden" id="p_code_seq" name="p_code_seq">
			<input type="hidden" id="re_seq" name="re_seq">
			<input type="hidden" id="re_gubun" name="re_gubun">
			<input type="hidden" id="re_status" name="re_status">
			<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	            <div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 1px">
							<col style="width: 10%">
							<col style="width: 10%">   
							<col style="">
							<col style="width: 10%">  
							<col style="width: 10%">
							<col style="width: 15%" >
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td"></th>
								<th scope="col" class="like-td">분류</th>
								<th scope="col" class="like-td">신고사유</th>
								<th scope="col" class="like-td">신고대상</th>
	                            <th scope="col" class="like-td">신고자</th>
	                            <th scope="col" class="like-td">신고일시</th>
	                            <th scope="col" class="ref-td">구분</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reportList" items="${reportList }">			
								<tr>
									<td class="no-td" rowspan="2"></td>
									<td class="like-td">   
										<c:if test="${reportList.re_gubun == '1'}">
											영상             
										</c:if>
										<c:if test="${reportList.re_gubun == '2'}">
											댓글
										</c:if>
									</td>       
									<td class="like-td">${reportList.code_desc }</td>       
		                            <td class="like-td" style="text-align: left;">
		                            	<a href="/kube/watch/${cha:seqEncode(reportList.vi_seq) }?code_seq=${reportList.code_seq2 }&p_code_seq=${reportList.code_seq1 }" target="videoOpen" style="color:blue;">${reportList.target_desc }</a>
		                            </td>
									<td class="date-td">${reportList.name }</td>
									<td class="like-td">${cha:todate(reportList.reg_date, '-', '2') }</td> 
									<td>
										<c:if test="${reportList.re_status == '0' }">
								        	<input type="button" name="srchDescription" class="kube_btn" onclick="javascript:funUpdateReport(this, '${reportList.re_seq}', '${reportList.re_gubun}', '2');" value="해제" >
								            <input type="button" name="srchDescription" class="kube_btn2" onclick="javascript:funUpdateReport(this, '${reportList.re_seq}', '${reportList.re_gubun}', '3');" value="삭제" >
										</c:if>
										<%--1은 현재 기능 없음. 사용자에서 취소할 수도 있어서 코드만 만들어 둠  17.10.01 --%>
										<c:if test="${reportList.re_status == '1' }">
											신고취소(사용자)    
										</c:if>
										<c:if test="${reportList.re_status == '2' }">
											<!-- 신고해제(관리자) -->
											신고해제
										</c:if>
										<c:if test="${reportList.re_status == '3' }">
											<!-- 삭제처리(관리자) -->
											삭제처리 
										</c:if> 
									</td>
								</tr>
								<tr>
									<td colspan="6" style="text-align: left; background-color: #f7f7f7; padding-left: 15px;"><pre>${fn:trim(reportList.re_desc) }</pre></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </form>
            <c:import url="/resource/common/include/kube_paging.jsp" />
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
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
<c:import url="/resource/common/include/bottom.jsp" />