<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="3" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="3"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="9"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
                    <div class="nav-list">
                        <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                    </div>
                    <div class="nav-title">노트북 현황 관리대장</div>
                </div>
                <div class="searchArea_con" style="width:1000px;">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                        	<%-- 점검자가 결재를 진행하지 않은 경우 해당 년월은 재수집이 가능하다. 결재선이 변경 된 경우, 재집계를 진행하는 경우 등등 리셋이 필요할때 사용 --%>
                        	<c:set var="tmpAppMonth"></c:set>
                        	<c:forEach var="monthList" items="${monthList}" varStatus="x">
                        		<c:if test="${monthList.app_datetime1 eq null }">
                        			<c:set var="tmpAppMonth" value="${cha:todate(monthList.app_month, '', '3').concat('||').concat(tmpAppMonth)}"></c:set>
                        		</c:if>
	                        </c:forEach>
	                        <c:if test="${tmpAppMonth ne ''}">
	                        	<select name="resetAppMonth" style="width: 100px;">
	                        		<option value="">-- 선택 --</option>
	                        		<c:forEach var="tmpAppMonth" items="${fn:split(tmpAppMonth, '||') }" varStatus="x">
	                        			<option value="${fn:substring(tmpAppMonth, 0, 6) }">${fn:substring(cha:todate(tmpAppMonth, '-', '3'), 0, 7)}</option>
	                        		</c:forEach>
	                        	</select>
	                        	<input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:funReset();" class="search_btn" value="재집계">
	                        </c:if>
                            <input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:funExportXls();" class="search_btn" value="엑셀저장">
                        </div>
                        <div style="float:right;"><input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:funPopApp();" class="search_btn" value="결재선"></div>
                    </div>
                    </fieldset>
            	</div>
                
                <form id="frm" name="frm" method="post" action="/admin/checkAppMonthList.jsp" onSubmit="return false;">
                <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
                <input type="hidden" id="target_date" name="target_date" />
            	<input type="hidden" id="gubun" name="gubun" />
            	<input type="hidden" id="insban" name="insban" />
            	<input type="hidden" id="gbcd" name="gbcd" />
				<div id="tablelist" class="basic-list2" style="margin-top:5px;">
	                <table id="listTable" summary="">
	                    <caption>노트북 점검대장</caption>
	                    <colgroup>
	                    	<col />
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:10%">
	                        <col style="width:10%">
	                        <col style="width:10%">
	                        <col style="width:10%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                        	<th scope="col" rowspan="3">날짜</th>
	                            <th scope="col" colspan="6">대여 현황</th>
	                        	<th scope="col" rowspan="3">점검결과</th>
	                            <th scope="col" rowspan="3">점검자</th>
	                            <th scope="col" rowspan="3">파트장</th>
	                            <th scope="col" rowspan="3">부서장</th>
	                        </tr>
	                        <tr>
	                        	<th scope="col" colspan="2">총 수량<br/>(노트북&nbsp;/&nbsp;태블릿)</th>
	                            <th scope="col" colspan="2">장기<br/>(노트북&nbsp;/&nbsp;태블릿)</th>
	                            <th scope="col" colspan="2">단기<br/>(노트북&nbsp;/&nbsp;태블릿)</th>
	                        </tr>
	                        <tr>
	                        	<th scope="col">반출</th>
	                            <th scope="col">반납</th>
	                        	<th scope="col">반출</th>
	                            <th scope="col">반납</th>
	                        	<th scope="col">반출</th>
	                            <th scope="col">반납</th>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                        <c:forEach var="monthList" items="${monthList}" varStatus="x">
	                        <tr>
	                        	<td><a href="javascript:;" onclick="javascript:funApproval('${monthList.app_month }');" >${cha:todate(monthList.app_month, '-', '3')} ~ ${cha:todate(cha:monthLastDate(monthList.app_month), '-', '3')}</a></td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_long_ins_cnt + monthList.note_short_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','total','ins', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_long_ins_cnt + monthList.note_short_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_long_ins_cnt + monthList.note_short_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_long_ins_cnt + monthList.tabl_short_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','total','ins', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_long_ins_cnt + monthList.tabl_short_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_long_ins_cnt + monthList.tabl_short_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_long_ban_cnt + monthList.note_short_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','total','ban', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_long_ban_cnt + monthList.note_short_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_long_ban_cnt + monthList.note_short_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_long_ban_cnt + monthList.table_short_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','total','ban', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_long_ban_cnt + monthList.table_short_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_long_ban_cnt + monthList.table_short_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_long_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','long','ins', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_long_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_long_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_long_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','long','ins', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_long_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_long_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_long_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','long','ban', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_long_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_long_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_long_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','long','ban', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_long_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_long_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_short_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','short','ins', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_short_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_short_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_short_ins_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','short','ins', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_short_ins_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_short_ins_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>
	                        		<c:choose>
		                        		<c:when test="${monthList.note_short_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','short','ban', '001');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.note_short_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.note_short_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        		&nbsp;/&nbsp;
	                        		<c:choose>
		                        		<c:when test="${monthList.tabl_short_ban_cnt != 0}">
		                        			<a href="javascript:;" onclick="javascript:funDetail('${monthList.app_month}','short','ban', '010');" style="text-decoration: underline;">
		                        				<fmt:formatNumber value="${monthList.tabl_short_ban_cnt }" pattern="#,###" />
		                        			</a>
		                        		</c:when>
		                        		<c:otherwise>
		                        			${monthList.tabl_short_ban_cnt }
		                        		</c:otherwise>
	                        		</c:choose>
	                        	</td>
	                        	<td>${monthList.check_result }</td>
	                        	<td>
	                        		<c:if test="${SESS_EMPNO == monthList.app_empno1 && monthList.app_datetime1 eq null}">
	                        			<%-- <a href="javascript:;" onclick="javascript:funAppProc('${monthList.app_month}','1');" style="text-decoration: underline;"> --%>
	                        			<a href="javascript:;" onclick="javascript:funApproval('${monthList.app_month }');"  style="text-decoration: underline;">
	                        			${monthList.app_emp_name1 }
	                        			</a>
	                        		</c:if>
	                        		<c:if test="${SESS_EMPNO != monthList.app_empno1 ||  monthList.app_datetime1 ne null}">
	                        			${monthList.app_emp_name1 }
	                        		</c:if>
	                        		<c:if test="${monthList.app_datetime1 ne null}"><br />${fn:substring(monthList.app_datetime1, 0, 10)}</c:if>
	                        	</td>
	                        	<td>
									<c:if test="${SESS_EMPNO == monthList.app_empno2 && monthList.app_datetime2 eq null && monthList.app_datetime1 ne null}">
	                        			<%-- <a href="javascript:;" onclick="javascript:funAppProc('${monthList.app_month}','2');" style="text-decoration: underline;"> --%>
	                        			<a href="javascript:;" onclick="javascript:funApproval('${monthList.app_month }');"  style="text-decoration: underline;">
	                        			${monthList.app_emp_name2 }
	                        			</a>
	                        		</c:if>
	                        		<c:if test="${SESS_EMPNO != monthList.app_empno2 ||  monthList.app_datetime2 ne null || monthList.app_datetime1 eq null}">
	                        			${monthList.app_emp_name2 }
	                        		</c:if>
									<c:if test="${monthList.app_datetime2 ne null}"><br />${fn:substring(monthList.app_datetime2, 0, 10)}</c:if>
								</td>
	                        	<td>
	                        		<c:if test="${SESS_EMPNO == monthList.app_empno3 && monthList.app_datetime3 eq null && monthList.app_datetime2 ne null}">
	                        			<%-- <a href="javascript:;" onclick="javascript:funAppProc('${monthList.app_month}','3');" style="text-decoration: underline;"> --%>
	                        			<a href="javascript:;" onclick="javascript:funApproval('${monthList.app_month }');"  style="text-decoration: underline;">
	                        			${monthList.app_emp_name3 }
	                        			</a>
	                        		</c:if>
	                        		<c:if test="${SESS_EMPNO != monthList.app_empno3 ||  monthList.app_datetime3 ne null || monthList.app_datetime2 eq null}">
	                        			${monthList.app_emp_name3 }
	                        		</c:if>
		                        	<c:if test="${monthList.app_datetime3 ne null}"><br />${fn:substring(monthList.app_datetime3, 0, 10)}</c:if>
		                        </td>
	                        </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(monthList) == 0}">
	                        <tr>
	                            <td align="center" colspan="11">등록된 데이터가 없습니다.</td>
	                        </tr>
	                        </c:if>
	                    </tbody>
	                </table>
            	</div>
            	<div style="width:1000px;">
            	<c:import url="/resource/common/include/paging.jsp" />
            	</div>
            	
            	</form>
            </div>
        </div>
    </div>
</body>
<iframe id="ifrm" name="ifrm" style="display: none;" ></iframe> 
<script type="text/javascript" src="/resource/common/js/jquery.fileDownload.js"></script>
<script language="javascript">
$(document).ready(function() {
	 load_fnc('3', '0', '0'); //menu script
});

function funDetail(target_date, gubun, insban, gbcd){
	$('#target_date').val(target_date);
	$('#gubun').val(gubun);
	$('#insban').val(insban);
	$('#gbcd').val(gbcd);
	funSubmit('/admin/checkAppMonthDetail.do');
}

function funApproval(target_date){
	$('#target_date').val(target_date);
	funSubmit('/admin/checkAppMonthApproval.do');
}


function funReset(){
	
	var appDate = $('select[name=resetAppMonth]').val();
	
	if($.trim(appDate) == ''){
		alert('재집계 대상 년월을 선택하시기 바랍니다.');
		$('select[name=resetAppMonth]').focus();
	}else{
		if(confirm('선택하신 년월의 데이터를 재집계 하시겠습니까?')){
			$.ajax({
			       url: "/admin/insertMonthAppData.do",
			       type: "POST",
			       data: {'reqDate' : appDate},
			       dataType: "html",
			       success: function(msg) {
			    	   if($.trim(msg) == 'success'){
			    		   location.replace(location.href);
			    	   }else{
			    		   alert('오류가 발생했습니다. 관리자에게 문의하시기 바랍니다.');
			    		   return false;
			    	   }
			       }
			});
		}
	} 
}

function funPopApp(){ 
	window.open('/admin/checkAppManage.do','pop_app','width=600px,height=550px');
}

function funAppProc(app_month, level){
	
	var alert_msg = "";
	
	if(level == '1'){
		alert_msg = "파트장님께 해당 건을 상신하시겠습니까?";
	}else if(level == '2'){
		alert_msg = "부서장님께 해당 건을 상신하시겠습니까?";
	}else if(level == '3'){
		alert_msg = "결재 완료 처리하시겠습니까?";
	}
	
	if(confirm(alert_msg)){
		$.ajax({
		       url: "/admin/oneStopCheckAppMonth.do",
		       type: "POST",
		       data: {'app_month' : app_month, 'level' : level},
		       dataType: "html",
		       success: function(msg) {
		    	   if($.trim(msg) == 'success'){
		    		   alert('정상 처리되었습니다.');
		    		   location.replace(location.href);
		    	   }else{
		    		   alert('오류가 발생했습니다. 관리자에게 문의하시기 바랍니다.');
		    		   return false;
		    	   }
		       }
		});
	}
}


var xlsDown = true;

function funExportXls(){
	
	if(xlsDown){
		xlsDown = false;
		
		$('#frm').attr('action','/admin/checkMonthExcelDownload.do').attr('method', 'post').attr('target', 'ifrm').submit();
		
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