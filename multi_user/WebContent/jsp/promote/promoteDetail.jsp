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
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
				<c:param name="left_depth_2" value="${left_depth_2 }"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<c:if test="${left_depth_2 == '3' }">
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행사항</b>
					</div>
					<div class="nav-title">진행사항 상세</div>
				</c:if>
				<c:if test="${left_depth_2 == '4' }">
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">결재</b>
					</div>
					<div class="nav-title">결재 상세</div>
				</c:if>
			</div>
            
            <div class="basic-list">
                <form>				
                    <div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
                            <legend>진행상태</legend>
                                <div class="row-group">	
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>진행상태</strong></dt>
                                        <dd>${cha:pStatus(promoteDetail.p_status) }</dd>
                                    </dl>
                                    <c:if test="${promoteDetail.p_status == 3 || promoteDetail.p_status == 4}">
	                                    <dl class="insert_ready">
	                                        <dt class="must-option"><strong>사유</strong></dt>
	                                        <dd>
	                                        	<c:if test="${promoteDetail.p_status == 3}">
	                                        		${promoteDetail.reject_desc }
	                                        	</c:if>
	                                        	<c:if test="${promoteDetail.p_status == 4}">
	                                        		${promoteDetail.cancel_desc }
	                                        	</c:if>
	                                        </dd>
	                                    </dl>
	                                </c:if>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    </div>
                </form>
			</div>
            
            <div class="sub-nav-title-sm">신청자 정보</div>		

			<div class="basic-list">
                <form>				
                    <div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
                            <legend>신청자 정보</legend>
                                <div class="row-group">	
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>신청부서</strong></dt>
                                        <dd style="width:200px">${promoteDetail.dept_name }</dd>
                                        <dt class="must-option"><strong>신청자</strong></dt>
                                        <dd style="width:200px">${promoteDetail.name }</dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>전화번호</strong></dt>
                                        <dd style="width:200px">${promoteDetail.telno }</dd>
                                        <dt class="must-option"><strong>이메일</strong></dt>
                                        <dd style="width:200px">${promoteDetail.mailno }@kepco.co.kr</dd>
                                    </dl>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    </div>
                </form>
			</div>
            
            <div class="sub-nav-title-sm">행사정보</div>		

			<div class="basic-list">
			<form>				
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						<fieldset>
						<legend>행사정보</legend>
							<div class="row-group">	
                            	<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">행사명</label></dt>
									<dd>${promoteDetail.p_title }</dd>
								</dl>
                                <dl class="insert_ready">
									<dt class="must-option"><strong>행사일</strong></dt>
                                    <dd style="width:100px">${cha:todate(promoteDetail.p_date, '-', '3') }</dd>
                                    <dt class="must-option"><strong>행사시간</strong></dt>
                                    <dd style="width:100px">${cha:todate(promoteDetail.start_time, '', '5') } ~ ${cha:todate(promoteDetail.end_time, '', '5') }</dd>
								</dl>
                                <dl class="insert_ready">
									<dt class="must-option"><label for="" id="">행사주체</label></dt>
									<dd>${cha:pTarget(promoteDetail.p_target_code, promoteDetail.p_target_desc)}</dd>
								</dl>
                                <dl class="insert_ready">
									<dt class="must-option"><label for="" id="">에너지밸리 홍보설명</label></dt>
									<dd>${promoteDetail.energy_flag == '0' ? '미신청' : '신청' }</dd>
								</dl>
							</div>
						</fieldset>
					</div>
                </div>
                </div>
			</form>
			</div>            
            <div class="btn-zone" style="float:none;">
                <ul>
                    <c:if test="${left_depth_2 == '3'}">
                    	<c:if test="${promoteDetail.p_status ==  '1' || promoteDetail.p_status ==  '2' }">
                    		<li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funDescShow('cancel');" value="신청취소" style="width:80px"></li>
                    	</c:if>
                    	<c:if test="${promoteDetail.p_status ==  '2' }">
                    		<li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funAct('6');" value="완료" style="width:80px"></li>
                    	</c:if>
                    </c:if>
                    <%-- 관리자 접속 페이지의 경우, 세션의 관리 권한 여부도 체크 --%>
                    <c:if test="${left_depth_2 == '4'}">
                    	<c:set var="promoteAdmChk" value="N"></c:set>
                    	<c:forEach var="admInfoList" items="${sessionScope.SESS_ADMIN_INFO}">
                			<c:if test="${admInfoList.adm_gubun == 1}">
                				<c:set var="promoteAdmChk" value="Y"></c:set>
                			</c:if>
                		</c:forEach>
                    	<c:if test="${promoteAdmChk == 'Y' 
                    					&& promoteDetail.p_status ==  '1' }">
                    		<li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funAct('2');" value="승인" style="width:80px"></li>
                    		<li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funDescShow('reject');" value="반려" style="width:80px"></li>
                    	</c:if>
                    </c:if>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funList();" value="목록으로" style="width:80px"></li>
                </ul>
            </div>



		</div>
		<!--content end-->
	</div>
</div>

<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="cancel_div" class="popup_view_box1" style="display: none; z-index:2; width:415px; background-color: #fff;">
	<h3 style="color:#fff">신청취소</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        취소사유를 적어야만 행사를 취소할 수 있습니다.  
	        <br>행사를 취소하여야 할 경우 내용을 입력해 주시고 확인을 눌러주세요
	    </div>
	    <div class="basic-list" style="margin-top:10px;">
	        <form>				
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option" style="width:100px;"><label for="" id="">취소사유</label></dt>
										<dd><input type="text" id="cancel_desc" name="cancel_desc" maxlength="200" style="width:300x"></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	    <div class="btn-zone">
			<ul>
				<li><input type="button" name="" class="search_btn" style="width:70px;" onclick="javascript:funAct('4')" value="신청취소"></li>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:$('#cancel_div').parent().hide();" value="닫기"></li>
			</ul>
		</div>
	</div>
</div>
 
<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="reject_div" class="popup_view_box1" style="display: none; z-index:2; width:415px; background-color: #fff;">
	<h3 style="color:#fff">반려</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        사용자에게 반려 사유를 적어주세요
	    </div>
	    <div class="basic-list" style="margin-top:10px;">
	        <form>				
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option" style="width:100px;"><label for="" id="">반려사유</label></dt>
										<dd><input type="text" id="reject_desc" name="reject_desc" maxlength="200" style="width:300x"></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	    <div class="btn-zone">
			<ul>
				<li><input type="button" name="" class="search_btn" style="width:70px;" onclick="javascript:funAct('3')" value="반려"></li>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:$('#reject_div').parent().hide();" value="닫기"></li>
			</ul>
		</div>
	</div>
</div> 

<form id="srhFrm" name="srhFrm" method="post">
	${srhReq }
</form>

<script type="text/javascript">
$(document).ready(function() {
	load_fnc('9', '0', '0'); //menu script
});

function funList() {
	if('${left_depth_2}' == 3){
		$('#srhFrm').attr('action','/promote/promoteProgress.do').submit();
	}else{
		$('#srhFrm').attr('action','/promote/promoteMgmt.do').submit();
	}
}

function funDescShow(g){
	$('#' + g + '_div').parent().css('height', $(window).height());
	$('#' + g + '_div').parent().show();
	layerPopupCenter($('#' + g + '_div'));
}

function funAct(g){
	
	var alert_msg = "";
	
	//2-승인, 3-반려, 4-취소, 6-완료
	if(g == '4'){
		alert_msg = "해당 건을 신청 취소하시겠습니까?";
	}else if(g == '6'){
		alert_msg = "해당 건을 완료 처리하시겠습니까?";
	}else if(g == '2'){
		alert_msg = "해당 신청 건을 승인하시겠습니까?";
	}else if(g == '3'){
		alert_msg = "해당 신청 건을 반려하시겠습니까?";
	}
	
	if(confirm(alert_msg)){
	    $.ajax({
	       url: "/promote/insertUpdatePromote.do",
	       type: "POST",
	       data: {'p_seq' : $('input[name=p_seq]').val()
	    	   		,'act_gubun' : g
	    	   		,'cancel_desc' : $('#cancel_desc').val()
	    	   		,'reject_desc' : $('#reject_desc').val()},
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
				   alert('처리 되었습니다.');
				   funList();
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