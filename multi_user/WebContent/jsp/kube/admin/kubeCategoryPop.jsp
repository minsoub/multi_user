<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_pop_meta.jsp" />
<body>
	<div class="popup_view_box1" style="background-image: url('/resource/kube_images/top_bg.png');">
	<c:if test="${fn:length(s) == 0}">
		<c:set var="title_gubun" value="등록" />
	</c:if>
	<c:if test="${fn:length(s) > 0}">
		<c:set var="title_gubun" value="변경" />
	</c:if>
	<c:if test="${ct == 1}">
	<h3 style="color:#fff;">1차 카테고리 ${title_gubun }</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="frm" name="frm" method="post">
	        <input type="hidden" id="s" name="s" value="${s}" /> 
	        <input type="hidden" id="p" name="p" value="0" />
	        <input type="hidden" id="p_code_seq" name="p_code_seq" value="0" />
	        <input type="hidden" id="ct"name="ct" value="${ct}" />
	        <input type="hidden" id="act_gubun" name="act_gubun" /> 
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
	                                	<c:set var="code_desc" value="" />
	                                	<c:set var="etc_info" value="" />
	                            		<c:forEach var="category" items="${kubeLeftMenuList}" varStatus="status">
			                                <c:if test="${category.code_seq == s}"> 
			                                	<c:set var="code_desc" value="${category.code_desc }" />          
			                                	<c:set var="etc_info" value="${category.etc_info }" />           
			                                </c:if>
		                                </c:forEach> 
										<dt class="must-option2" style="width:100px;"><label for="" id="" class="must_option2_label" style="font-weight: normal;">1차 카테고리</label></dt>
										<dd><input type="text" id="code_desc" name="code_desc" placeholder="ex) 한전News , 교육" value="${code_desc}" style="width:203px"></dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option2" style="width:100px;"><label for="" id="" class="must_option2_label" style="font-weight: normal;">카테고리 영문</label></dt>
										<dd><input type="text" id="etc_info" name="etc_info" placeholder="ex) kepcoNews , edu" value="${etc_info}" style="width:203px"></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	</c:if>
	<c:if test="${ct == '2'}">
	<h3 style="color:#fff">2차 카테고리 ${title_gubun }</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="frm" name="frm" method="post">
	        <input type="hidden" id="s" name="s" value="${s}" /> 
	        <input type="hidden" id="p" name="p" value="${p}" /> 
	        <input type="hidden" id="ct"name="ct" value="${ct}" />
	        <input type="hidden" id="act_gubun" name="act_gubun" /> 
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option2" style="width:100px;"><label for="" id="" class="must_option2_label" style="font-weight: normal;">1차 카테고리</label></dt>
										<dd>                                    
	                                        <fieldset>	
	                                            <div class="form-group">
	                                                <div>
	                                                    <p class="inputDesign">
	                                                    <c:set var="code_desc" value="" />
	                                                    <select name="p_code_seq" style="width:200px;height: 80px;">
						                            		<c:forEach var="category" items="${kubeLeftMenuList}" varStatus="status">
						                            			<c:if test="${category.p_code_seq == 0}">
								                                	<option value="${category.code_seq}" ${category.code_seq == p ? 'selected' : ''}>${category.code_desc }</option> 
								                                </c:if>
								                                <c:if test="${category.code_seq == s}">
								                                	<c:set var="code_desc" value="${category.sub_code_desc }" />
								                                </c:if>
							                                </c:forEach>
	                                                    </select>
				                        			</div>
	                                            </div>
	                                        </fieldset>
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option2" style="width:100px;"><label for="" id="" class="must_option2_label" style="font-weight: normal;">2차 카테고리</label></dt>
										<dd><input type="text" id="code_desc" name="code_desc" value="${code_desc}" style="width:203px"></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>
	</c:if>
	<c:if test="${ct == 14}">
	<h3 style="color:#fff">신고 카테고리 ${title_gubun }</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="frm" name="frm" method="post">
	        <input type="hidden" id="s" name="s" value="${s}" /> 
	        <input type="hidden" id="p" name="p" value="0" />
	        <input type="hidden" id="p_code_seq" name="p_code_seq" value="0" />
	        <input type="hidden" id="ct"name="ct" value="${ct}" />
	        <input type="hidden" id="act_gubun" name="act_gubun" /> 
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1"> 
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
	                                	<c:set var="code_desc" value="" />
	                                	<c:set var="etc_info" value="" />
	                            		<c:forEach var="category" items="${codeList}" varStatus="status">
			                                <c:if test="${category.code_seq == s}"> 
			                                	<c:set var="code_desc" value="${category.code_desc }" />          
			                                </c:if>
		                                </c:forEach>
										<dt class="must-option2" style="width:100px;"><label for="" id="" class="must_option2_label" style="font-weight: normal;">카테고리</label></dt>
										<dd><input type="text" id="code_desc" name="code_desc" placeholder="ex) 불쾌함, 노출" value="${code_desc}" style="width:203px"></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	</c:if>
	    <div class="btn-zone">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funCUD('','${ct}');" value="저장"></li>
				<c:if test="${fn:length(s) != 0}">
	            	<li><input type="button" name="" class="search_btn" onclick="javascript:funCUD('d','${ct}');" value="삭제"></li>
	            </c:if>
				<li><input type="button" name="" class="search_btn" onclick="javascript:funCancel();" value="닫기"></li>
			</ul>
		</div>
	</div>
</body>
</html>
<script>
$(document).ready(function(){
	$('select[name=p_code_seq]').prev().css('height','150px');
})

function funCancel(){
	window.self.close();
}

function funCUD(param, param2){
	var alert_msg = '저장';
	var alert_msg2 = '';
	
	if($.trim($('#code_desc').val()) == ''){
		alert('카테고리명을 입력하시기 바랍니다.');
		$('#code_desc').focus();
		return false;
	}
	
	if(param == 'd'){
		$('#act_gubun').val('d');
		alert_msg = '삭제';
		alert_msg2 = '\n삭제시 해당 카테고리에 있는 영상도 모두 삭제 됩니다.\n정말 삭제하시겠습니까?';
	}else{
		if($.trim($('#s').val()) == ''){
			$('#act_gubun').val('c');
		}else{
			$('#act_gubun').val('u');
		}
		
		if(param2 == '1'){
			if($.trim($('#etc_info').val()) == ''){
				alert('카테고리 영문표기를 입력하시기 바랍니다.');
				$('#etc_info').focus();
				return false;
			}
		}
	}
	
	if(confirm('카테고리를 ' + alert_msg + '하시겠습니까?' + alert_msg2)){
		dataString = $("#frm").serialize();
		
	    $.ajax({
	       url: "/kubeCategoryInsertUpdate.do",
	       type: "POST",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
				   alert(alert_msg + ' 되었습니다.');
				   opener.location.replace('/kubeCategoryMgmt.do');
				   funCancel();
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