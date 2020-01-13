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
				
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						<fieldset>
						<legend>제작요청</legend>
							<div class="row-group">
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">신청번호</label></dt>
									<dd><input type="text" id="SM_NO" name="SM_NO"></dd>
									<dt class="must-option"><label for="" id="">서비스 구분</label></dt>
									<dd><input type="text" id="SM_SVC1" name=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">소속회사</label></dt>
									<dd style="width: 202px;">
									<select>
										<option id="" value="">--선택--</option>
										<c:forEach items="${companyList }" var="companyList">
											<option id="" value="${companyList.CD1_CODE }">${companyList.CD1_NAME }</option>
										</c:forEach>
									</select>
									</dd>
									<dt class="must-option"><label for="" id="">신청부서</label></dt>
									<dd><input type="text" id="" name="" ></dd>
								</dl>
								
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">신청자 사번</label></dt>
									<dd><input type="text" id="datepicker" name=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">신청자명</label></dt>
									<dd><input type="text" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">전화번호</label></dt>
									<dd><input type="text" id="" name="" title="" placeholder="" value=""></dd>
									<dt class="must-option"><label for="" id="">이메일</label></dt>
									<dd><input type="text" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">희망 납기일(*)</label></dt>
									<dd><input type="text" id="" name="" title="" placeholder="" value=""></dd>
									<dt class="must-option"><label for="" id="">납품처리 완료일</label></dt>
									<dd><input type="text" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">신청 구분</label></dt>
									<c:forEach items="${svc2Cnt }" var="svc2Cnt">
										<dd>
											<input type="radio" id="" name="" value="${svc2Cnt }"> 
											<label for="">${svc2Cnt.CD2_NAME }</label> 
										</dd>
									</c:forEach>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">사용자 서비스상태</label></dt>
									<c:forEach items="${serviceList }" var="serviceList">
										<dd>
											<input type="radio" id="" name="" value="${serviceList.CD2_NAME }"> 
											<label for=""><c:out value="${serviceList.CD2_NAME}" /></label> 
										</dd>
									</c:forEach>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">승인 상태</label></dt>
									<c:forEach items="${approveList }" var="approveList">
										<dd>
											<input type="radio" id="" name="" value="${approveList.CD2_NAME }"> 
											<label for=""><c:out value="${approveList.CD2_NAME}" /></label> 
										</dd>
									</c:forEach>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">서비스 종료상태</label></dt>
									<c:forEach items="${serviceEndList }" var="serviceEndList">
										<dd>
											<input type="radio" id="" name="" value="${serviceEndList.CD2_NAME }"> 
											<label for=""><c:out value="${serviceEndList.CD2_NAME}" /></label> 
										</dd>
									</c:forEach>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">제목</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">약관내용</label></dt>
									<dd>
										<c:choose>
											<c:when test="${fn:length(accptContents.AC_CONTENTS) == 0}"><textarea class="textarea-style" rows="5" cols="88" name="SM_ALARM" id="SM_ALARM" readonly="readonly">등록된 약관이 없습니다.</textarea></c:when>
											<c:otherwise><textarea class="textarea-style" rows="5" cols="88" name="SM_ALARM" id="SM_ALARM" readonly="readonly">${accptContents.AC_CONTENTS }</textarea></c:otherwise>
										</c:choose>
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">요청내용</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">원시자료 형태(*)</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">변환자료 형태(*)</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">원시자료 내용(*)</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일1</label></dt>
									<dd>
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files1">업로드</label> 
											<input class="upload-hidden" name="files1" id="files1" type="file" />
										</div>
									</dd>
								</dl>
								
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일2</label></dt>
									<dd>
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files2">업로드</label> 
											<input class="upload-hidden" name="files2" id="files2" type="file" />
										</div>
									</dd>
								</dl>
								
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일3</label></dt>
									<dd>
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files3">업로드</label> 
											<input class="upload-hidden" name="files3" id="files3" type="file" />
										</div>
									</dd>
								</dl>
								
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">결과물 첨부</label></dt>
									<dd>
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files3">업로드</label> 
											<input class="upload-hidden" name="files3" id="files3" type="file" />
										</div>
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">관리노트<br>(비공개)</label></dt>
									<dd><textarea class="textarea-style" rows="5" cols="88" ></textarea></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">서비스 만족도 평가</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">서비스 만족도 평가<br>건의사항</label></dt>
									<dd><input type="text" style="width:580px;" id="" name="" title="" placeholder="" value=""></dd>
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
			</form:form>
			</div>
			<div class="text_box">
				<div class="test_box_layer">
				<p>사용자 상태 및 종료 상태를 업데이트 할 경우 "납품 처리 완료일" 을 입력 하십시오.</p>
				<p>콘텐츠 제작 서비스는 승인권자(IT서비스부 이동은(차장))의 승인 이후에 작업을 진행합니다.</p>
				</div>
			</div>			
		</div>
		<!--content end-->
	</div>
</div>
</body>
<script type="text/javascript">
$('input:radio[name="SM_SVC2"]').change(function (){
	$('#change_unit').empty();
	var radioid = $("input:radio[name='SM_SVC2']:checked").attr('id');
	var radioVal = $('input:radio[name="SM_SVC2"]:checked').val();
	var test = $("input:radio[name='SM_SVC2']").is(":checked");
	
	var html = "";
	if(radioVal == '3081'){
		html += '<dd>';
		html += '<input type=\"text\" id=\"SM_AMOUNT\" name=\"SM_AMOUNT\" style=\"width:160px;\" value="">';
		html += '&nbsp&nbsp 매수';
		html += '</dd>';
	}else if(radioVal == '3080'){
		html += '<dd>';
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
		html += '</dd>';
	}else{
		html += '<dd>';
		html += '<input type=\"text\" id=\"SM_AMOUNT\" name=\"SM_AMOUNT\" style=\"width:160px;\" value="">';
		html += '&nbsp&nbsp 초';
		html += '</dd>';
	}
	$('#change_unit').append(html);	
})

</script>
<c:import url="/resource/common/include/bottom.jsp" />