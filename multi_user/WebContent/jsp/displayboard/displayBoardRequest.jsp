<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />

<c:set var="SM_MEMPNO" 	value="${MEMPNO }"/>
<c:set var="SM_MCCD" 	value="1133"/>

<c:forEach items="${userStatus}" var ="userStart" varStatus="statis">
<c:set var="userinfo" value="${userStatus[0] }"/>
<c:set var="userdepth" value="${userStatus[1] }"/>
</c:forEach>

<c:forEach items="${userinfo}" var ="userinfo" >
<c:set var="SM_MNAME" 	value="${userinfo.NAME}"/>
<c:set var="SM_MTEL" 	value="${userinfo.TELNO}"/>
<c:set var="SM_MCEL" 	value=""/>
<c:set var="SM_MEMAIL" 	value="${userinfo.MAILNO}@kepco.co.kr"/> 
</c:forEach>
<c:forEach items="${userdepth}" var ="userdepth" >
<c:set var="deptC1" value="${userdepth.DE_CODE1}" />
<c:set var="deptN1" value="${userdepth.DE1}" />
<c:set var="deptC2" value="${userdepth.DE_CODE2}" />
<c:set var="deptN2" value="${userdepth.DE2}" />
<c:set var="deptC3" value="${userdepth.DE_CODE3}" />
<c:set var="deptN3" value="${userdepth.DE3}" />
<c:set var="deptC4" value="${userdepth.DE_CODE4}" />
<c:set var="deptN4" value="${userdepth.DE4}" />
</c:forEach>

<c:set var="SM_MC1CD" 	value="${deptC1}"/>
<c:set var="SM_MC1NAME" value="${deptN1}"/>
<c:set var="SM_MC2CD"	value="${deptC2}"/>
<c:set var="SM_MC2NAME" value="${deptN2}"/>
<c:set var="SM_MDCD" 	value="${deptC3}"/>
<c:set var="SM_MDNAME" 	value="${deptN3}"/>
<c:set var="SM_MTCD" 	value="${deptC4}"/>
<c:set var="SM_MTNAME" 	value="${deptN4}"/>

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
				<c:param name="left_depth_2" value="2"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub3_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;전광판게시  &nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">게시신청</b>
				</div>
				<div class="nav-title">전광판 게시 <small class="sub2">게시신청</small></div>
			</div>
			
			<div class="tabNav sub2">
				<li><a href="/displayBoardInfo.do">이용안내</a></li>
				<li><a href="#" class="active">게시신청</a></li>
				<li><a href="/displayBoardProgress.do">진행사항</a></li>
			</div>

	
			<div class="basic-list">
				<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
								<legend>게시신청</legend>
								<div class="sub-nav-title">게시사항 기재</div>
								<form:form name="frm" id="frm" action="/displayBoard/Insert.do" method="post"  enctype="multipart/form-data"  modelAttribute="frm" >
									<input type="hidden" name="SM_MEMPNO" 	value='<c:out value="${SM_MEMPNO}" />'><!-- 신청자사번 -->
									<input type="hidden" name="SM_MCCD" 	value='<c:out value="${SM_MCCD}" />'><!-- 회사코드 -->
									<input type="hidden" name="SM_MC1CD" 	value='<c:out value="${SM_MC1CD}" />'><!-- 부서코드1 -->
									<input type="hidden" name="SM_MC1NAME" 	value='<c:out value="${SM_MC1NAME}" />'><!-- 부서명1 -->
									<input type="hidden" name="SM_MC2CD" 	value='<c:out value="${SM_MC2CD}" />'><!-- 부서코드2 -->
									<input type="hidden" name="SM_MC2NAME" 	value='<c:out value="${SM_MC2NAME}" />'><!-- 부서명2 -->
									<input type="hidden" name="SM_MDCD" 	value='<c:out value="${SM_MDCD}" />'><!-- 부서코드3 -->
									<input type="hidden" name="SM_MTCD" 	value='<c:out value="${SM_MTCD}" />'><!-- 부서코드4 -->
									<input type="hidden" name="SM_MTNAME" 	value='<c:out value="${SM_MTNAME}" />'><!-- 부서명4 -->
						
									<input type="hidden" name="strID" 		value='<c:out value="${strID}" />'>
									<input type="hidden" name="strID2" 		value='<c:out value="${SCT_SEQ}" />'>
									<input type="hidden" name="minDay" 		value='<c:out value="${biz_date_over_3}" />'><!-- 게시 가능한 최소 게시일 ...-->
									<input type="hidden" name="strMDiv1" 	value='<c:out value="${strMDiv1}" />'>
									<input type="hidden" name="strMDiv2" 	value='<c:out value="${strMDiv2}" />'>
									<input type="hidden" name="sDiv" 		value='<c:out value="${sDiv}" />'><!-- 서비스 구분 -->
									<input type="hidden" name="page" 		value='<c:out value="${page}" />'>
									<input type="hidden" name="s1" 			value='<c:out value="${s1}" />'>
									<input type="hidden" name="s2" 			value='<c:out value="${s2}" />'>
									<input type="hidden" name="s3" 			value='<c:out value="${s3}" />'>
									<input type="hidden" name="s4" 			value='<c:out value="${s4}" />'>
									
									<input type="hidden" name="AC_SEQ" id="AC_SEQ" value="${accptContents.AC_SEQ == '' ? 0 : accptContents.AC_SEQ}">
									<input type="hidden" name="AC_STATUS" id="AC_STATUS" value="S">
									<input type="hidden" id="fileSeq_1" name="fileSeq_1">
									<input type="hidden" id="fileSeq_2" name="fileSeq_2">
									<input type="hidden" id="fileSeq_3" name="fileSeq_3">
								
									<div class="row-group">
										<dl class="insert_ready">
											<dt class="must-option"><label for="SM_MDNAME" id="SM_MDNAME_label">신청부서</label></dt>
											<dd><input type="text" id="SM_MDNAME" name="SM_MDNAME" title="" placeholder="" value='<c:out value="${SM_MDNAME }"></c:out>' readonly="readonly"></dd>
											<dt class="must-option"><label for="SM_MNAME" id="SM_MNAME_label">신청자</label></dt>
											<dd class="btn-zone" style="width: 250px;">
												<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1  }">
													<input type="text" id="SM_MNAME" name="SM_MNAME" title="" class="schword"  style="width: 40%" placeholder="" value='<c:out value="${SM_MNAME }"></c:out>'>
													<input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
												</c:if>
												<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO lt 1 }">
													<input type="text" id="SM_MNAME" name="SM_MNAME" title=""  style="width: 40%" placeholder="" value='<c:out value="${SM_MNAME }"></c:out>' readonly="readonly">
												</c:if>
											</dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label for="SM_MTEL" id="SM_MTEL_label">전화번호</label></dt>
											<dd><input type="text" id="SM_MTEL" name="SM_MTEL" title="" placeholder="" value='<c:out value="${SM_MTEL }"></c:out>' readonly="readonly"></dd>
											<dt class="must-option"><label for="SM_MEMAIL" id="SM_MEMAIL_label">E-MAIL</label></dt>
											<dd style="width: 250px;"><input type="text" id="SM_MEMAIL" name="SM_MEMAIL" title="" placeholder="" value='<c:out value="${SM_MEMAIL }"></c:out>' readonly="readonly"></dd>
										</dl>
										
										<dl class="insert_ready">
											<dt class="must-option"><label for="SSTART" id="SSTART_label">서비스 요청일</label></dt>
											<dd>
												<input type="text" id="datepicker" name="SSTART" value='<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />' readonly="readonly">
											</dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">제목</label></dt>
											<dd><input type="text" id="SM_TITLE" name="SM_TITLE" title="" placeholder="" value=""></dd>
										</dl>
										<dl class="insert_ready" style="font-weight: normal;">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">게시장소</label></dt>
											
											<c:forEach items="${categoreyList}" var ="categoreyList" varStatus="cstatis">
											<dd>
												<div class="checks small">
												  <input type="checkbox" id="ex_chk_${cstatis.index}" name="SM_SVC2" value="<c:out value="${categoreyList.CD2_CODE}" />"> 
												  <label for="ex_chk_${cstatis.index}"><c:out value="${categoreyList.CD2_NAME}" /></label> 
												</div>
											</dd>
											</c:forEach>
											
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label for="SM_MTEL" id="SM_MTEL_label">게시일시</label></dt>
											<dd>
												<input type="text" name="STIME1" id="STIME1" value=""
				                                      style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
				                                      
												<select name="STIME2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
												<option value="">시</option>
												<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
													<c:set var="i_num" value=""/>
													<c:if test="${i_status.index < 10}">
														<c:set var="i_num" value="0"/>
													</c:if>
													<option value="${i_num}${i}">${i}</option>
												</c:forEach>
												</select>
				                                      
												<select name="STIME3" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
												<option value="">분</option>
												<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
													<c:set var="j_num" value=""/>
													<c:if test="${j_status.index < 10}">
														<c:set var="j_num" value="0"/>
													</c:if>
													<option value="${j_num}${j}">${j}</option>
												</c:forEach>
												</select>
												
												
												<input type="text" name="ETIME1" id="ETIME1" value=""
				                                      style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
												<select name="ETIME2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
												<option value="">시</option>
												<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
													<c:set var="i_num" value=""/>
													<c:if test="${i_status.index < 10}">
														<c:set var="i_num" value="0"/>
													</c:if>
													<option value="${i_num}${i}">${i}</option>
												</c:forEach>
												</select>
												<select name="ETIME3" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
												<option value="">분</option>
												<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
													<c:set var="j_num" value=""/>
													<c:if test="${j_status.index < 10}">
														<c:set var="j_num" value="0"/>
													</c:if>
													<option value="${j_num}${j}">${j}</option>
												</c:forEach>
												</select>
											</dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">게시문구</label></dt>
											<dd><textarea class="textarea-style" rows="10" cols="88" name="SM_TEXT"></textarea></dd>
										</dl>
									</div>
								</form:form>
								<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
								<input type="hidden" id="SCF_SEQ" name="SCF_SEQ" value="0" />
								<input type="hidden" id="target_file" name="target_file" value=""/>
								<input type="hidden" id="tmp_EMPNO" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
								<div class="insrtfrom-framebox1">
									<div class="insert-step1-box">
										<div class="form-step1" style="margin-top: -15px;">
											<div class="row-group">
												<dl class="insert_ready3">
													<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일1</label></dt>
													<dd class="must-option2-dd">
														<div class="filebox">
				 											<input class="upload-name" value="파일선택" disabled="disabled">
				  											<label for="files1">업로드</label> 
															<input class="upload-hidden" name="uploadFile1" id="files1" type="file" />
															&nbsp<progress id="progressBar_1" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_1" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_1">0</font>%</span>
														</div>
													</dd>
												</dl>
												<dl class="insert_ready3">
													<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일2</label></dt>
													<dd class="must-option2-dd">
														<div class="filebox">
				 											<input class="upload-name" value="파일선택" disabled="disabled">
				  											<label for="files2">업로드</label> 
															<input class="upload-hidden" name="uploadFile2" id="files2" type="file" />
															&nbsp<progress id="progressBar_2" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_2" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_2">0</font>%</span>
														</div>
													</dd>
												</dl>
												<dl class="insert_ready3">
													<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일3</label></dt>
													<dd class="must-option2-dd">
														<div class="filebox">
				 											<input class="upload-name" value="파일선택" disabled="disabled">
				  											<label for="files3">업로드</label> 
															<input class="upload-hidden" name="uploadFile3" id="files3" type="file" />
															&nbsp<progress id="progressBar_3" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_3" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_3">0</font>%</span>
														</div>
													</dd>
												</dl>
											</div>
										</div>
									</div>
								</div>
								</form>
								<!-- 약관동의 내용 -->
								<c:if test="${fn:length(accptContents.AC_CONTENTS) != 0}">
									<div class="admin-nav-title blue-f" style="display: inline-block;padding: 0px 0 10px 0">이용동의</div>
									<div>
										<div style="width: 100%; height: 100px;border: 1px solid #a9abae;overflow-y:auto;word-break: break-all">
											<c:out value="${accptContents.AC_CONTENTS }" escapeXml="false"></c:out>
										</div>
										<input type="checkbox" name="sts_Chk" id="sts_Chk" value=""><label for="sts_Chk"> 내용에 동의 합니다.</label>
									</div>
								</c:if>
								<!-- 약관동의 내용 End -->
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
			</div>
			<!-- 
			<div class="text_box">
				<div class="test_box_layer">
				<p>발전자회사 및 전력거래소는 자체 제작 후 게시신청시 파일첨부하시거나</p>
				<p>한전에 제작 요청시, 게신 신청란에 <font color="RGB(250,150,32)">"한전제작요청"</font>이라고 명시하시기 바랍니다.<font color="black">(제작비용은 신청 자회사 부담)</font></p>
				<p>관리부서 : ICT인프라처 ICT서비스부, 제작 및 게시 : 멀티미디어센터 (061-6382)</p>
				</div>
			</div>
			 -->			
		</div>
		<!--content end-->
	</div>
</div>
</body>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	load_fnc('3', '0', '0'); //menu script
/* 	$('#datepicker').datepicker();
  
	$("#MULTIPAGE").width(350);
	$(".giTaBox").show();
	$(".workView_btn").hide();
	 */
	 $('#STIME1').datepicker({
		dateFormat: "yy-mm-dd",
		minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
		onClose: function( selectedDate ) {
			// 시작일(fromDate) datepicker가 닫힐때
			// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			$("#ETIME1").datepicker( "option", "minDate", selectedDate );
		}
	 });
	 
	//종료일
	$('#ETIME1').datepicker({
		dateFormat: "yy-mm-dd",
		minDate: 0, // 오늘 이전 날짜 선택 불가
		onClose: function( selectedDate ) {
			// 종료일(toDate) datepicker가 닫힐때
			// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
			$("#STIME1").datepicker( "option", "maxDate", selectedDate );
		}
	});
	 
});


function save(){
	if (document.frm.SM_MDNAME.value == "" ) {
		alert("신청부서를 입력 하십시오.");
		document.frm.SM_MDNAME.focus();
		return false;
	}
	if (document.frm.SM_MNAME.value == "" ) {
		alert("신청자 이름을 입력 하십시오.");
		document.frm.SM_MNAME.focus();
		return false;
	}
	if (document.frm.SM_MTEL.value == "") {
		alert("전화번호를 입력 하십시오.");
		document.frm.SM_MTEL.focus();
		return false;
	}
	var SM_MEMAIL = document.frm.SM_MEMAIL.value;
	// 정규식 - 이메일 유효성 검사
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if (!regEmail.test(SM_MEMAIL)){
			alert("이메일 형식에 맞게 입력 하십시오.");
			document.frm.SM_MEMAIL.focus();
			return false;
	}
	if(document.frm.SM_TITLE.value == ""){
		alert("제목을 입력 하십시오.");
		document.frm.SM_TITLE.focus();
		return false;
	}
	
	/* 
	if (document.frm.MULTIPAGE.value == "" ){
		alert("서비스 세부내용을 입력 하십시오.");
		document.frm.MULTIPAGE.focus();
		return false;
	}
	 */
	var ckBox = $("input:checkbox[name='SM_SVC2']").is(":checked");
	if (ckBox == false) {
		alert("게시 신청할 장소를 하나 이상 선택 하십시오.");
		return false;
	}
	if(document.frm.STIME1.value == ""){
		alert("게시 시작일자를 선택 하십시오.");
		document.frm.STIME1.focus();
		return false;
	}
	
	// 최소신청일자 3일...
	if(document.frm.STIME1.value < document.frm.minDay.value){
		alert("게시 시작일자는 오늘 날짜로부터 공휴일을 제외한 3일 이후("+document.frm.minDay.value+")를 선택해주시기 바랍니다.");
		document.frm.STIME1.focus();
		return false;
	}
	
	if(document.frm.STIME2.value == ""){
		alert("시간을 선택 하십시오.");
		document.frm.STIME2.focus();
		return false;
	}
	if(document.frm.STIME3.value == ""){
		alert("시간의 '분'을 선택 하십시오.");
		document.frm.STIME3.focus();
		return false;
	}
	if(document.frm.ETIME1.value == ""){
		alert("게시 종료일자를 선택 하십시오.");
		document.frm.ETIME1.focus();
		return false;
	}
	
	if(document.frm.ETIME2.value == ""){
		alert("시간을 선택 하십시오.");
		document.frm.ETIME2.focus();
		return false;
	}
	
	if(document.frm.ETIME3.value == ""){
		alert("시간의 '분'을 선택 하십시오.");
		document.frm.ETIME3.focus();
		return false;
	}
	
	var sttime = document.frm.STIME1.value + document.frm.STIME2.value + document.frm.STIME3.value;
	var edtime = document.frm.ETIME1.value + document.frm.ETIME2.value + document.frm.ETIME3.value;
	
	sttime = sttime.replace(/\-/g, '');
	edtime = edtime.replace(/\-/g, '');
	
	if(sttime > edtime){
		alert("게시 종료일, 시간을 확인하시기 바랍니다.");
		return false;
	}
	
	if (document.frm.SM_TEXT.value == "" ) {
		alert("게시 내용 또는 문구를 입력 하십시오.");
		document.frm.SM_TEXT.focus();
		return false;
	}
	
	if($("#files1").val() == '' && $("#files2").val() == '' && $("#files3").val() == ''){
		alert("최소 1개이상 파일을 첨부해 주십시오.");
		return false;
	}


	if($('#sts_Chk').length != 0){
		var AC_STATUS = $("input:checkbox[name='sts_Chk']").is(":checked");
		if (AC_STATUS != true ) {
			alert("이용동의를 체크 하십시오.");
			return false;
		}
	}
	
	if(confirm('게시사항을 등록하시겠습니까?')){
		$('#frm').submit();
	}
}

var fileTarget = $('.filebox .upload-hidden');
fileTarget.on('change', function(){  // 값이 변경되면
  if(window.FileReader){  // modern browser
    var filename = $(this)[0].files[0].name;
  } 
  else {  // old IE
    var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
  }
  // 추출한 파일명 삽입
  $(this).siblings('.upload-name').val(filename);
});



$(".schbtn").click(function(e) {
	searchMember(e, this);
});

function searchMember(e, this_obj){
	
	e.preventDefault();

    var obj = $(this_obj);
    var schword = obj.siblings('.schword');

    if( !$.trim(schword.val()) )
    {
        alert('이름/사번을 입력하여 주십시요.');
        schword.focus();
        return false;
    }

    $.ajax({
        url : '/admin/searchMember.do',
        type : 'post',
        data : { 'mode':'search_member', 'keyword':$.trim(schword.val()) },
        success : function(data) {

            var parse_data = $.parseJSON(data).memberList;
            var data_len = parse_data.length;
            var arr = {};
            arr.key = $('.schbtn').index(obj);

            if(data_len)
            {
            	$('#mem_list_layer').remove();
                var html = "<div id='mem_list_layer'><table width='450'>";
                html += "<colgroup><col width='100' /><col width='100' /><col width='300 /></colgroup>";
                html += "<tr id='_title'><th height='30' class='titbg'>사번</th>";
                html += "<th class='titbg'>이름</th>";
                html += "<th class='titbg'>소속</th></tr>";

                $.each(parse_data, function() {
                	arr.deptno = this.deptno;
                    arr.empno = this.empno;
                    arr.name = this.name;
                    arr.dept_nm = (this.dept_nm_depth1 == '' ? this.dept_nm : this.dept_nm_depth1);
                    arr.telno = this.telno;

                    html += "<tr>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
                    html += "</tr>";
                });

                html += "</table></div>";
                obj.after(html);
                $('#mem_list_layer').slideDown();

            }
            else
            {
                alert('검색된 데이터가 없습니다.');
                obj.siblings('input').val('');
                if( obj.siblings().hasClass('appeno') )
                {
                    $("input[name='appss'], input[name='apptel'], input[name='appmail']").val('');
                }
                return false;

            }

        }

    }); //end of ajax
}

function userSetData(jsonObj){
	var empno = '';
	
	if(typeof(jsonObj) != undefined){
		empno = jsonObj.empno;
	}
	
	if(empno != ''){
		$.ajax({
	        url : '/applicantRequest.do',
	        type : 'post',
	        data : { 'empNo':empno },
	        success : function(data) {
	        	var getUser = $.parseJSON(data);
	        	var userInfo = getUser[0];
	        	var deptInfo = getUser[1];

	        	$('input[name=SM_MNAME]').val($(userInfo)[0].NAME);
	        	$('input[name=SM_MEMPNO]').val($(userInfo)[0].EMPNO);
	        	$('input[name=SM_MTEL]').val($(userInfo)[0].TELNO);
	        	$('input[name=SM_MCEL]').val('');
	        	$('input[name=SM_MEMAIL]').val($(userInfo)[0].MAILNO+'@kepco.co.kr');
	        	$('input[name=SM_MC1CD]').val($(deptInfo)[0].DE_CODE1);
	        	$('input[name=SM_MC1NAME]').val($(deptInfo)[0].DE1);
	        	$('input[name=SM_MC2CD]').val($(deptInfo)[0].DE_CODE2);
	        	$('input[name=SM_MC2NAME]').val($(deptInfo)[0].DE2);
	        	$('input[name=SM_MDCD]').val($(deptInfo)[0].DE_CODE3);
	        	$('input[name=SM_MDNAME]').val($(deptInfo)[0].DE3);
	        	$('input[name=SM_MTCD]').val($(deptInfo)[0].DE_CODE4);
	        	$('input[name=SM_MTNAME]').val($(deptInfo)[0].DE4);
	        	$('#mem_list_layer').slideUp();
	        }
	    });
	}
}

$(document).on("keypress",".schword",function(e){
	if(e.keyCode == 13)
    {
        var key = $('.schword').index($(this));
        $('.schbtn').eq(key).trigger('click');
        return false;
    }
});

/* 첨부파일 업로드 */
$(".filebox .upload-hidden").on('change',function(){
	
	var ua = window.navigator.userAgent;
	var filesId = $(this)[0].id;
	var inputName = $(this)[0].name;
	var filename  = $(this)[0].files[0].name;
	var subFileId = filesId.substring(5,6);

	$('#target_file').val(inputName);
	
	if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
		if(filename != null || filename == ""){
			$('form[name="file_frm"]').ajaxForm({  
				url: "<%=Constants.DISPLAY_ASP_CALL %>",
				type: "POST",
				crossdomain: true, 
				enctype: "multipart/form-data",
				dataType: "json",
				contentType: "multipart/form-data",
				timeout: 1000 * 60 * 10,
				beforeSend: function() {
					var percentVal = '0%';
					$('span[id^=progressT_'+subFileId+']').show();
				},
				uploadProgress: function(event, position, total, percentComplete) {
					$('progress[id^=progressBar_'+subFileId+']').val(percentComplete);
					$('font[id^=progressBarRate_'+subFileId+']').text(percentComplete);
					//$('#srchDescription').text('업로드 진행 중');
				},
				success: function(msg) {
			    	if(subFileId == '1'){
			    		$("#fileSeq_1").val(msg);
			    	}else if (subFileId == '2'){
			    		$("#fileSeq_2").val(msg);
			    	}else{
			    		$("#fileSeq_3").val(msg);
			    	}
			    },
			    complete: function(xhr) {
			    },
			    error: function(e){
			    	console.log(e);
			    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
			    	/* location.replace(location.href); */
			    }
			})
			$('form[name="file_frm"]').submit();
		}
		
	}else{
		alert('IE 최신 브라우저에서 사용 가능합니다.');
	}
})
</script>
<c:import url="/resource/common/include/bottom.jsp" />