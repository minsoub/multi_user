<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<style>
	.searchArea_con table{
		border: 3px solid #B6C0E3;
		text-align: center;
		font-weight: bold;
	}
	
	.searchArea_con table span{
		writing-mode:tb-rl;
		color: #000000
	}
	
	.searchArea_con table tr:first-child td{
		text-align: center;
		background-color:#ECF0FB;
		border-right: 1px solid #B6C0E3;
		border-bottom: 1px solid #B6C0E3;
		font-weight: bold; 
	}
	
	.searchArea_con table tr:last-child td{
		border-right: 1px solid #B6C0E3;
	}
	
	.approvalUser{
		font-family: serif;
		font-size: 30px;
		font-weight: bold;
		color : blue;
	}
</style>
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="8"></c:param>
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
                    <div class="nav-title">노트북/테블릿 현황결재</div>
                </div>
                <div class="searchArea_con" style="float:right;">
                    <table>
                    	<colgroup>
                    		<col width="30px;">
                    		<col width="100px;">
                    		<col width="100px;">
                    		<col width="100px;">
                    	</colgroup>
                    	<tr style="height:30px;">
                    		<td rowspan="2"><span>결&nbsp;&nbsp;&nbsp;&nbsp;제</span></td>
                    		<td>점검자</td>
                    		<td>파트장</td>
                    		<td>부서장</td>
                    	</tr>
                    	<tr style="height:100px;">
                    		<td>
                    			<c:if test="${SESS_EMPNO == resultView.app_empno1 && resultView.app_datetime1 eq null}">
                        			<a href="javascript:;" onclick="javascript:funAppProc('${resultView.app_month}','1');" style="text-decoration: underline;">${resultView.app_emp_name1 }</a>
                        		</c:if>
                        		<c:if test="${SESS_EMPNO != resultView.app_empno1 && resultView.app_datetime1 eq null}"><p>${resultView.app_emp_name1 }</p></c:if>
                        		<c:if test="${resultView.app_datetime1 ne null &&  resultView.app_datetime1 ne null}">
                        			<p class="approvalUser">${resultView.app_emp_name1 }</p>
                        			<br />${fn:substring(resultView.app_datetime1, 0, 10)}
                       			</c:if>
                    		</td>
                    		<td>
                    			<c:if test="${SESS_EMPNO == resultView.app_empno2 && resultView.app_datetime2 eq null && resultView.app_datetime1 ne null}">
                        			<a href="javascript:;" onclick="javascript:funAppProc('${resultView.app_month}','2');" style="text-decoration: underline;">${resultView.app_emp_name2 }</a>
                        		</c:if>
                        		<c:if test="${SESS_EMPNO != resultView.app_empno2 && resultView.app_datetime2 eq null}">
                        			<p>${resultView.app_emp_name2 }</p>
                        		</c:if>
								<c:if test="${resultView.app_datetime2 ne null && resultView.app_datetime2 ne null}">
									<p class="approvalUser">${resultView.app_emp_name2 }</p>
									<br />${fn:substring(resultView.app_datetime2, 0, 10)}</c:if>
                    		</td>
                    		<td>
                        		<c:if test="${SESS_EMPNO == resultView.app_empno3 && resultView.app_datetime3 eq null && resultView.app_datetime2 ne null}">
                        			<a href="javascript:;" onclick="javascript:funAppProc('${resultView.app_month}','3');" style="text-decoration: underline;">${resultView.app_emp_name3 }</a>
                        		</c:if>
                        		<c:if test="${SESS_EMPNO != resultView.app_empno3 && resultView.app_datetime3 eq null}">
                        			<p>${resultView.app_emp_name3 }</p>
                        		</c:if>
	                        	<c:if test="${resultView.app_datetime3 ne null && resultView.app_datetime3 ne null}">
	                        		<p class="approvalUser">${resultView.app_emp_name3 }</p>
	                        		<br />${fn:substring(resultView.app_datetime3, 0, 10)}</c:if>
	                        </td>
                    	</tr>
                    </table>
            	</div>
                
                <form id="frm" name="frm" method="post" action="/admin/checkAppMonthList.jsp" onSubmit="return false;">
                <input type="hidden" id="target_date" name="target_date" value="${dataMap.target_date }" />
            	<input type="hidden" id="gubun" name="gubun" />
            	<input type="hidden" id="insban" name="insban" />
            	<input type="hidden" id="gbcd" name="gbcd" />
            	
            	<div style="clear:both;">
            	<div class="sub-nav-title" style="margin-top:10px;">${fn:substring(resultView.app_month, 0 ,4) }년 ${fn:substring(resultView.app_month, 4 ,6) }월 대여현황</div>
            	<div class="insrtfrom-framebox">
            		<div class="insert-step1-box">
            			<div class="form-step1">
            				<fieldset>
	            				<legend>2018년 9월 대여현황</legend>
	            				<div class="row-group">
	            					<dl class="insert_ready">
	            						<dt class="must-option">
	            							<label>기간</label>
	           							</dt>
	           							<dd>${cha:todate(resultView.app_month, '-', '3')} ~ ${cha:todate(cha:monthLastDate(resultView.app_month), '-', '3')}</dd>
	            					</dl>
	            					<dl class="insert_ready">
	            						<dt class="must-option">
	            							<label>노트북</label>
	           							</dt>
	           							<dd>
	           								<div class="basic-list1">
	           									<table id="listTable" style="text-align:center;">
	           										<colgroup>
	           											<col>
	           											<col>
	           											<col>
	           										</colgroup>
	           										<thead>
		           										<tr>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd" colspan="2">총수량</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd" colspan="2">장기</th>
		           											<th scope="col" class="like-td" colspan="2">단기</th>
		           										</tr>
		           										<tr>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반출</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반출</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td">반출</th>
		           										</tr>
	           										</thead>
	           										<tbody>
		           										<tr>
		           											<td>
		           												${resultView.note_long_ins_cnt + resultView.note_short_ins_cnt}
		           											</td>
		           											<td>
		           												${resultView.note_long_ban_cnt + resultView.note_short_ban_cnt}
		           											</td>
		           											<td class="like-td">${resultView.note_long_ins_cnt }</td>
		           											<td class="like-td">${resultView.note_long_ban_cnt }</td>
		           											<td class="like-td">${resultView.note_short_ins_cnt }</td>
		           											<td class="like-td">${resultView.note_short_ban_cnt }</td>
		           										</tr>
	           										</tbody>
	           									</table>
	           								</div>
	           							</dd>
	            					</dl>
	            					<dl class="insert_ready">
	            						<dt class="must-option">
	            							<label>테블릿</label>
	           							</dt>
	           							<dd>
	           								<div class="basic-list1">
	           									<table id="listTable" style="text-align:center;">
	           										<colgroup>
	           											<col>
	           											<col>
	           											<col>
	           										</colgroup>
	           										<thead>
		           										<tr>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd" colspan="2">총수량</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd" colspan="2">장기</th>
		           											<th scope="col" class="like-td" colspan="2">단기</th>
		           										</tr>
		           										<tr>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반출</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반출</th>
		           											<th scope="col" class="like-td" style="border-right:1px solid #ddd">반입</th>
		           											<th scope="col" class="like-td">반출</th>
		           										</tr>
	           										</thead>
	           										<tbody>
		           										<tr>
		           											<td>
		           												${resultView.tabl_long_ins_cnt + resultView.tabl_short_ins_cnt}
		           											</td>
		           											<td>
		           												${resultView.tabl_long_ban_cnt + resultView.tabl_short_ban_cnt}
		           											</td>
		           											<td class="like-td">${resultView.tabl_long_ins_cnt }</td>
		           											<td class="like-td">${resultView.tabl_long_ban_cnt }</td>
		           											<td class="like-td">${resultView.tabl_short_ins_cnt }</td>
		           											<td class="like-td">${resultView.tabl_short_ban_cnt }</td>
		           										</tr>
	           										</tbody>
	           									</table>
	           								</div>
	           							</dd>
	            					</dl>
	            					<dl class="insert_ready">
	            						<dt class="must-option">
	            							<label>점검결과</label>
	           							</dt>
	           							<dd>${resultView.check_result}</dd>
	            					</dl>
	            				</div>
	            			</fieldset>
            			</div>
            			
            			
            		</div>
            	</div>
            	</form>
            </div>
        </div>
    </div>
</body>


<script language="javascript">
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

</script>

<c:import url="/resource/common/include/bottom.jsp" />