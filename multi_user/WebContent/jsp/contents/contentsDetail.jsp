<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
	.modal{max-width:1200px;height:auto;}
	
	#modalUserSh{max-width:750px;height:auto;}
	#modalDeptSh{max-width:450px;height:auto;}
	
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
<c:set var="path" value="CONTENTS" />
<c:set var="sessEmpno" value="${sessEmpno}" />
<!-- 일반 조회 ,마이페이지 조회 변수 -->
<c:choose>
	<c:when test="${mode eq 0 }">
	<c:set var="modeNum" value="2"/>
	<c:set var="modeNum2" value="1"/>
	</c:when>
	<c:when test="${mode eq 1 }">
	<c:set var="modeNum" value="4"/>
	<c:set var="modeNum2" value="1"/>
	</c:when>
</c:choose>

<c:forEach items="${contentsDetail}" var ="contentsDetail" >
<c:set var="SM_SEQ" 	value="${contentsDetail.SM_SEQ}"/>
<c:set var="SM_NO" 		value="${contentsDetail.SM_NO}"/>
<c:set var="SM_DATE" 	value="${contentsDetail.SM_DATE}"/>
<c:set var="SM_SVC2"	value="${contentsDetail.SM_SVC2}"/>
<c:set var="SM_MEMPNO"	value="${contentsDetail.SM_MEMPNO}"/>
<c:set var="SM_MCCD"	value="${contentsDetail.SM_MCCD}"/>
<c:set var="SM_MC1CD"	value="${contentsDetail.SM_MC1CD}"/>
<c:set var="SM_MC1NAME"	value="${contentsDetail.SM_MC1NAME}"/>
<c:set var="SM_MC2CD"	value="${contentsDetail.SM_MC2CD}"/>
<c:set var="SM_MC2NAME"	value="${contentsDetail.SM_MC2NAME}"/>
<c:set var="SM_MDCD"	value="${contentsDetail.SM_MDCD}"/>
<c:set var="SM_MDNAME"	value="${contentsDetail.SM_MDNAME}"/>
<c:set var="SM_MTCD"	value="${contentsDetail.SM_MTCD}"/>
<c:set var="SM_MTNAME"	value="${contentsDetail.SM_MTNAME}"/>
<c:set var="SM_MNAME"	value="${contentsDetail.SM_MNAME}"/>
<c:set var="SM_MTEL"	value="${contentsDetail.SM_MTEL}"/>
<c:set var="SM_MCEL"	value="${contentsDetail.SM_MCEL}"/>
<c:set var="SM_MEMAIL"	value="${contentsDetail.SM_MEMAIL}"/>
<c:set var="SM_TITLE"	value="${contentsDetail.SM_TITLE}"/>
<c:set var="SM_TEXT"	value="${contentsDetail.SM_TEXT}"/>
<c:set var="SM_LSTATE"	value="${contentsDetail.SM_LSTATE}"/>
<c:set var="SM_FSTATE"	value="${contentsDetail.SM_FSTATE}"/>
<c:set var="SM_ISSIGN"	value="${contentsDetail.SM_ISSIGN}"/>
<c:set var="SM_WDATE"	value="${contentsDetail.SM_WDATE}"/>
<c:set var="SM_UDATE"	value="${contentsDetail.SM_UDATE}"/>
<c:set var="SCT_SEQ"	value="${contentsDetail.SCT_SEQ}"/>
<c:set var="SCT_RDATE"	value="${contentsDetail.SCT_RDATE}"/>
<c:set var="SCT_FNAME1"	value="${contentsDetail.SCT_FNAME1}"/>
<c:set var="SCT_FNAME2"	value="${contentsDetail.SCT_FNAME2}"/>
<c:set var="SCT_FNAME3"	value="${contentsDetail.SCT_FNAME3}"/>

<c:set var="SSTART"			value="${contentsDetail.SSTART}"/>
<c:set var="MULTIPAGE"		value="${contentsDetail.MULTIPAGE}"/>
<c:set var="MULTITIME"		value="${contentsDetail.MULTITIME}"/>
<c:set var="MULTITIMEOUT"	value="${contentsDetail.MULTITIMEOUT}"/>
<c:set var="AC_CONTENTS"	value="${contentsDetail.AC_CONTENTS}"/>
<c:set var="AC_STATUS"		value="${contentsDetail.AC_STATUS}"/>
<c:set var="SM_AMOUNT"		value="${contentsDetail.SM_AMOUNT eq null || contentsDetail.SM_AMOUNT eq '' ? '0' : contentsDetail.SM_AMOUNT}"/>

