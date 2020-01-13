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
				<div class="nav-title">영상 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6" class="active"><a href="javascript:;">영상 관리</a></li>
                    <li id="4"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post">
            <input type="hidden" id="code_seq" name="code_seq">
			<input type="hidden" id="p_code_seq" name="p_code_seq">
			<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
				<div class="sub-nav-title-sm" style="float:left;margin-top: 8px;">전체 : <fmt:formatNumber value="${totalCnt}" pattern="#,###,###,###" />건</div>	
	            <div class="searchArea_con" style="float:right">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">  
							게시기간 : <input type="text" name="start_date" readonly="readonly" onfocus="this.blur();" value="${cha:todate(paging.start_date,'-','3')}" class="textbox" style="width: 17%;height: 16px;" />
					            	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=start_date]').datepicker('show');"> ~ 
					            	<input type="text" name="end_date" readonly="readonly" onfocus="this.blur();" value="${cha:todate(paging.end_date,'-','3')}" class="textbox" style="width: 17%;height: 16px;" /> 
					            	<img src="/resource/images/cal.png" style="cursor: pointer;" onclick="javascript:$('input[name=end_date]').datepicker('show');">
					            	<input type="button" style="cursor: pointer;" class="search_btn" value="검색" onclick="javascript:funFrmPagingSubmit2(location.href);" /> 
							<legend>검색영역</legend>	   
							<p class="inputDesign" style="display: inline-block; vertical-align: middle;margin-left: 10px;margin-right: -79px;">
							<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
								<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
								<option value="visit_cnt" ${paging.selOrder == 'visit_cnt' ? 'selected' : '' }>조회순</option>
								<option value="like_cnt" ${paging.selOrder == 'like_cnt' ? 'selected' : '' }>좋아요순</option>
								<option value="down_cnt" ${paging.selOrder == 'down_cnt' ? 'selected' : '' }>다운로드순</option>
							</select>                                  
							<img src="/resource/images/icon_exel.png" style="width: 30px; height: 30px; margin-top: -3px; cursor: pointer;" onclick="javascript:funExportXls();">
						</div>   
					</div>        
					</fieldset>
				</div>
	            <div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
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
								<th scope="col" class="like-td">제목</th>
								<th scope="col" class="like-td">카테고리</th>
								<th scope="col" class="like-td">게시자</th>
	                            <th scope="col" class="like-td">조회</th>
	                            <th scope="col" class="like-td">댓글</th>
	                            <th scope="col" class="like-td">다운로드</th>
	                            <th scope="col" class="ref-td">좋아요</th>
	                            <th scope="col" class="ref-td">게시일시</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="videoList" items="${videoList }">			
								<tr style="cursor: pointer;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');">
									<td class="like-td">${videoList.title }</td>       
									<td class="like-td">${videoList.p_code_desc }<br />${videoList.code_desc }</td>       
									<td class="like-td">${videoList.dept_name1 }<br />${videoList.dept_name2 }<br />${videoList.writer }</td>       
									<td class="like-td"><fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"/></td>       
									<td class="like-td"><fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"/></td>
									<td class="like-td"><fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###"/></td>
									<td class="like-td"><fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"/></td>
									<td class="like-td">${cha:todate(videoList.reg_date, '-', '3') }<br/>${cha:todate(videoList.reg_date, '', '4') }</td>       
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
<iframe id="ifrm" name="ifrm" style="display: none;" ></iframe> 
<script type="text/javascript" src="/resource/common/js/jquery.fileDownload.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
	
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
<c:import url="/resource/common/include/bottom.jsp" />