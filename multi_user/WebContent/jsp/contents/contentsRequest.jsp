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
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">제작요청</b>
				</div>
				<div class="nav-title">제작요청</div>
			</div>
            
            <div class="sub-nav-title">요청사항 기재</div>
            
			<div class="basic-list">
			<form:form name="frm" id="frm" action="/contents/Insert.do" method="post"  modelAttribute="frm" enctype="multipart/form-data" >
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
				
				<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>제작요청</legend>
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
										<dd><input type="text" style="width:580px;" id="SM_TITLE" name="SM_TITLE" title="" placeholder="" value=""></dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="ServiceName" id="ServiceName_label">서비스신청목록</label></dt>
										<dd style="width: 100%;">
										<c:forEach items="${categoreyList}" var ="categoreyList" varStatus="cstatis">
											<span style="color:#666;">
											  <input type="radio" id="ex_chk_${cstatis.index}" name="SM_SVC2" value="<c:out value="${categoreyList.CD2_CODE}" />"> 
											  <label for="ex_chk_${cstatis.index}"><c:out value="${categoreyList.CD2_NAME}" /></label> 
											</span>
										</c:forEach>
										</dd>
										
									</dl>
									
									<!-- 
									<div id = "work">
									<dl class="insert_ready">
										<dt class="must-option2"><label for="MULTIPAGE" id="MULTIPAGE_label">제작 페이지</label></dt>
										<dd>
	                                        <input type="text" id="MULTIPAGE" name="MULTIPAGE" title="" placeholder="" value="" onKeyPress="">
	                                        &nbsp;&nbsp;
	                                        <span>페이지</span>
	                                        &nbsp;&nbsp;
	                                        <span>파워포인트 제작 할 페이지 분량을 입력해주세요(표지포함)</span>
	                                    </dd>
									</dl>
									
									<dl class="insert_ready">
										<dt class="must-option2"><label for="MULTITIME" id="MULTITIME_label">작업예상시간</label></dt>
										<dd class="dd-style">약 
	                                        <input type="text" class="work_input" id="MULTITIME" name="MULTITIME" title="" placeholder="" value="0" readonly="readonly" style="width:50px;">분 소요  
	                                        <div class="giTaBox">작업자와 협의 필요</div>
	                                    </dd>
										<dt class="must-option2"><label for="MULTITIMEOUT" id="MULTITIMEOUT_label">예상작업 완료일</label></dt>
										<dd class="dd-style">
	    									<input type="text" class="work_input" id="MULTITIMEOUT" name="MULTITIMEOUT" title="" placeholder="" value="" readonly="readonly" style="width:90px;">
	    									<input type="button" name="srchDescription" class="workView_btn" onclick="javascript:void(0);" value="현재 작업량 보기">
	                                        <div class="giTaBox">작업자와 협의 필요</div>
										</dd>
									</dl>
									</div> 
									-->
									<dl class="insert_ready">
										<dt class="must-option"><label for="SCT_RDATE" id="SCT_RDATE_label">희망요청 완료일</label></dt>
										<dd>
											<input type="text" name="SCT_RDATE" id="datepicker2" value=""
	                                        style="border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
										</dd>
										<dt class="must-option"><label for="SM_AMOUNT" id="SM_AMOUNT_label" style="color: red;">작업요청 수량</label></dt>
										<dd id="change_unit" style="width:250px;" > * 서비스신청을 선택 해주세요. </dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">제작요청 내용</label></dt>
										<dd><textarea class="textarea-style" rows="10" cols="88" name="SM_TEXT"></textarea></dd>
									</dl>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</form:form>
			
			<!-- dext업로드 form -->
			<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="SCF_SEQ" name="SCF_SEQ" value="0" />
			<input type="hidden" id="target_file" name="target_file" value=""/>
			<input type="hidden" id="tmp_EMPNO" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
				<div class="insrtfrom-framebox1">
					<div class="insert-step1-box">
						<div class="form-step1" >
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
			
			<div class="btn-zone">
				<ul>
					<li><input type="button" name="srchDescription" class="search_btn" onclick="save();" value="등록"></li>
<!-- 							<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:void(0);" value="취소"></li> -->
				</ul>
			</div>
			<div class="text_box">
				<div class="test_box_layer">
				<p>컨텐츠 제작 관리 부서 : ICT인프라처 ICT서비스부 / 컨텐츠 제작 : 멀티미디어센터 (본관 3층)</p>
				<p>원본 데이터(자료) 및 변환자료의 형태, 수량, 작업일정 등에 따라 소요시간이 달라지므로, 완료일이 중요할 경우</p>
				<p>반드시 담당자와 통화하시기 바랍니다. </p>
				<p>PPT제작 (061-6381,6384) / 이미지제작 (061-6382) / 전광판게시 (061-6382)  / 영상제작 (061-6386)</p>
				</div>
			</div>			
			</div>
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
var resultNum 	= 0;
var toDay		= new Date();
var toDayOg		= new Date();
var lastDay		= new Date();

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
				url: "<%=Constants.CONTENTS_ASP_CALL %>",
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

/* 신청자 검색 */

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
	        	
	        	$('input[name=SM_MEMPNO]').val($(userInfo)[0].EMPNO);
	        	$('input[name=SM_MNAME]').val($(userInfo)[0].NAME);
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


/* 
function workDayCalculation(){
	var timeTotal 	= resultNum * 30; 	//작업시간  (페이지 수* 30)
	var workTime 	= 480; 				//근로시간 분 단위 
	
	var plusDay = 0; 
		plusDay = timeTotal / workTime;
		plusDay = parseInt(plusDay);
	
	lastDay.setDate(toDay.getDate()+Number(plusDay));	//종료일계산	
	//일수에 주말이 포함퇴었을때
	var date1 = toDay.getFullYear() + "-" + toDay.getMonth() + "-" + toDay.getDate();
	var date2 = lastDay.getFullYear() + "-" + lastDay.getMonth() + "-" + lastDay.getDate();
	var plusDay2 = weekendCalculator(date1,date2);
	//console.log(resultNum);
	//console.log(plusDay+"=="+plusDay2);
	var trturnMonthNum 	= 0;
	toDay.setDate(toDay.getDate()+Number(plusDay)+Number(plusDay2));	
		trturnMonthNum 	= Number(toDay.getMonth())+1;	
	var	returnDay 		= toDay.getFullYear() + "-" + trturnMonthNum + "-" + toDay.getDate();
	
	$('#MULTITIME').val(timeTotal); 	//소요 시간
	$('#MULTITIMEOUT').val(returnDay);	//소요 기간	
} */

$('input:radio[name="SM_SVC2"]').change(function (){
	$('#change_unit').empty();
	var radioVal = $('input:radio[name="SM_SVC2"]:checked').val();
	
	var html = "";
	
	if(radioVal == '3081' || radioVal == '3082'){
		html += '<input type=\"text\" id=\"SM_AMOUNT\" name=\"SM_AMOUNT\" style=\"width:160px;\" value="" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,\'\'));">';
		html += '&nbsp 매수';
	}else if(radioVal == '3079' || radioVal == '3080'){
		html += '<input type=\"hidden\" id=\"SM_AMOUNT\" name=\"SM_AMOUNT\" style=\"width:160px;\" value="">';
		html += '<select style=\"width: 60px;\" name=\"SM_AMOUNT_MM\" id=\"timeMM\">';
		html += '<c:forEach var="min_date" begin="0" end="59" >';
		html += '<fmt:formatNumber pattern="00" value="${min_date }" var="convert_mindate"></fmt:formatNumber>';
		html += '<option value=\"${convert_mindate }\" >${convert_mindate }</option>';
		html += '</c:forEach>';
		html += '</select>&nbsp 분';    
		html += '&nbsp&nbsp&nbsp';
		html += '<select style=\"width: 60px;\" name=\"SM_AMOUNT_SS\" id=\"timeSS\">';
		html += '<c:forEach var="sec_date" begin="0" end="59" >';
		html += '<fmt:formatNumber pattern="00" value="${sec_date }" var="convert_secdate"></fmt:formatNumber>';
		html += '<option value="${convert_secdate }">${convert_secdate }</option>';
		html += '</c:forEach>';
		html += '</select>&nbsp 초';
	}else{
		html += '<input type=\"text\" id=\"MULTIPAGE\" name=\"MULTIPAGE\" style=\"width:100%;\" value="">';
	}
	$('#change_unit').append(html);	
})

var startDay	= new Date();
var chackDay	= new Date();
var endDay		= new Date();

function weekendCalculator(date1,date2){
	var date1Array	= date1.split("-");
 	var date2Array	= date2.split("-");
	startDay.setFullYear(date1Array[0],date1Array[1],date1Array[2]);
 	chackDay.setFullYear(date1Array[0],date1Array[1],date1Array[2]);
 	endDay.setFullYear(date2Array[0],date2Array[1],date2Array[2]);
	var week 		= new Array('su', 'mo', 'tu', 'we', 'th', 'fr', 'sa');
	var btMs 		= endDay.getTime() - startDay.getTime();
    var btDay 		= btMs / (1000*60*60*24);
 	var preDayCk 	= ""; //이전요일 체크
 	//var numCount 	= 0;
 	var numCount2 	= 0;
 	//console.log("forCount : "+btDay);
 	var chDay 		= "";
	var chDayLabel 	= "";
 	for(var i = 0; i < btDay; i++){
 		chackDay.setDate(chackDay.getDate()+1);
 		chDay 		= chackDay.getDay();
 		chDayLabel 	= week[chDay];
 		if(chDayLabel == "sa")numCount2++;
 		if(chDayLabel == "su")numCount2++;
 		//console.log(chDayLabel+"__111---count: "+numCount+" DATE: "+chackDay.getDate()+" count2 : "+numCount2);
 	}
 	chackDay.setDate(chackDay.getDate()+Number(numCount2));
 	var btMs2 		= chackDay.getTime() - endDay.getTime();
    var btDay2 		= btMs2 / (1000*60*60*24);
    for(var i = 0; i < btDay2; i++){
    	endDay.setDate(endDay.getDate()+1);
    	chDay 		= endDay.getDay();
 		chDayLabel 	= week[chDay];
 		if(chDayLabel == "sa")numCount2++;
 		if(chDayLabel == "su")numCount2++;
 		//console.log(chDayLabel+"__222---count: "+numCount+" DATE: "+endDay.getDate()+" count2 : "+numCount2);
 	} 
	if(chDayLabel == "sa")numCount2 = numCount2 + 1;
	//console.log(chDayLabel+"3333---count: "+numCount+" DATE: "+chackDay.getDate()+" count2 : "+numCount2);
 	return numCount2;
}

function multiNum(resultNum){
	var labelname = $('#MULTIPAGE_label');
	var labelname2 = $('#MULTIPAGE');
	var labelname_sub0 = $('#MULTIPAGE').parent().find("span").eq(0);
	var labelname_sub1 = $('#MULTIPAGE').parent().find("span").eq(1);
	if(resultNum == "3079"){
		//매체 변환 
		labelname.text("매체원본추정시간");
		labelname_sub0.text("분");
		labelname_sub1.text("변환 할 매체원본 총 시간을 입력해주세요.");
		labelname2.css("ime-mode", "disabled");
		labelname2.attr("onKeyPress","return numkeyCheck(event)");
	}else if(resultNum == "3080"){
		//영상편집
		labelname.text("매체원본추정시간");
		labelname_sub0.text("분");
		labelname_sub1.text("영상편집 할 매체원본 총 시간을 입력해주세요.");
		labelname2.css("ime-mode", "disabled");
		labelname2.attr("onKeyPress","return numkeyCheck(event)");
	}else if(resultNum == "3081"){
		//파워포인트 제작 or 문서[파워포인트]제작
		labelname.text("제작 페이지");
		labelname_sub0.text("페이지");
		labelname_sub1.text("파워포인트 제작 할 페이지 분량을 입력해주세요(표지포함)");
		labelname2.css("ime-mode", "disabled");
		labelname2.attr("onKeyPress","return numkeyCheck(event)");
	}else if(resultNum == "3082"){
		//이미지 제작 
		labelname.text("이미지 수량");
		labelname_sub0.text("장");
		labelname_sub1.text("이미지제작 할 분량을 입력해주세요.");
		labelname2.css("ime-mode", "disabled");
		labelname2.attr("onKeyPress","return numkeyCheck(event)");
	}else if(resultNum == "3083"){
		//한글제작  or 세미나 교육자료 제작
		labelname.text("제작 페이지");
		labelname_sub0.text("페이지");
		labelname_sub1.text("한글 제작 할 페이지 분량을 입력해주세요(표지포함)");
		labelname2.css("ime-mode", "disabled");
		labelname2.attr("onKeyPress","return numkeyCheck(event)");
	}else if(resultNum == "3092"){
		//기타
		labelname.text("세부내용");
		labelname_sub0.text("");
		labelname_sub1.text("서비스 세부내용과 작업분량을 입력해주세요");
		labelname2.css("ime-mode", "");
		labelname2.attr("onKeyPress","");
	}
}

var fileTarget = $('.filebox .upload-hidden');
fileTarget.on('change', function(){  // 값이 변경되면
  if(window.FileReader){  // modern browser
    var filename = $(this)[0].files[0].name;
  }else{  // old IE
    var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
  }
  $(this).siblings('.upload-name').val(filename); // 추출한 파일명 삽입
});


function save(){
	/* 서비스신청에 따른 작업요청 계산 */
	var radioVal = $('input:radio[name="SM_SVC2"]:checked').val()
	if(radioVal == '3081' || radioVal == '3082'){
		$('#SM_AMOUNT').val();
	}else if(radioVal == '3079' || radioVal == '3080'){
		var SM_AMOUNT = parseInt($("#timeMM").val()) * 60 + parseInt($("#timeSS").val());
		$('#SM_AMOUNT').val(SM_AMOUNT);
	}else{
		var MULTIPAGE = $("#MULTIPAGE").val();
		$('#MULTIPAGE').val(MULTIPAGE);
	}
	
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
	if (document.frm.SM_TITLE.value == "" ) {
		alert("제목을 입력 하십시오.");
		document.frm.SM_TITLE.focus();
		return false;
	}
	var ckBox = $("input:radio[name='SM_SVC2']").is(":checked");
	if (ckBox == false) {
		alert("서비스 신청 구분 항목에 체크 하십시오.");
		return false;
	}
	if (document.frm.SCT_RDATE.value == "" ) {
		alert("희망요청 완료일을 입력 하십시오.");
		document.frm.SCT_RDATE.focus();
		return false;
	}
	if($("#files1").val() == '' && $("#files2").val() == '' && $("#files3").val() == ''){
		alert("최소 1개이상 파일을 첨부해 주십시오.");
		return false;
	}
	
	/* 게시일시 지정 */
	// 날짜 형식
	var today = new Date( )
	thismonth = today.getMonth()+1;
	thisyear = today.getYear();
	thisday = today.getDate();
	thishour = today.getHours();
	thismin = today.getMinutes();

	thismonth = "" + thismonth;
	if (thismonth.length == 1) {
		thismonth = "0" + thismonth;
	}
	thisday = "" + thisday;
	if (thisday.length == 1) {
		thisday = "0" + thisday;
	}
	thishour = "" + thishour;
	if (thishour.length == 1) {
		thishour = "0" + thishour;
	}
	thismin = "" + thismin;
	if (thismin.length == 1) {
		thismin = "0" + thismin;
	}
	// 오늘일시(200802141102)
	var SCT_RDATE = document.frm.SCT_RDATE.value;
	var strToday = thisyear + "-" + thismonth + "-" + thisday;
	if (SCT_RDATE !== ""){
		if(CheckStr(SCT_RDATE, " ", "")==0 || document.frm.SCT_RDATE.value.length < 10 || document.frm.SCT_RDATE.value.indexOf("-") == -1){
			alert("요청 완료일을 날짜 형식으로 입력 하십시오.\n\n( 예 : "+strToday+" )");
			document.frm.SCT_RDATE.focus();
			return false;
		}
	}
	// 최소신청일자 3일...
	if(document.frm.SCT_RDATE.value < document.frm.minDay.value){
		alert("요청완료일은 오늘 날짜로부터 공휴일을 제외한 3일 이후("+document.frm.minDay.value+")를 선택해주시기 바랍니다.");
		document.frm.SCT_RDATE.focus();
		return false;
	}
	
	if ($("#SM_AMOUNT").val() == '' || $("#SM_AMOUNT").val() == 0 || $('#MULTIPAGE').val() == 0) {
		alert("작업요청 수량을 입력 하십시오. \n최소 작업수량은 1매 혹은 1초 이상 선택하십시오.");
		return false;
	}
	
	if (document.frm.SM_TEXT.value == "" ) {
		alert("요청내용을 입력 하십시오.");
		document.frm.SM_TEXT.focus();
		return false;
	}
	
	if($('#sts_Chk').length != 0){
		var AC_STATUS = $("input:checkbox[name='sts_Chk']").is(":checked");
		if (AC_STATUS != true ) {
			alert("이용동의를 체크 하십시오.");
			return false;
		}
	}
	
	/* 
	if (document.frm.MULTIPAGE.value == "" ){
		alert("서비스 내용을 입력 하십시오.");
		document.frm.MULTIPAGE.focus();
		return false;
	}
	if (isNaN(document.frm.MULTITIME.value)){
		document.frm.MULTITIME.value=null;
	}
	var MTO = document.frm.MULTITIMEOUT.value;
	if(isNaN( MTO )) {
	    if(MTO =='NaN-NaN-NaN') {
		    document.frm.MULTITIMEOUT.value=null;
	    }
	}
	 */
	 
    if (confirm("ex) ppt 15매는 최소 3일 30매는 최소 6일,\n 영상 제작은 5분 최소 3일 10분 최소 6일")) {
    	if(confirm("등록 하시겠습니까?")){
	    	$('#frm').submit();
    	}else{
			return false;
    	}
    } else {
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
	
	$("#datepicker").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	$("#datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
		minDate: 0
	});
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
	$('#datepicker').change(function(){
		var newDay =  $(this).val();
			newDayArray = newDay.split("-");
			var a = toDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			var b = toDayOg.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			var c = lastDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			workDayCalculation();
	});
	$('#MULTIPAGE').keyup(function(){
		toDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		lastDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		resultNum = $(this).val();  //입력된 값
		workDayCalculation();
	});
	*/
	

	$('.schword').keydown(function(key){
		if(key.keyCode == 13){
			$(this).siblings('.schbtn').trigger('click');
		}
	})
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />