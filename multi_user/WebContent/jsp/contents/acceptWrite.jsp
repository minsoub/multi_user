<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />

<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="2" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="7"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용동의 관리</b>
				</div>
				<div class="nav-title">이용동의 등록</div>
			</div>
            
            <div class="sub-nav-title">이용동의 등록</div>
            
			<div class="basic-list">
			<form name="frm" id="frm" method="post">
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						<fieldset>
						<legend>제작요청</legend>
							<div class="row-group">
								<dl class="insert_ready">
									<dt class="must-option"><label>등록자</label></dt>
									<dd>
										<input type="hidden" id="AC_DEPT" name="AC_DEPT" value="${userImp.DEPTNO }">
										<input type="hidden" id="AC_REG_USER" name="AC_REG_USER" value="${userImp.EMPNO }">
										<input type="text" id="AC_REG_NAME" name="AC_REG_NAME" value="${userImp.NAME }" readonly="readonly">
									</dd>
									<dt class="must-option"><label>등록일</label></dt>
									<dd>
										<input type="text" id="AC_REG_DATE" name="AC_REG_DATE" value='<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />' readonly="readonly">
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label>이용동의 선택</label></dt>
									<dd><label for="AC_STATUS_H"><input type="radio" id="AC_STATUS_H" name="AC_STATUS" value="S">선택&nbsp;&nbsp;&nbsp;</label>
										<label for="AC_STATUS_S"><input type="radio" id="AC_STATUS_S" name="AC_STATUS" value="H" checked="checked">미선택</label>
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label>제목</label></dt>
									<dd><input type="text" style="width:580px;" id="AC_TITLE" name="AC_TITLE" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label>이용동의 내용</label></dt>
									<dd><textarea class="textarea-style" rows="10" cols="88" id="AC_CONTENTS" name="AC_CONTENTS"></textarea></dd>
								</dl>
							</div>
							<div class="btn-zone">
								<ul>
									<li><input type="button" name="srchDescription" class="search_btn" onclick="save();" value="등록"></li>
	<!-- 							<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:void(0);" value="취소"></li> -->
								</ul>
							</div>
						</fieldset>
					</div>
				</div>
			</div>
			</form>
			</div>
		</div>
		<!--content end-->
	</div>
</div>
</body>
<script type="text/javascript">

function save(){
	var radioChk = $("input:radio[name='AC_STATUS']:checked").val();
	var AC_DEPT = $("#AC_DEPT").val();
	var AC_REG_USER = $("#AC_REG_USER").val();
	var AC_REG_NAME = $("#AC_REG_NAME").val();
	var AC_REG_DATE = $("#AC_REG_DATE").val();
	var AC_TITLE = $("#AC_TITLE").val();
	var AC_CONTENTS = $("#AC_CONTENTS").val();
	var AC_STATUS = $("#AC_STATUS").val();
	
	if(AC_REG_USER == ""){
		alert('등록자를 입력해주십시오.');
		return false;
	}else if(AC_REG_DATE == ""){
		alert('등록일을 입력해주십시오');
		return false;
	}else if(AC_TITLE == ""){
		alert('제목을 입력해주십시오.');
		$("#AC_TITLE").focus();
		return false;
	}else if(radioChk == "" || radioChk == undefined){
		alert('약관내용을 선택해 주십시오');
		return false;
	}else if(AC_CONTENTS == ""){
		alert('약관동의 내용을 입력해 주십시오.');
		$("#AC_CONTENTS").focus();
		return false;
	}

   	if(confirm("등록 하시겠습니까?")){
   		var f = document.frm;
   		var url = "";
   		var DataVal = {"AC_DEPT": AC_DEPT,
   					"AC_REG_USER": AC_REG_USER,
   					"AC_REG_NAME": AC_REG_NAME,
   					"AC_TITLE": AC_TITLE,
   					"AC_CONTENTS": AC_CONTENTS,
   					"AC_STATUS": radioChk
   		};
   		$.ajax({
   			type:"POST",
   			url:"/registAcceptAjax.do",
   			data : DataVal,
   			dataType : "json",
   			success: function(result){
   				if(result > 0){
   					console.log(result);
   					alert("등록되었습니다.");
   					url = '/acceptList.do';
   				}else{
   					console.log(result);
   					alert("관리자에게 문의하세요.");
   				}
   			},
   			error: function(xhr, status, error) {
   				alert(error);
   			},complete: function(){
   				f.target = '_self';
   				f.action = url;
   				f.submit();
   			}
   		});
   	}else{
		return false;
   	}
}

function numkeyCheck(e) {
    var keyValue = event.keyCode;
    if( ((keyValue >= 48) && (keyValue <= 57)) ) return true;
    else return false;
}

$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
	
	/* $("#datepicker").datepicker();
	$("#datepicker2").datepicker(); */
	/* 
	$('input:radio[name="SM_SVC2"]').change(function(){
		$('#work').show();
		var resultNum = $(this).val();
		multiNum(resultNum);
		//console.log(resultNum);
		//기타일경우 추가.
		if("3092" == resultNum){
			$("#MULTIPAGE").width(300);
			$(".giTaBox").show();
			$(".work_input").hide();
			$(".workView_btn").hide();
		}else{
			$("#MULTIPAGE").width(100);
			$(".giTaBox").hide();
			$(".work_input").show();
			$(".workView_btn").show();
		}
		$("#MULTIPAGE").val("");
	});
	 */
	/* $('#datepicker').change(function(){
		var newDay =  $(this).val();
			newDayArray = newDay.split("-");
			toDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			toDayOg.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			lastDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			workDayCalculation();
	}); */
	/* 
	$('#MULTIPAGE').keyup(function(){
		toDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		lastDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		resultNum = $(this).val();  //입력된 값
		workDayCalculation();
	});
	 */
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />