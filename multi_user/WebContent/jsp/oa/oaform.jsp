<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
.btn_yellow {
	background-color: #ff9620;
	color: #fff;
	font-size: 14px;
}

.btn_blue {
	background-color: #08A0CE;
	color: #fff;
	font-size: 14px;
	padding: 0px 5px;
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
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="6"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub2_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">OA교육장</b>
					</div>
					<div class="nav-title">OA교육장</div>
				</div>
				<div class="sub-nav-title">OA교육장 이용신청</div>

				<div class="basic-list"> 
					
						<div class="insrtfrom-framebox">
							<div class="insert-step1-box">
								<div class="form-step1">
								<fieldset>
									<legend>자료실</legend>
									<div class="row-group">
										<form id="frm" name="frm" method="post">
											<input type="hidden" id="date" name="date" value="${date}" />
											<dl class="insert_ready">
												<dt class="must-option"><label>직원번호</label></dt>
												<dd style="width: 200px;">${SESS_EMPNO }</dd>
											</dl>											
											<dl class="insert_ready">
												<dt class="must-option"><label>성명</label></dt>
												<dd style="width: 200px;">${SESS_USER_NAME }</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>연락처</label></dt>
												<dd style="width: 200px;">${SESS_USER_TELNO }</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>이용시간</label></dt>
												<dd style="width: 500px;">
													${year}년 ${month}월 ${day}일 ${time}시 ~
													<select name="hour" id="hour" onchange="javascript:hourChange(this.value);" style="width:80px;">
													<c:set var="i" value="1"/>
													<c:forEach var="idx" begin="${time+1}" end="18" step="1" varStatus="status">
														<option value="${i}">${idx} 시 사용</option>
														<c:set var="i" value="${i+1}" />
													</c:forEach>
													</select>
													<strong style="letter-spacing:1px;">(<span id="hour_txt" style="color:red;">1</span><span style="color:#000;">시간 이용</span>)</strong>
												</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>이용목적</label></dt>
												<dd><textarea class="textarea-style" rows="5" cols="88" id="subject" name="subject" style="width: 618px;"></textarea></dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>인원</label></dt>
												<dd style="width: 400px;"><input type="text" id="people_cnt" name="people_cnt" value="" maxlength=4 style="ime-mode: disabled;" onkeydown="filterNumber(event);"> 명</dd>
											</dl>											
										</form>
									</div>
									<div class="btn-zone">
										<ul>
											<li><input type="submit" class="search_btn" value="신청" onclick="goSubmit(); return false;"></li>
											<li><input type="button" onclick="goList();" class="search_btn" value="목록"></li>
										</ul>
									</div>
								</fieldset>
								</div>
							</div>
						</div>
					
				</div>
			</div>
			<!--content end-->
		</div>
	</div>

<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   

<script type="text/javascript">

$(document).ready(function(){
	load_fnc('2', '0', '0'); //menu script
})

function hourChange(i) {
	$("#hour_txt").text(i);
}

function goSubmit(){
		if($.trim($('#subject').val()) == ''){
			alert('이용목적을 작성해주세요.');
			$('#subject').focus();
			return false;
		}
		
		if ($('#people_cnt').val() == "" || isNaN($('#people_cnt').val())) {
			alert("인원을 입력하세요");
			$('#people_cnt').focus();
			return false;
		}
		
		var params = {
				"date" : $('#date').val(),
				"hour" : $('#hour').val(),
				"people_cnt" : $('#people_cnt').val(),
				"subject" : escapeHtml($('#subject').text()),
		}
		
		if(confirm('신청하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/registOA.do',
				dataType : 'json',
				data : params,
				success : function(result){		
					console.log(result);
					if (result == "1")
					{
						alert("신청이 완료되었습니다!!!")
						goList();
					}else if(result == "-2")
					{
						alert("이미 신청이 완료된 일시가 존재합니다!!!");
					}else {
						alert("신청하는데 에러가 발생하였습니다");
					}
				},
				error : function(e){
					console.log(e);
				}
			})
		}	
}

var entityMap = { 
		'&': '&amp;', 
		'<': '&lt;', 
		'>': '&gt;', 
		'"': '&quot;', 
		"'": '&#39;', 
		'/': '&#x2F;', 
		'`': '&#x60;', 
		'=': '&#x3D;',
		' ' : '&nbsp;',
		'\n' : '&#10;'
}; 
// 윈도우에서는 돌아가지만 chome에서 돌아가지 않음.
function escapeHtml (string) {
	return String(string).replace(/[&<>"'`=\/\s\\r\\n]/g, function fromEntityMap (s) {
		return entityMap[s]; 
	}); 
} 

function goList(){
	$("#date").val("");
	$('#frm').attr('action', '/oalist.do');
	$('#frm').submit();
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />