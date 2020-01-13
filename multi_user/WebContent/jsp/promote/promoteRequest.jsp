<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />
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
				<c:param name="left_depth_2" value="2"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox"> 
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">행사신청</b>
				</div>
				<div class="nav-title">행사신청</div>
			</div>
            
            <div class="sub-nav-title-sm">신청자 정보</div>		

			<div class="basic-list">
                    <div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
                            <legend>신청자 정보</legend>
                                <div class="row-group">	
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>신청부서</strong></dt>
                                        <dd style="width:200px">${sessionScope.SESS_USER_INFO['user_dept_name']}</dd> 
                                        <dt class="must-option"><strong>신청자</strong></dt>
                                        <dd style="width:200px">${sessionScope.SESS_USER_INFO['name']}</dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>전화번호</strong></dt>
                                        <dd style="width:200px">${sessionScope.SESS_USER_INFO['telno']}</dd>
                                        <dt class="must-option"><strong>이메일</strong></dt>
                                        <dd style="width:200px">${sessionScope.SESS_USER_INFO['mailno']}@kepco.co.kr</dd>
                                    </dl>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    </div>
			</div>
            
            <div class="sub-nav-title-sm">행사정보</div>		
			<form id="frm" name="frm" method="post">
			<input type="hidden" id="act_gubun" name="act_gubun" value="insert">
				<div class="basic-list">
					<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>행사정보</legend>
								<div class="row-group">	
	                            	<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">행사명</label></dt>
										<dd><input type="text" id="p_title" name="p_title" style="width:598px" maxlength="100"></dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">행사일</label></dt>
										<dd style="width:235px;">                                    
	                                            <fieldset>	
	                                                <div class="form-group">
	                                                    <legend>행사일</legend>                        
	                                                    <div>
	                                                        <input type="text" name="p_date" id="p_date" readonly value=''
	                                    style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
								                        </div>
	                                                </div>
	                                            </fieldset>
	                                    </dd>
	                                    <dt class="must-option"><label for="" id="">행사시간</label></dt>
										<dd style="width:235px;">               
	                                            <fieldset>	
	                                                <div class="form-group">
	                                                    <legend>행사시간</legend>                        
	                                                    <div>
	                                                    	<select name="start_time1" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
															<option value="">시</option>
															<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
																<c:set var="i_num" value=""/>
																<c:if test="${i_status.index < 10}">
																	<c:set var="i_num" value="0"/>
																</c:if>
																<option value="${i_num}${i}">${i}</option>
															</c:forEach>
															</select>
															
															<select name="start_time2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
															<option value="">분</option>
															<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
																<c:set var="j_num" value=""/>
																<c:if test="${j_status.index < 10}">
																	<c:set var="j_num" value="0"/>
																</c:if>
																<option value="${j_num}${j}">${j}</option>
															</c:forEach>
															</select>
	                                                         -
	                                                        <select name="end_time1" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
															<option value="">시</option>
															<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
																<c:set var="i_num" value=""/>
																<c:if test="${i_status.index < 10}">
																	<c:set var="i_num" value="0"/>
																</c:if>
																<option value="${i_num}${i}">${i}</option>
															</c:forEach>
															</select>
															
															<select name="end_time2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
															<option value="">분</option>
															<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
																<c:set var="j_num" value=""/>
																<c:if test="${j_status.index < 10}">
																	<c:set var="j_num" value="0"/>
																</c:if>
																<option value="${j_num}${j}">${j}</option>
															</c:forEach>
															</select>
								                        </div>
	                                                </div>
	                                            </fieldset>
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">행사주체</label></dt>
										<dd>                                                                                
	                                        <input type="radio" id="p_target_code1" name="p_target_code" value="1" class="checks small" checked="checked"> 
	                                        <label for="p_target_code1">CEO</label>
	                                        <input type="radio" id="p_target_code2" name="p_target_code" value="2" class="checks small" style="margin-left:15px"> 
	                                        <label for="p_target_code2">본부장</label>
	                                        <input type="radio" id="p_target_code3" name="p_target_code" value="3" class="checks small" style="margin-left:15px"> 
	                                        <label for="p_target_code3">기타</label>
	                                        <input type="text" id="p_target_desc" name="p_target_desc" placeholder="" style="width:200px" maxlength="15">
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">에너지밸리 홍보설명</label></dt>
										<dd>
	                                        <input type="radio" id="energy_flag2" name="energy_flag" value="0" class="checks small" checked="checked"> 
	                                        <label for="energy_flag2">미신청</label>
											<input type="radio" id="energy_flag1" name="energy_flag" value="1" class="checks small" style="margin-left:15px"> 
	                                        <label for="energy_flag1">신청</label>
										</dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	                </div>
				</div>
            </form>
            
            <div class="btn-zone">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSave();" value="신청"></li>
                </ul>
            </div>	
		</div>
		<!--content end-->
	</div>
</div>

<script type="text/javascript">

$(document).ready(function() {
	load_fnc('9', '0', '0'); //menu script
	$('#p_date').datepicker();
});


function funSave(){       
    if (document.frm.p_title.value == "" ) {
		alert("행사명을 입력하세요");
		document.frm.p_title.focus();
		return false;
	}
	
	if(document.frm.p_date.value == ""){
		alert("행사 시작일자를 입력하세요");
		document.frm.p_date.focus();
		return false;
	}
	
	if(document.frm.start_time1.value == ""){
		alert("행사 시작시간을 입력하세요");
		document.frm.start_time1.focus();
		return false;
	}
	
	if(document.frm.start_time2.value == ""){
		alert("행사 시작시간의 '분'을 입력하세요");
		document.frm.start_time2.focus();
		return false;
	}
	
	if(document.frm.end_time1.value == ""){
		alert("행사 종료시간을 입력하세요");
		document.frm.end_time1.focus();
		return false;
	}
	
	if(document.frm.end_time2.value == ""){
		alert("행사 종료시간의 '분'을 입력하세요");
		document.frm.end_time2.focus();
		return false;
	}
	
	if(document.frm.end_time1.value < document.frm.start_time1.value){
		alert("행사 종료시간을 확인하시기 바랍니다.");		
		document.frm.end_time1.focus();
		return false;
	}
	
	if(document.frm.end_time1.value == document.frm.start_time1.value
			&& document.frm.end_time2.value < document.frm.start_time2.value){
		alert("행사 종료시간을 확인하시기 바랍니다.");		
		document.frm.end_time2.focus();
		return false;
	}
	 
	if($('#p_target_code3').is(':checked')){
		if($.trim($('#p_target_desc').val()) == ''){
			alert('행사주체를 입력하시기 바랍니다.');
			$('#p_target_desc').focus();
			return false;
		}
	}
	
	if(confirm('입력하신 정보로 신청하시겠습니까?')){
		dataString = $("#frm").serialize();
		
	    $.ajax({
	       url: "/promote/insertUpdatePromote.do",
	       type: "POST",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
				   alert('신청 되었습니다.');
				   location.replace('/promote/promoteProgress.do');
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