<c:set var="SCT_allow1EMP"		value="${contentsDetail.SCT_allow1EMP}"/>
<c:set var="SCT_allow1NM"		value="${contentsDetail.SCT_allow1NM}"/>
<c:set var="SCT_allow1DEPT"		value="${contentsDetail.SCT_allow1DEPT}"/>
<c:set var="SCT_allow1DEPTNM"	value="${contentsDetail.SCT_allow1DEPTNM}"/>
<c:set var="SCT_allow2EMP"		value="${contentsDetail.SCT_allow2EMP}"/>
<c:set var="SCT_allow2NM"		value="${contentsDetail.SCT_allow2NM}"/>
<c:set var="SCT_allow2DEPT"		value="${contentsDetail.SCT_allow2DEPT}"/>
<c:set var="SCT_allow2DEPTNM"	value="${contentsDetail.SCT_allow2DEPTNM}"/>
<c:set var="SCT_TDATE"			value="${contentsDetail.SCT_TDATE}"/>
<c:set var="SCT_ORIGQTY"			value="${contentsDetail.SCT_ORIGQTY}"/>
<c:set var="SCT_allow1REGDATE"			value="${contentsDetail.SCT_allow1REGDATE}"/>
<c:set var="SCT_allow2REGDATE"			value="${contentsDetail.SCT_allow2REGDATE}"/>
<c:set var="SCT_ORIGTEXT"			value="${contentsDetail.SCT_ORIGTEXT}"/>
<c:set var="SCT_worker"			value="${contentsDetail.SCT_worker}"/>
</c:forEach>

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
				<c:param name="left_depth_1" value="${modeNum }"></c:param>
				<c:param name="left_depth_2" value="${modeNum2 }"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행상황</b>
				</div>
				<div class="nav-title">컨텐츠 제작 <small class="sub2">진행상황</small></div>
			</div>
	
			<div class="tabNav sub2">
				<li><a href="/contentsInfo.do">이용안내</a></li>
				<li><a href="/contentsRequest.do">제작요청</a></li>
				<li><a href="#" class="active">진행사항</a></li>
			</div>
					

	
			<c:if test="${SM_LSTATE ne '3093' && SM_LSTATE ne '3097'}">
				<div class="searchArea_con" style="float:right;">
					<table>
						<colgroup>
							<col width="30px;">
							<col width="100px;">
							<col width="100px;">
							<col width="100px;">
						</colgroup>
						<tr style="height:30px;">
							<td rowspan="2"><span>작업승인</span></td>
							<td>담당자</td>
							<td>파트장</td>
						</tr>
						<tr style="height:100px;">
							<td>
								<c:choose>
									<c:when test="${SCT_allow1REGDATE eq null }">
										<c:choose>
											<c:when test="${sessionScope.SESS_EMPNO eq SCT_allow1EMP }">
												<a href="javascript:;" onclick="javascript:funAppProc('${SM_NO}','allow1EMP', '${SM_SEQ }');" style="text-decoration: underline;">${SCT_allow1NM }</a>
											</c:when>
											<c:otherwise>
												<p>${SCT_allow1NM }</p>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<p class="approvalUser">${SCT_allow1NM }</p>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${SCT_allow2REGDATE eq null }">
										<c:choose>
											<c:when test="${sessionScope.SESS_EMPNO eq SCT_allow2EMP && SCT_allow1REGDATE ne null }">
												<a href="javascript:;" onclick="javascript:funAppProc('${SM_NO}','allow2EMP', '${SM_SEQ }');" style="text-decoration: underline;">${SCT_allow2NM }</a>
											</c:when>
											<c:otherwise>
												<p>${SCT_allow2NM }</p>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<p class="approvalUser">${SCT_allow2NM }</p>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			<div style="clear:both;"></div>
			</c:if>	
            <c:choose>
                <c:when test="${empty mode2}">
                    <div class="sub-nav-title">제작요청 상세보기</div>
                </c:when>
                <c:otherwise>
                    <div class="sub-nav-title">제작요청 수정하기</div>
                </c:otherwise>
            </c:choose>
            
			<div class="basic-list">
			<form:form name="frm" id="frm" action="/contents/Modify.do" method="post"  modelAttribute="frm" enctype="multipart/form-data" >
				<input type="hidden" id="SHSEQNUM" 	name="SHSEQNUM" value="${cha:seqEncode(SM_SEQ)}">
				<input type="hidden" name="SM_SEQ" value="${SM_SEQ}">
				<input type="hidden" name="SM_NO" value="${SM_NO}"/>
				<input type="hidden" name="SM_MEMPNO" 	value='<c:out value="${SM_MEMPNO}" />'><!-- 신청자사번 -->
                <input type="hidden" name="s1"            value='<c:out value="${paging.s1}" />'>
                <input type="hidden" name="s2"            value='<c:out value="${paging.s2}" />'>
                <input type="hidden" id="fileSeq_1" name="fileSeq_1">
				<input type="hidden" id="fileSeq_2" name="fileSeq_2">
				<input type="hidden" id="fileSeq_3" name="fileSeq_3">
				<input type="hidden" id="fileSeq_4" name="fileSeq_4">
                
				<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>제작요청</legend>
								<div class="row-group">
									<dl class="insert_ready">
										<dt class="must-option"><label for="ServiceName" id="ServiceName_label">신청번호</label></dt>
											<dd style="width: 240px;">${SM_NO }</dd>
										<dt class="must-option"><label for="" id="" style="color: red;">작업자</label></dt>
											<dd style="width: 240px;">${SCT_worker }</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="SM_MDNAME" id="SM_MDNAME_label">신청부서</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width: 240px;">
													${SM_MDNAME}
												</dd>
											</c:when>
											<c:otherwise>
												<dd style="width: 240px;">
													<input type="text" id="SM_MDNAME" name="SM_MDNAME" title="" placeholder="" value='<c:out value="${SM_MDNAME }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
										<dt class="must-option"><label for="SM_MNAME" id="SM_MNAME_label">신청자</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width: 240px;">
													${SM_MNAME}
												</dd>
											</c:when>
											<c:otherwise>
												<dd style="width: 240px;">
													<input type="text" id="SM_MNAME" name="SM_MNAME" title="" placeholder="" value='<c:out value="${SM_MNAME }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="SM_MTEL" id="SM_MTEL_label">전화번호</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width: 240px;">
													${SM_MTEL}
												</dd>
											</c:when>
											<c:otherwise>
												<dd style="width: 240px;">
													<input type="text" id="SM_MTEL" name="SM_MTEL" title="" placeholder="" value='<c:out value="${SM_MTEL }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
										<dt class="must-option"><label for="SM_MEMAIL" id="SM_MEMAIL_label">E-MAIL</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width: 240px;">
													${SM_MEMAIL}
												</dd>
											</c:when>
											<c:otherwise>
												<dd style="width: 240px;">
													<input type="text" id="SM_MEMAIL" name="SM_MEMAIL" title="" placeholder="" value='<c:out value="${SM_MEMAIL }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									
									<dl class="insert_ready">
										<dt class="must-option"><label for="SSTART" id="SSTART_label">서비스 요청일</label></dt>
										<dd style="width: 240px;">
											<c:choose>
												<c:when test="${empty mode2}">
													${SSTART}
												</c:when>
												<c:otherwise>
													<input type="text" id="datepicker" name="SSTART" value='${SSTART}' readonly="readonly">
												</c:otherwise>
											</c:choose>
										</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="ServiceName" id="ServiceName_label">제목</label></dt>
										<dd>
											<c:choose>
												<c:when test="${empty mode2}">
													${SM_TITLE}
												</c:when>
												<c:otherwise>
													<input type="text" id="SM_TITLE" name="SM_TITLE" title="" placeholder="" value="${SM_TITLE}">
												</c:otherwise>
											</c:choose>
										</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="ServiceName" id="ServiceName_label">서비스신청목록</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width: 240px;">
												<c:set var="SVC2_SPLIT" value="${fn:split(SM_SVC2,',')}"/>
												<c:forEach items="${SVC2_SPLIT }" var="SVC2_SPLIT_FOR" varStatus="SVC2_SPLIT_status" >
													<c:set var="SVC2_SPLIT_INDEX" value="${SVC2_SPLIT_status.index}" />
													<c:if test="${SVC2_SPLIT_INDEX ne 0 }">,</c:if>
													<c:out value="${cha:svc2Name(SVC2_SPLIT_FOR)}" />
												</c:forEach>
												</dd>
											</c:when>
											<c:otherwise>
												<dd class="serviceList">
												<c:forEach items="${categoreyList}" var ="categoreyList" varStatus="cstatis">
													<span style="color:#666;">
														<input type="radio" id="ex_chk_${cstatis.index}" name="SM_SVC2" value="<c:out value="${categoreyList.CD2_CODE}" />" <c:if test="${SM_SVC2 eq categoreyList.CD2_CODE}" >checked="checked"</c:if> > 
														<label for="ex_chk_${cstatis.index}"><c:out value="${categoreyList.CD2_NAME}" /></label> 
													</span>
												</c:forEach>
												</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<%-- <dl class="insert_ready">
										<dt class="must-option2"><label for="MULTIPAGE" id="MULTIPAGE_label">제작 페이지</label></dt>
										<dd class="must-option2-dd">
	                                    <c:choose>
	                                        <c:when test="${empty mode2}">
	                                            <c:out value="${MULTIPAGE }"></c:out>
	                                            &nbsp;&nbsp;
	                                            <span>페이지</span>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <input type="text" id="MULTIPAGE" name="MULTIPAGE" title="" placeholder="" value="${MULTIPAGE }">
	                                            &nbsp;&nbsp;
	                                            <span>페이지</span>
	                                            &nbsp;&nbsp;
	                                            <span>파워포인트 제작 할 페이지 분량을 입력해주세요(표지포함)</span>
	                                        </c:otherwise>
	                                    </c:choose>
									</dl>
									
									<dl class="insert_ready">
										<dt class="must-option2"><label for="MULTITIME" id="MULTITIME_label">작업예상시간</label></dt>
										<dd>
	                                        <c:choose>
	                                            <c:when test="${empty mode2}">
	                                                <font class="work_input" id="MULTITIME">약 <c:out value="${MULTITIME }"></c:out>분 소요</font>
	                                            </c:when>
	                                            <c:otherwise>
	                                                <font>약 </font><input type="text" class="work_input" id="MULTITIME" name="MULTITIME" title="" placeholder="" value="${MULTITIME }" readonly="readonly" style="width:50px;">분 소요
	                                            </c:otherwise>
	                                        </c:choose>
	                                        <div class="giTaBox">작업자와 협의 필요</div> 
	                                    </dd>
	                                    
										<dt class="must-option2"><label for="MULTITIMEOUT" id="MULTITIMEOUT_label">예상작업 완료일</label></dt>
										<dd>
	                                        <c:choose>
	                                            <c:when test="${empty mode2}">
	                                                <font class="work_input" id="MULTITIMEOUT"><c:out value="${MULTITIMEOUT }"></c:out></font>
	                                            </c:when>
	                                            <c:otherwise>
	        									    <input type="text" class="work_input" id="MULTITIMEOUT" name="MULTITIMEOUT" style="width:120px;" title="" placeholder="" value="${MULTITIMEOUT }" readonly="readonly" style="width:90px;">
	                                            </c:otherwise>
	                                        </c:choose>
										    <input type="button" name="srchDescription" class="workView_btn" onclick="javascript:void(0);" value="현재 작업량 보기">
	                                        <div class="giTaBox">작업자와 협의 필요</div>
										</dd>
									</dl> --%>
									
									<dl class="insert_ready">
										<dt class="must-option"><label for="SCT_RDATE" id="SCT_RDATE_label">희망요청 완료일</label></dt>
										<dd style="width: 240px;">
	                                        <fmt:parseDate value="${SCT_RDATE}" var="PARSE_SCT_RDATE" pattern="yyyyMMddHH" />
											<c:choose>
												<c:when test="${empty mode2}">
													<fmt:formatDate value="${PARSE_SCT_RDATE}" pattern="yyyy-MM-dd"/>
												</c:when>
												<c:otherwise>
													<input type="text" name="SCT_RDATE" id="datepicker2" value="<fmt:formatDate value="${PARSE_SCT_RDATE}" pattern="yyyy-MM-dd"/>" style="border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
												</c:otherwise>
											</c:choose>
										</dd>
										
										<dt class="must-option"><label >작업요청 수량</label></dt>
										<dd style="width: 240px;" id="change_unit">
											<fmt:parseNumber var="min" value="${SM_AMOUNT / 60}" integerOnly="true" />
											<fmt:parseNumber var="sec" value="${SM_AMOUNT % 60}" integerOnly="true" />
											<c:choose>
												<c:when test="${empty mode2}">
													<c:choose>
														<c:when test="${SM_SVC2 == '3081' || SM_SVC2 == '3082'}">
															${SM_AMOUNT } 매수
														</c:when>
														<c:when test="${SM_SVC2 == '3079' || SM_SVC2 == '3080'}">
															${min } 분
															${sec } 초
														</c:when>
														<c:otherwise>
															${MULTIPAGE }
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${SM_SVC2 == '3081' || SM_SVC2 == '3082' }">
															<input type="text" id="SM_AMOUNT" name="SM_AMOUNT" style="width:160px;" value="${SM_AMOUNT }" >&nbsp매수
														</c:when>
														<c:when test="${SM_SVC2 == '3079' || SM_SVC2 == '3080' }">
														<input type="hidden" id="SM_AMOUNT" name="SM_AMOUNT" style="width:160px;" value="" >
															<div style="width:202px;">
															<select style="width: 60px;" name="SM_AMOUNT_MM" id="timeMM" >
																<c:forEach var="min_date" begin="0" end="59" >
																	<fmt:formatNumber pattern="00" value="${min_date }" var="convert_mindate"></fmt:formatNumber>
																	<option value="${convert_mindate }">${convert_mindate }</option>
																</c:forEach>
															</select> &nbsp분&nbsp&nbsp
															<select style="width: 60px;" name="SM_AMOUNT_SS" id="timeSS" >
																<c:forEach var="sec_date" begin="0" end="59" >
																	<fmt:formatNumber pattern="00" value="${sec_date }" var="convert_secdate"></fmt:formatNumber>
																	<option value="${convert_secdate }" >${convert_secdate }</option>
																</c:forEach>
															</select> &nbsp초
															</div>
														</c:when>
														<c:otherwise>
															<input type="text" id="MULTIPAGE" name="MULTIPAGE" style="width:160px;" value="" >
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>	
										</dd>
									</dl>
									
									<c:if test="${SM_LSTATE ne '3093' }">
									<dl class="insert_ready">
										<c:choose>
											<c:when test="${SM_LSTATE eq '3095' }">
												<dt class="must-option"><label for="SCT_RDATE" id="SCT_RDATE_label" style="color: red;">완료일</label></dt>
												<dd style="width: 240px;">
			                                       ${SCT_TDATE eq null && SCT_TDATE eq '' ? '' : SCT_TDATE}
												</dd>
												<dt class="must-option"><label for="" id="" style="color: red;">완료작업 수량</label></dt>
												<dd id="change_unit3" style="width: 240px;"></dd>
											</c:when>
											<c:otherwise>
												<dt class="must-option"><label for="SCT_RDATE" id="SCT_RDATE_label" style="color: red;">완료예정일</label></dt>
												<dd style="width: 240px;">
		                                       		${SCT_TDATE eq null && SCT_TDATE eq '' ? '' : SCT_TDATE}
												</dd>
												<dt class="must-option"><label for="" id="" style="color: red;">완료예정 작업수량</label></dt>
												<dd id="change_unit2" style="width: 240px;"></dd>
											</c:otherwise>
										</c:choose>
										</dl>
										<c:if test="${mode2 eq '0' }">
											<dl class="insert_ready">
												<dt class="must-option"><label for="" id="" >완료예정일</label></dt>
												<dd style="width: 240px;">
													<input type="text" name="SCT_TDATE" id="datepicker3" value="${SCT_TDATE eq null && SCT_TDATE eq '' ? '' : SCT_TDATE}" style="border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
												</dd >
												<dt class="must-option"><label for="" id="">완료예정 작업수량</label></dt>
												<dd id="change_unit2" style="width: 240px;">
													<input type="text" id="SCT_ORIGQTY" name="SCT_ORIGQTY" style="width:160px;" value="${SCT_ORIGQTY }" >
												</dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label for="" id="" >작업자</label></dt>
												<dd style="width: 240px;">
													<input type="text" name="SCT_worker" id="SCT_worker" value="${SCT_worker }">
												</dd >
											</dl>
										</c:if>
									</c:if>
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">제작요청 내용</label></dt>
										<dd style="width: 240px;">
											<c:choose>
												<c:when test="${empty mode2}">
													<c:choose>
														<c:when test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || SM_MEMPNO eq sessEmpno || sessEmpno eq SCT_allow1EMP || sessEmpno eq SCT_allow2EMP}">
			                                               	<div style="height:250px; width:760px;overflow-y: scroll;padding-right: 5px;">
			                                               	<pre style="font-family: 돋음,dotum;"><c:out value="${SM_TEXT}"></c:out></pre>
			                                                </div>
														</c:when>
														<c:otherwise>
			                                            	<textarea rows="10" cols="88" name="SM_TEXT" readonly="readonly">제작요청 내용은 신청자 본인에게만 공개되어 있습니다.</textarea>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:when test="${mode2 == '0' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 }">
													<textarea rows="10" cols="88" name="SM_TEXT">${SM_TEXT}</textarea>
												</c:when>
												<c:otherwise>
													<c:if test="${SM_MEMPNO eq sessEmpno || sessEmpno eq SCT_allow1EMP || sessEmpno eq SCT_allow2EMP}"><textarea rows="10" cols="88" name="SM_TEXT" >${SM_TEXT}</textarea></c:if>
	                                                <c:if test="${SM_MEMPNO ne sessEmpno}"><textarea rows="10" cols="88" name="SM_TEXT" >제작요청 내용은 신청자 본인에게만 공개되어 있습니다.</textarea></c:if>
												</c:otherwise>
											</c:choose>
										</dd>
									</dl>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</form:form>
			
			<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="SCF_SEQ" name="SCF_SEQ" value="0" />
			<input type="hidden" id="target_file" name="target_file" value=""/>
			<input type="hidden" id="tmp_EMPNO" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
				<div class="insrtfrom-framebox1">
					<div class="insert-step1-box">
						<div class="form-step1">
							<div class="row-group">
							<c:set var="fileCount" value="${fn:length(contentFileList) }" />
								<c:if test="${empty mode2 }">
									<c:forEach begin="0" end="2" varStatus="sts">	
										<dl class="insert_ready3">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일${sts.count }</label></dt>
											<dd class="must-option2-dd">
												<c:choose>
													<c:when test="${(SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || sessionScope.SESS_EMPNO eq SCT_allow1EMP || sessionScope.SESS_EMPNO eq SCT_allow2EMP) && contentFileList[sts.index].SCF_status eq 'U' }">
														<a href="#" onclick="goDown('${contentFileList[sts.index].SCF_SEQ}')" style="cursor: pointer;">${contentFileList[sts.index].SCF_orgFileName }</a>
													</c:when>
													<c:when test="${(SM_MEMPNO ne sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO lt 1)  && contentFileList[sts.index].SCF_status eq 'U'}">
															첨부파일은 신청자 본인에게만 공개되어 있습니다.
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</dd>
										</dl>
									</c:forEach>
									<c:forEach items="${completeFileList }" var="completeFileList">
										<c:if test="${(completeFileList.SCF_orgFileName ne '' && completeFileList.SCF_orgFileName ne null)}">
											<dl class="insert_ready3">
												<dt class="must-option"><label for="ServiceName" id="ServiceName_label" style="color: red;">완료파일</label></dt>
												<dd class="must-option2-dd" >
													<c:choose>
														<c:when test="${SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || sessionScope.SESS_EMPNO eq SCT_allow1EMP || sessionScope.SESS_EMPNO eq SCT_allow2EMP }">
														<a href="#" onclick="goDown('${completeFileList.SCF_SEQ}')" style="cursor: pointer;">${completeFileList.SCF_orgFileName }</a>
														</c:when>
														<c:otherwise>첨부파일은 신청자 본인에게만 공개되어 있습니다.</c:otherwise>
													</c:choose>
												</dd>
											</dl>
										</c:if>
									</c:forEach>
								</c:if>	
								<c:if test="${mode2 == '0'}">
									<c:forEach begin="0" end="2" varStatus="sts">
										<dl class="insert_ready3">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일${sts.count }</label></dt>
											<dd class="must-option2-dd">
												<c:choose>
													<c:when test="${(SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1) && contentFileList[sts.index].SCF_status eq 'U'}">
														<div class="filebox">
															<input class="upload-name" value="${contentFileList[sts.index].SCF_orgFileName }" disabled="disabled">
															<label for="files${sts.count }" id="files${sts.count }" onclick="godel('${contentFileList[sts.index].SCF_SEQ }', this , '${sts.count }')" >삭제</label> 
														</div>
													</c:when>
													<c:when test="${(SM_MEMPNO ne sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO < 1)  && contentFileList[sts.index].SCF_status eq 'U'}">
															첨부파일은 신청자 본인에게만 공개되어 있습니다.
													</c:when>
													<c:otherwise>
														<div class="filebox">
															<input class="upload-name" value="파일선택" disabled="disabled">
															<label for="files${sts.count }">업로드</label> 
															<input class="upload-hidden" name="uploadFile${sts.count }" id="files${sts.count }" type="file" value="" />
															<progress id="progressBar_${sts.count }" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															&nbsp<span id="progressT_${sts.count }" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_${sts.count }">0</font>%</span>
														</div>
													</c:otherwise>
												</c:choose>
											</dd>
										</dl>
									</c:forEach>	
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</form>
			
			<!-- 약관동의 내용 -->
			<div style="margin-top: 10px; margin-bottom: 20px;">
				<c:if test="${fn:length(AC_CONTENTS1) != 0 }">
					<div style="width: 100%; height: 100px;border: 1px solid #a9abae;overflow-y:auto;word-break: break-all">
						<c:out value="${AC_CONTENTS1 }" escapeXml="false"></c:out>
					</div>
				</c:if>
			</div>
			
			<!--접수부분 추가입력사항 -->
			<c:if test="${SM_LSTATE eq '3093' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2 }">
				<form name="frm_reception" id="frm_reception" method="post"  enctype="multipart/form-data">
				<input type="hidden" name="target_file" id="complete_file" value="">
				<input type="hidden" id="tmp_EMPNO1" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
					<div class="insrtfrom-framebox" style="margin-top: 20px;">
						<div class="insert-step1-box">
							<div class="sub-nav-title">추가입력 사항</div>
							<div class="form-step1">
								<div class="row-group">
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">담당자 부서</label></dt>
										<dd style="width: 240px;">
											<input type="hidden" id="SCT_allow1DEPT" name="SCT_allow1DEPT" value="">
											<input type="text" id="SCT_allow1DEPTNM" name="SCT_allow1DEPTNM" value="" readonly="readonly">
										</dd>
										<dt class="must-option"><label for="" id="">담당자</label></dt>
										<dd class="btn-zone" style="width: 240px;">
											<input type="hidden" id="SCT_allow1EMP" name="SCT_allow1EMP" class="mngAllow" value="">
											<input type="hidden" id="SCT_allow1NM" name="SCT_allow1NM" class="mngAllow" value="">
											<input type="text" class="schword" name="sch_text1" style="width: 40%;" value="" >
											<input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; "> *이름/사번</span>
										</dd>
									</dl>
									
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">파트장 부서</label></dt>
										<dd style="width: 240px;">
											<input type="hidden" id="SCT_allow2DEPT" name="SCT_allow2DEPT" value="">
											<input type="text" id="SCT_allow2DEPTNM" name="SCT_allow2DEPTNM" value="" readonly="readonly">
										</dd>
										<dt class="must-option"><label for="" id="">파트장</label></dt>
										<dd class="btn-zone" style="width: 240px;">
											<input type="hidden" id="SCT_allow2EMP" name="SCT_allow2EMP" class="finalMngAllow" value="">
											<input type="hidden" id="SCT_allow2NM" name="SCT_allow2NM" class="finalMngAllow" value="">
											<input type="text" class="schword" name="sch_text2" style="width: 40%;" value="">
											<input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; "> *이름/사번</span>
										</dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="" >완료예정일</label></dt>
										<dd style="width: 240px;">
											<input type="text" name="SCT_TDATE" id="datepicker3" value="<fmt:formatDate value="${PARSE_SCT_RDATE}" pattern="yyyy-MM-dd"/>" style="border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
										</dd >
										<dt class="must-option"><label for="" id="">완료예정 작업수량</label></dt>
										<dd id="change_unit2" style="width: 240px;"></dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="" >작업자</label></dt>
										<dd style="width: 240px;">
											<input type="text" name="SCT_worker" id="SCT_worker" value="">
										</dd >
									</dl>
								</div>
							</div>
						</div>
					</div>
					
					<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO lt 1  && SM_LSTATE ne '3093' && SM_MEMPNO eq sessEmpno }">
					<div class="insrtfrom-framebox" style="margin-top: 20px;">
						<div class="insert-step1-box">
							<div class="insert-step1-box">
								<div class="form-step1">
									<div class="row-group">
										<dl class="insert_ready">
										<c:choose>
											<c:when test="${SM_LSTATE eq '3099'}">
												<dt class="must-option"><label for="" id="">완료예정일</label></dt>
												<dd style="width: 240px;">
													${SCT_TDATE }
												</dd >
												<dt class="must-option"><label for="" id="">완료예정 작업수량</label></dt>
												<dd id="change_unit2" style="width: 240px;"></dd>
											</c:when>
											<c:otherwise>
												<dt class="must-option"><label for="" id="">완료일</label></dt>
												<dd style="width: 240px;">
													${SCT_TDATE }
												</dd >
												<dt class="must-option"><label for="" id="">완료 작업수량</label></dt>
												<dd id="change_unit3" style="width: 240px;"></dd>
											</c:otherwise>
										</c:choose>
										</dl>
									</div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
				</form>
			</c:if>
			
			<!-- 완료파일 -->
			<c:if test="${SM_LSTATE eq '3099' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2}">
			<form name="frm_complefile" id="frm_complefile" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="target_file" id="complete_file" value="">
			<input type="hidden" id="tmp_EMPNO1" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
				<div class="insrtfrom-framebox" style="margin-top: 20px;">
					<div class="insert-step1-box">
						<div class="sub-nav-title">추가입력 사항</div>
						<div class="form-step1">
							<div class="row-group">
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">사용자신청 서비스</label></dt>
									<dd style="width: 240px;">
									<c:set var="SVC2_SPLIT" value="${fn:split(SM_SVC2,',')}"/>
										<c:forEach items="${SVC2_SPLIT }" var="SVC2_SPLIT_FOR" varStatus="SVC2_SPLIT_status" >
											<c:set var="SVC2_SPLIT_INDEX" value="${SVC2_SPLIT_status.index}" />
											<c:if test="${SVC2_SPLIT_INDEX ne 0 }">,</c:if>
											<c:out value="${cha:svc2Name(SVC2_SPLIT_FOR)}" />
										</c:forEach>
									</dd>
									<dt class="must-option"><label for="" id="">완료작업 수량</label></dt>
									<dd style="width: 240px;" id="change_unit3" ></dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="" id="">완료일</label></dt>
									<dd style="width: 240px;">
										<input type="text" name="SCT_TDATE" id="datepicker4" value="<fmt:formatDate value="${PARSE_SCT_RDATE}" pattern="yyyy-MM-dd"/>" style="border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat; cursor: pointer;">
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">완료 첨부파일</label></dt>
									<dd class="must-option2-dd">
										<div class="filebox">
											<input class="upload-name" value="파일선택" disabled="disabled">
											<label for="files4">업로드</label> 
											<input class="upload-hidden" name="uploadFile4" id="files4" type="file" />
											&nbsp<progress id="progressBar_4" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
											<span id="progressT_4" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_4">0</font>%</span>
										</div>
									</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</form>
			</c:if>

			<!-- 동적 button -->
			<div class="btn-zone" style="margin-bottom: 50px;">
				<ul>
				<c:if test="${SM_LSTATE eq '3099' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2}">
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(0);" value="수정"></li>
					<li><input type="button" name="srchDescription2" class="search_btn1" onclick="javascript:doDetail(1)" value="신청취소" style="width:63px;"></li>
					<li><input type="button" name="srchDescription2" class="search_btn1" onclick="javascript:doComplete('${SM_SEQ}');" value="완료저장"></li>
				</c:if>
				<c:if test="${SM_LSTATE eq '3093' && mode eq 1 && (sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || SM_MEMPNO eq sessEmpno ) && empty mode2}">
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(0);" value="수정"></li>
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(1)" value="신청취소" style="width:63px;"></li>
				</c:if>
				<c:if test="${(SM_LSTATE eq '3093' || SM_LSTATE eq '3094' )&& mode ne 1 && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2}">
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(0);" value="수정"></li>
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(1)" value="신청취소" style="width:63px;"></li>
				</c:if>
				<c:if test="${(SM_LSTATE eq '3093' || SM_LSTATE eq '3094' || SM_LSTATE eq '3099'  ) && mode2 eq '0'}">
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:save(0);" value="저장"></li>
				</c:if>
				<c:if test="${SM_LSTATE eq '3093' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2 }">
					<li><input type="button" name="srchDescription2" class="search_btn1" onclick="javascript:doConfirm();" value="접수 완료"></li>
				</c:if>
				<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:goToContPrg();" value="목록"></li>
				</ul>
			</div>
			<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || SM_MEMPNO eq sessEmpno }">
				<div class="btn-zone" style="margin-bottom: 50px; float: left;">
					<ul>
						<li><input type="button" class="search_btn1" onclick="window.open('contextPrint.do?strID=${SM_SEQ}', 'contextPrint', 'width=1000px, height=900px, scrollbars=yes');" value="내용 출력" /></li>
					</ul>
				</div>
			</c:if>
			<div style="clear: both;">
				<div class="text_box" >
					<div class="test_box_layer">
						<p>컨텐츠 제작 관리 부서 : ICT인프라처 ICT서비스부 / 컨텐츠 제작 : 멀티미디어센터 (본관 3층)</p>
						<p>원본 데이터(자료) 및 변환자료의 형태(DVD,CD,자료전송), 수량, 작업일정 등에 따라 소요시간이 달라지므로, 완료일이 중요할 경우</p>
						<p>반드시 담당자와 통화하시기 바랍니다. </p>
						<p>PPT/이미지제작 (061-6381,6384)  영상,DVD제작 (061-6386)</p>
					</div>
				</div>		
			</div>			
		</div>
		<!--content end-->
	</div>
</div>

<form id="FormDetail" name="FormDetail" action="" method="post">
	<input type="hidden" id="SHSEQNUM" 	name="SHSEQNUM" value="${cha:seqEncode(SM_SEQ)}">
	<input type="hidden" name="SM_SEQ"	id="SM_SEQ" value="${SM_SEQ}">
	<input type="hidden" name="SM_NO" id="SM_NO" value="${SM_NO}"/>
	<input type="hidden" id="mode"		name="mode" 	value="${mode}"/>
	<input type="hidden" id="mode2" 	name="mode2" 	value=""/>
    <input type="hidden" name="categoreyList" value="${categoreyList }"/>
    <input type="hidden" name="SM_WDATE_FROM"         value="${paging.SM_WDATE_FROM }"/>
    <input type="hidden" name="SM_WDATE_TO"         value="${paging.SM_WDATE_TO }"/>
    <input type="hidden" name="pageNo"        value="${paging.pageNo }"/>
    <input type="hidden" name="s1"            value='<c:out value="${paging.s1}" />'>
    <input type="hidden" name="s2"            value='<c:out value="${paging.s2}" />'>
    <input type="hidden" name="s3"            value='<c:out value="${paging.s3}" />'>
    <input type="hidden" name="s4"            value='<c:out value="${paging.s4}" />'>
