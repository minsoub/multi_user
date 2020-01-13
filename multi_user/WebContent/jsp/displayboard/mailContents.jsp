<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />

<body>

<c:if test="${mail_Type eq 'C' }">
	<c:set var="title" value="컨텐츠 제작" />
</c:if>
<c:if test="${mail_Type eq 'D' }">
	<c:set var="title" value="전광판게시" />
</c:if>

<c:forEach items="${resultView}" var ="displayDetail" >
<c:set var="SM_SEQ" 	value="${displayDetail.SM_SEQ}"/>
<c:set var="SM_NO" 		value="${displayDetail.SM_NO}"/>
<c:set var="SM_SVC2"	value="${displayDetail.SM_SVC2}"/>
<c:set var="SM_MDNAME"	value="${displayDetail.SM_MDNAME}"/>
<c:set var="SM_MNAME"	value="${displayDetail.SM_MNAME}"/>
<c:set var="SM_MTEL"	value="${displayDetail.SM_MTEL}"/>
<c:set var="SM_MCEL"	value="${displayDetail.SM_MCEL}"/>
<c:set var="SM_MEMAIL"	value="${displayDetail.SM_MEMAIL}"/>
<c:set var="SM_TITLE"	value="${displayDetail.SM_TITLE}"/>
<c:set var="SM_LSTATE"	value="${displayDetail.SM_LSTATE}"/>
<c:set var="SSTART"			value="${displayDetail.SSTART}"/>
<c:if test="${mail_Type eq 'D' }">
<c:set var="SDP_FDATE"	value="${displayDetail.SDP_FDATE}"/>
<c:set var="SDP_TDATE"	value="${displayDetail.SDP_TDATE}"/>
<c:set var="SDP_PLANDATE"	value="${displayDetail.SDP_PLANDATE}"/>
</c:if>
<c:if test="${mail_Type eq 'C' }">
<c:set var="SCT_RDATE"	value="${displayDetail.SCT_RDATE}"/>
<c:set var="SCT_TDATE"	value="${displayDetail.SCT_TDATE}"/>
<c:set var="SCT_ORIGQTY"	value="${displayDetail.SCT_ORIGQTY}"/>
<c:set var="SM_AMOUNT"	value="${displayDetail.SM_AMOUNT}"/>
</c:if>
</c:forEach>

<c:choose>
	<c:when test="${SM_LSTATE eq '3903' }">
		<c:set var="status_Title" value="신청" />
	</c:when>
	<c:when test="${SM_LSTATE eq '3094' }">
		<c:set var="status_Title" value="승인요청" />
	</c:when>
	<c:when test="${SM_LSTATE eq '3099' }">
		<c:set var="status_Title" value="진행중" />
	</c:when>
	<c:when test="${SM_LSTATE eq '3095' }">
		<c:set var="status_Title" value="작업완료" />
	</c:when>
	<c:when test="${SM_LSTATE eq '3100' }">
		<c:set var="status_Title" value="반려" />
	</c:when>
</c:choose>

<div class="email_box">
	<div>
		<div class="top-logo" style="margin-bottom:25px"><a href="http://media.hq" target="_new"><img alt="" src="/resource/images/logo.png"></a></div>
		<h3 style="color:#fff; text-align:center; font-size:20px;">${title } ${status_Title }</h3>
	</div>
	<div style="margin:35px 0 20px 0; line-height:25px; text-align:center;">
		${title } <strong>${status_Title }</strong> 알림 메일입니다.
		<br><a href="http://media.hq" target="_new"><strong>http://media.hq</strong></a>에서 내용을 확인해주세요
	</div>
	<div style="border:1px solid #e7e7e7; width:100%; border-radius:5px; padding:15px 15px 60px 15px; box-sizing: border-box;">
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
										<dd style="width:200px">${SM_MDNAME }</dd>
										<dt class="must-option"><strong>신청자</strong></dt>
										<dd style="width:200px">${SM_MNAME }</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>전화번호</strong></dt>
										<dd style="width:200px">${SM_MTEL}</dd>
										<dt class="must-option"><strong>이메일</strong></dt>
										<dd style="width:200px">${SM_MEMAIL}</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>서비스 요청일</strong></dt>
										<dd style="width:200px">${SSTART}</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>제목</strong></dt>
										<dd style="width:200px">${SM_TITLE}</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>${mail_Type eq 'C' ? '서비스 신청목록' : '게시장소' }</strong></dt>
										<dd>
											<c:set var="SVC2_SPLIT" value="${fn:split(SM_SVC2,',')}"/>
											<c:set var="displayCnt" value="0"></c:set>
											<c:forEach items="${SVC2_SPLIT }" var="SVC2_SPLIT_FOR" varStatus="SVC2_SPLIT_status" >
												<c:set var="SVC2_SPLIT_INDEX" value="${SVC2_SPLIT_status.index}" />
												<c:if test="${SVC2_SPLIT_INDEX ne 0 }">,</c:if>
												<c:if test="${mail_Type eq 'C' }">
													<c:out value="${cha:svc2Name(SVC2_SPLIT_FOR)}" />
												</c:if>
												<c:if test="${mail_Type eq 'D' }">
													<c:out value="${cha:svc2NameDisplay(SVC2_SPLIT_FOR)}" />
													<c:set var="displayCnt" value="${displayCnt + 1}"></c:set>
													<c:if test="${displayCnt % 5 == 0}"><span style="display: block;margin-top: 1px;"></span></c:if>
												<!-- 추가 -->
												</c:if>
											</c:forEach>
										</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>${mail_Type eq 'C' ? '회망요청 완료일' : '게시일시' }</strong></dt>
										<dd style="width:200px">
											<c:if test="${mail_Type eq 'C' }">
												<c:out value="${cha:changday(SCT_RDATE) }"></c:out>
											</c:if>
											<c:if test="${mail_Type eq 'D' }">
												<c:out value="${cha:changday2(SDP_FDATE)}" /> ~ <c:out value="${cha:changday2(SDP_TDATE)}" />
											</c:if>
										</dd>
										<c:if test="${mail_Type eq 'C' }">
											<dt class="must-option"><strong>작업요청 수량</strong></dt>
											<dd style="width:200px">
												<fmt:parseNumber var="min" value="${SM_AMOUNT / 60}" integerOnly="true" />
												<fmt:parseNumber var="sec" value="${SM_AMOUNT % 60}" integerOnly="true" />
												<c:choose>
													<c:when test="${SM_SVC2 == 3081 || SM_SVC2 == 3082}">
														${SM_AMOUNT } 매수
													</c:when>
													<c:when test="${SM_SVC2 == 3079 || SM_SVC2 == 3080}">
														${min } 분&nbsp&nbsp
														${sec } 초
													</c:when>
												</c:choose>
											</dd>
										</c:if>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><strong>작업 완료 예정일</strong></dt>
										<c:choose>
											<c:when test="${mail_Type eq 'D' }">
												<dd style="width:200px">${SDP_PLANDATE }</dd>
											</c:when>
											<c:otherwise>
												<dd style="width:200px">${SCT_TDATE }</dd>
											</c:otherwise>
										</c:choose>
										<c:if test="${mail_Type eq 'C' }">
											<dt class="must-option"><strong>${SM_LSTATE eq '3095' ? '완료작업 수량' : '예상작업 수량'}</strong></dt>
											<dd style="width:200px">
												<fmt:parseNumber var="min" value="${SCT_ORIGQTY / 60}" integerOnly="true" />
												<fmt:parseNumber var="sec" value="${SCT_ORIGQTY % 60}" integerOnly="true" />
												<c:choose>
													<c:when test="${SM_SVC2 == 3081 || SM_SVC2 == 3082}">
														${SCT_ORIGQTY } 매수
													</c:when>
													<c:when test="${SM_SVC2 == 3079 || SM_SVC2 == 3080}">
														${min } 분&nbsp&nbsp
														${sec } 초
													</c:when>
												</c:choose>
											</dd>
										</c:if>
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
				<li><input type="button" name="" class="search_btn" value="바로가기" onclick="javascript:goDetail();" style="width:120px; height:40px"></li>
			</ul>
		</div>
	</div>
</div>
<form id="frm" name="frm" method="post">
<input type="hidden" id="mail_Type" name="mail_Type" value="${mail_Type }">
<input type="hidden" id="SHSEQNUM" name="SHSEQNUM" value="${cha:seqEncode(SM_SEQ)}">
<input type="hidden" id="mode" name="mode" value="0">
</form>
<script>
function goDetail(){
	var url = '';
	if($('#mail_Type').val() == 'C'){
		url = '/contentsDetail.do';
	}else if($('#mail_Type').val() == 'D'){
		url = '/displayDetail.do';
	}
	funIfrmSubmit('http://media.hq'+url);
	//funIfrmSubmit('http://localhost:8080'+url);
}
</script>
</body>
</html>