</form>
</body>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>     
<script type="text/javascript">

var SM_SVC2 = '${SM_SVC2}';
var html = '';
var SCT_ORIGQTY = ${SCT_ORIGQTY};
var SM_LSTATE = ${SM_LSTATE};
var mdate = parseInt(SCT_ORIGQTY / 60);
var sdate = parseInt(SCT_ORIGQTY % 60);
var SCT_ORIGTEXT = '${SCT_ORIGTEXT}';

$(document).ready(function() {
	
	if(SM_LSTATE == '3093'){
		if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
			html = inputType();
		}else if(SM_SVC2 == '3081' || SM_SVC2 == '3082'){
			html = inputType1();
		}else{
			html = inputType2();
		}
		$('#change_unit2').append(html);
	}
	if(SM_LSTATE == '3094' || SM_LSTATE == '3099'){
		if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
			html = valueType();
		}else if(SM_SVC2 == '3081' || SM_SVC2 == '3082'){
			html = valueType1();
		}else{
			html = valueType2();
		}
		$('#change_unit2').append(html);
	}
	if(SM_LSTATE == '3099'){
		if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
			html = inputType();
		}else if(SM_SVC2 == '3081' || SM_SVC2 == '3082'){
			html = inputType1();
		}else{
			html = inputType2();
		}
		$('#change_unit3').append(html);
	}
	if(SM_LSTATE == '3095'){
		if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
			html = valueType();
		}else if(SM_SVC2 == '3081' || SM_SVC2 == '3082'){
			html = valueType1();
		}else{
			html = valueType2();
		}
		$('#change_unit3').append(html);
	}
	

	$('.schword').keydown(function(key){
		if(key.keyCode == 13){
			$(this).siblings('.schbtn').trigger('click');
		}
	})
});

function inputType(){
	var html = '';
	html += '<input type="hidden" id="SCT_ORIGQTY" name="SCT_ORIGQTY" style="width:160px;" value="">';
	html += '<select style="width: 60px;" name="SM_AMOUNT_MM" id=\"timeMM">';
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
	return html;
}

function inputType1(){
	var html = '';
	html += '<input type="text" id="SCT_ORIGQTY" name="SCT_ORIGQTY" style="width:160px;" value="" onkeyup="$(this).val($(this).val().replace(/[^0-9]/g,\'\'));">';
	html += '&nbsp 매수';
	return html;
}
function inputType2(){
	var html = '';
	html += '<input type="text" id="SCT_ORIGTEXT" name="SCT_ORIGTEXT" style="width:160px;" value="">';
	return html;
}

function valueType(){
	var html = '';
	if(mdate != 0 && sdate != 0){
		html += mdate
		html += ' 분 ';
		html += sdate
		html += ' 초';
	}
	return html;
}

function valueType1(){
	var html = '';
	if(SCT_ORIGQTY != 0){
		html += SCT_ORIGQTY;
		html += ' 매수';
	}
	return html;
}

function valueType2(){
	var html = '';
	if(SCT_ORIGTEXT != ''){
		html += SCT_ORIGTEXT;
	}
	return html;
}


/* 신청자 서비스신청목록 변경에 따른 동적  UI*/
$('input:radio[name="SM_SVC2"]').change(function (){
	$('#change_unit').empty();
	var radioVal = $('input:radio[name="SM_SVC2"]:checked').val();
	
	var html = "";
	
	if(radioVal == '3081' || radioVal == '3082'){
		html += '<input type=\"text\" id=\"SM_AMOUNT\" name=\"SM_AMOUNT\" style=\"width:160px;\" value="">';
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
		html += '<input type=\"text\" id=\"MULTIPAGE\" name=\"MULTIPAGE\" style=\"width:160px;\" value="">';
	}
	$('#change_unit').append(html);	
})


$(".schbtn").click(function(e) {
	searchMember(e, this);
});

function doUpdate(val){
	var obj = $('#frm_reception .must-option')
	html = '';
	html += '<input type="hidden" id="SCT_ORIGQTY" name="SCT_ORIGQTY" style="width:160px;" value="">';
	html += '<select style="width: 60px;" name="SM_AMOUNT_MM" id=\"timeMM">';
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
}

/* 작업자 승인 */
function funAppProc(smNo, status , seq){
	if(confirm('승인하시겠습니까?')){
		$.ajax({
			url : '/contentsApprove.do',
			type : 'post',
			data : {'SM_NO' : smNo, 'allow': status, 'SHSEQNUM': seq},
			success : function(data) {
				if(data == 'success'){
					alert('승인되었습니다.');
					$("#SHSEQNUM").val();
					$("#FormDetail").attr("action", "/contentsDetail.do");
					$("#FormDetail").attr("onSubmit", "");
					$("#FormDetail").submit();
					$("#FormDetail").attr("onSubmit", "return false;");
				}
			}
		});
	}
}

/* 작업자 추가입력사항 등록 */
function doConfirm(){
	var SM_SEQ = ${SM_SEQ};
	
	if(SM_SVC2 == '3081'|| SM_SVC2 == '3082'){
		$('#SCT_ORIGQTY').val();
	}else if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
		var SCT_ORIGQTY = parseInt($("#timeMM").val()) * 60 + parseInt($("#timeSS").val());
		$('#SCT_ORIGQTY').val(SCT_ORIGQTY);
	}else{
		$('#SCT_ORIGTEXT').val();
	}
	
	if ($("#SCT_allow1EMP").val() == '' || $("#SCT_allow1EMP").val() == 0) {
		alert("담당자를 선택 하세요.");
		return false;
	}
	if ($("#SCT_allow2EMP").val() == '' || $("#SCT_allow2EMP").val() == 0) {
		alert("파트장를 선택 하세요.");
		return false;
	}
	if ($("#SCT_ORIGQTY").val() == '' || $("#SCT_ORIGQTY").val() == 0 || $('#SCT_ORIGTEXT').val() == '') {
		alert("완료예정 작업수량을 입력 하십시오.");
		return false;
	}
	if($("#SCT_worker").val() == ''){
		alert("작업자를 입력 하십시오.");
		return false;
	}
	var params = {
			'SCT_ORIGQTY':$("#SCT_ORIGQTY").val(),
			'SCT_ORIGTEXT':$("#SCT_ORIGTEXT").val(),
			'SCT_allow1EMP':$("#SCT_allow1EMP").val(),
			'SCT_allow1NM':$("#SCT_allow1NM").val(),
			'SCT_allow1DEPT':$("#SCT_allow1DEPT").val(),
			'SCT_allow1DEPTNM':$("#SCT_allow1DEPTNM").val(),
			'SCT_allow2EMP':$("#SCT_allow2EMP").val(),
			'SCT_allow2NM':$("#SCT_allow2NM").val(),
			'SCT_allow2DEPT':$("#SCT_allow2DEPT").val(),
			'SCT_allow2DEPTNM':$("#SCT_allow2DEPTNM").val(),
			'SCT_TDATE':$("input[name='SCT_TDATE']").val(),
			'SCT_ORIGTYPE':SM_SVC2,
			'SM_LSTATE':'3094',
			'SM_MEMPNO':$("input[name='SM_MEMPNO']").val(),
			'SM_NO':$("input[name='SM_NO']").val(),
			'SM_SEQ' : SM_SEQ,
			'SHSEQNUM' : SM_SEQ,
			'SCT_worker' : $("#SCT_worker").val()
	}
	if(confirm('접수하시겠습니까?')){
		$.ajax({
			type:"POST",
			url:"/modifyConfirmAjax.do",
			data : params,
			dataType : "json",
			success: function(result){
				if(result == true ){
					alert('접수 되었습니다.');
					$("#SHSEQNUM").val();
					$("#FormDetail").attr("action", "/contentsDetail.do");
					$("#FormDetail").attr("onSubmit", "");
					$("#FormDetail").submit();
					$("#FormDetail").attr("onSubmit", "return false;");
				}else{
					alert("관리자에게 문의하세요.");
				}
			},
			error: function(xhr, status, error) {
				alert(error);
			}
		})
	}
}


/* 결재자, 최종결재자 조회 */
function searchMember(e, this_obj){
	
	e.preventDefault();

    var obj = $(this_obj);
    var schword = obj.siblings('.schword');

    /* if( !$.trim(schword.val()) )
    {
        alert('이름/사번을 입력하여 주십시요.');
        schword.focus();
        return false;
    } */

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

/* 완료파일 저장 */
function doComplete(seq){
	if(SM_SVC2 == '3081'|| SM_SVC2 == '3082'){
		$('#SCT_ORIGQTY').val();
	}else if(SM_SVC2 == '3079' || SM_SVC2 == '3080'){
		var SCT_ORIGQTY = parseInt($("#timeMM").val()) * 60 + parseInt($("#timeSS").val());
		$('#SCT_ORIGQTY').val(SCT_ORIGQTY);
	}
	
	if ($("#SCT_ORIGQTY").val() == '' || $("#SCT_ORIGQTY").val() == 0) {
		alert("완료작업 수량을 입력 하십시오.");
		return false;
	}
	
	if ($("input[name='SCT_TDATE']").val() == '' || $("input[name='SCT_TDATE']").val() == null) {
		alert("완료일을 입력 하십시오.");
		return false;
	}
	if ($("#fileSeq_4").val() == '' || $("#fileSeq_4").val() == null) {
		alert("완료된 첨부파일을 등록하십시오.");
		return false;
	}
	
	var params = {
			'SCT_ORIGQTY':$("#SCT_ORIGQTY").val(),
			'SCT_ORIGTEXT': $("#SCT_ORIGTEXT").val(),
			'SCT_ORIGTYPE':SM_SVC2,
			'fileSeq_4':$("#fileSeq_4").val(),
			'SM_MEMPNO':$("input[name='SM_MEMPNO']").val(),
			'SM_NO':$("input[name='SM_NO']").val(),
			'SCT_TDATE':$("input[name='SCT_TDATE']").val(),
			'SHSEQNUM':seq
	}
	
	$.ajax({
		type:"POST",
		url:"/completeFile.do",
		data : params,
		dataType : "json",
		success: function(result){
			if(result == true ){
				alert("완료 되었습니다.");
				$("#SHSEQNUM").val();
				$("#FormDetail").attr("action", "/contentsDetail.do");
				$("#FormDetail").attr("onSubmit", "");
				$("#FormDetail").submit();
				$("#FormDetail").attr("onSubmit", "return false;");
			}else{
				alert("관리자에게 문의하세요.");
			}
		},
		error: function(xhr, status, error) {
			alert(error);
		}
	})
}

/* 파일업로드 */
$(document).on('change', ".filebox .upload-hidden",function(){
	
	var ua = window.navigator.userAgent;
	var filesId = $(this)[0].id;
	var inputName = $(this)[0].name;
	var filename  = $(this)[0].files[0].name;
	var subFileId = filesId.substring(5,6);

	var formGubun = '';
	if(subFileId == '4'){
		formGubun = 'frm_complefile';
		$('#complete_file').val(inputName);
	}else{
		formGubun = 'file_frm';
		$('#target_file').val(inputName);
	}
	
	if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
		if(filename != null || filename == ""){
			$('form[name="'+formGubun+'"]').ajaxForm({  
				url: '<%=Constants.CONTENTS_ASP_CALL %>',
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
			    	}else if (subFileId == '3'){
			    		$("#fileSeq_3").val(msg);
			    	}else{
			    		$("#fileSeq_4").val(msg);
			    	}
			    },
			    complete: function(xhr) {
			    },
			    error: function(e){
			    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
			    	/* location.replace(location.href); */
			    }
			})
			$('form[name="'+formGubun+'"]').submit();
		}
		
	}else{
		alert('IE 최신 브라우저에서 사용 가능합니다.');
	}
})
function userSetData(arr) {
    
	if ($('.schword').eq(arr.key).siblings().hasClass('appeno')) {
        $("input[name='deptno']").val(arr.deptno);
        $("input[name='appeno']").val(arr.empno);
        $("input[name='appenm']").val(arr.name);
        $("input[name='appss']").val(arr.dept_nm);
        $("input[name='apptel']").val(arr.telno);
        $("input[name='appmail']").val(arr.empno + '@kepco.co.kr');
    } else if ($('.schword').eq(arr.key).siblings().hasClass('mngAllow')) {
        $("input[name='SCT_allow1EMP']").val(arr.empno);
        $("input[name='SCT_allow1NM']").val(arr.name);
        $("input[name='SCT_allow1DEPT']").val(arr.deptno);
        $("input[name='SCT_allow1DEPTNM']").val(arr.dept_nm);
    } else if ($('.schword').eq(arr.key).siblings().hasClass('finalMngAllow')) {
        $("input[name='SCT_allow2EMP']").val(arr.empno);
        $("input[name='SCT_allow2NM']").val(arr.name);
        $("input[name='SCT_allow2DEPT']").val(arr.deptno);
        $("input[name='SCT_allow2DEPTNM']").val(arr.dept_nm);
    }
	$('.schword').eq(arr.key).val(arr.name);
	
	$('#mem_list_layer').slideUp('fast').remove();
}
/* 파일삭제 */
function godel(val, obj, name){
	var param = {"SCF_SEQ":val};
	var targetId = obj.id;
	var targetName = name;
	var par_temp = $("#"+targetId+"").parent();
	
	var html = '';

	if(confirm('파일을 삭제하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/removeContentsFile.do',
			dataType : 'text',
			data : param,
			success : function(result){
				if(result == 'true'){
					html += '<input class="upload-name" value="파일선택" disabled="disabled">';
					html += '<label for="' + targetId + '"> 업로드</label> ';
					html += '<input class="upload-hidden" name="uploadFile' + targetName + '" id="' + targetId + '" type="file" value="" />';
					html +='<progress id="progressBar_'+targetName+'" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>';
					html +='&nbsp<span id="progressT_'+targetName+'" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_'+targetName+'">0</font>%</span>';
					alert('삭제되었습니다.');
					$("#"+targetId+"").parent().empty();
					par_temp.append(html);
				}else{
					alert('관리자에게 문의하시오.');
				}
			},
			error : function(e){
				alert('error.');
			}
		})
	}
	
}
/* asp파일 다운로드 */
function goDown(val){
	$('#SCF_SEQ').val(val);
	$('#file_frm').attr('action', '<%=Constants.CONTENTS_DOWNLOAD_ASP_CALL %>?SCF_SEQ='+val);
	$('#file_frm').submit();
	return false;
}

var resultNum 	= 0;
var toDay		= new Date();
var toDayOg		= new Date();
var lastDay		= new Date();

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
	var labelname_sub0 = $('#MULTIPAGE').parent().find("span").eq(0);
	var labelname_sub1 = $('#MULTIPAGE').parent().find("span").eq(1);
	if(resultNum == "3079"){
		//매체 변환 
		labelname.text("매체원본추정시간");
		labelname_sub0.text("분");
		labelname_sub1.text("변환 할 매체원본 총 시간을 입력해주세요.");
	}else if(resultNum == "3080"){
		//영상편집
		labelname.text("매체원본추정시간");
		labelname_sub0.text("분");
		labelname_sub1.text("영상편집 할 매체원본 총 시간을 입력해주세요.");
	}else if(resultNum == "3081"){
		//파워포인트 제작 or 문서[파워포인트]제작
		labelname.text("제작 페이지");
		labelname_sub0.text("페이지");
		labelname_sub1.text("파워포인트 제작 할 페이지 분량을 입력해주세요(표지포함)");
	}else if(resultNum == "3082"){
		//이미지 제작 
		labelname.text("이미지 수량");
		labelname_sub0.text("장");
		labelname_sub1.text("이미지제작 할 분량을 입력해주세요.");
	}else if(resultNum == "3083"){
		//한글제작  or 세미나 교육자료 제작
		labelname.text("제작 페이지");
		labelname_sub0.text("페이지");
		labelname_sub1.text("한글 제작 할 페이지 분량을 입력해주세요(표지포함)");
	}else if(resultNum == "3092"){
		//기타
		labelname.text("세부내용");
		labelname_sub0.text("");
		labelname_sub1.text("서비스 세부내용과 작업분량을 입력해주세요");
	}
}

$(document).on('change', ".filebox .upload-hidden" , function(){  // 값이 변경되면
  if(window.FileReader){  // modern browser
    var filename = $(this)[0].files[0].name;
  }else{  // old IE
    var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
  }
  $(this).siblings('.upload-name').val(filename); // 추출한 파일명 삽입
});

/* 신청부분 수정 */
function save(){
	/* 서비스신청에 따른 작업요청 계산 */
	var radioVal = $('input:radio[name="SM_SVC2"]:checked').val();
	if(radioVal == '3081' || radioVal == '3082'){
		$('#SM_AMOUNT').val();
	}else if(radioVal == '3079' || radioVal == '3080'){
		var SM_AMOUNT = parseInt($("#timeMM").val()) * 60 + parseInt($("#timeSS").val());
		$('#SM_AMOUNT').val(SM_AMOUNT);
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
	if (document.frm.SM_TEXT.value == "" ) {
		alert("제작요청 내용을 입력 하십시오.");
		document.frm.SM_TEXT.focus();
		return false;
	}
	if ($("#SM_AMOUNT").val() == '' || $("#SM_AMOUNT").val() == 0 || $("#SM_AMOUNT").val() == undefined) {
		alert("작업요청 수량을 입력 하십시오. \n최소 작업수량은 1매 혹은 1초 이상 선택하십시오.");
		return false;
	}

	if(confirm('수정사항을 저장하시겠습니까?')){
		$('#frm').submit();
	}
}

$(document).ready(function() {
	
	if('${mode}' == 1){
		load_fnc('6', '0', '0'); //menu script
	}else{
    	load_fnc('2', '0', '0'); //menu script
	}
	/* $("#datepicker").datepicker(); */
	$("#datepicker2").datepicker({
		dateFormat: 'yy-mm-dd',
		minDate: 0
	});
	$("#datepicker3").datepicker({
		dateFormat: 'yy-mm-dd',
		minDate: 0
	});
	$("#datepicker4").datepicker({
		dateFormat: 'yy-mm-dd'
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
			$(".workView_btn").hide();
		}else{
			$("#MULTIPAGE").width(100);
			$(".giTaBox").hide();
			$(".workView_btn").show();
		}
		$("#MULTIPAGE").val("");
	});
	 */
	$('#datepicker').change(function(){
		var newDay =  $(this).val();
			newDayArray = newDay.split("-");
			toDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			toDayOg.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
			lastDay.setFullYear(newDayArray[0],newDayArray[1]-1,newDayArray[2]);
	});
	/* 
	$('#MULTIPAGE').change(function(){
		toDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		lastDay.setFullYear(toDayOg.getFullYear(),toDayOg.getMonth(),toDayOg.getDate());
		resultNum = $(this).val();  //입력된 값
		workDayCalculation();
	});
	//수정 페이지 초기화
	var smSvcCodeId = $('input:radio[name="SM_SVC2"]:checked').attr("id");
	 console.log(smSvcCodeId);
	$("#ex_chk_1").click();
	$("#"+smSvcCodeId+"").click();
	
	var SM_SVC2 = "<c:out value='${SM_SVC2}' />";
	if(SM_SVC2 == "3092"){
		$("#MULTIPAGE").width(350);
		$(".giTaBox").show();
		$(".work_input").hide();
		$(".workView_btn").hide();
		multiNum(SM_SVC2);
	}
	 */
});

function doDetail(mode2){
	//0 수정 , 1삭제
	if(mode2 == 0){
		$("#FormDetail").attr("action","/contentsDetail.do");	
		$("#mode2").val(mode2);
		$("#FormDetail").submit();
	}else if(mode2 == 1){
		 if (confirm("취소 하시겠습니까?")) {  
			$("#FormDetail").attr("action","/contentsDel.do");
			$("#mode2").val(mode2);
			$("#FormDetail").submit();
	     } else {  
			return false;
	     } 
	}
}

function goToContPrg() {
    
	if('${mode}' == 1){
		$("#FormDetail").attr("action", "/mypageContentsList.do");
	    $("#FormDetail").submit();
	}else{
        $("#FormDetail").attr("action", "/contentsProgress.do");
        $("#FormDetail").submit();
	}
}

function goPrint(val){
	/* $("#FormDetail").attr("action", "/contentsDetail.do");
	$("#FormDetail").attr("onSubmit", "");
	$("#FormDetail").submit();
	$("#FormDetail").attr("onSubmit", "return false;");
	 */
	var url = "localhost:8080/jsp/contents/approvePrintPage.jsp"
	window.open(url,"","toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=60,left=100");
	
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />